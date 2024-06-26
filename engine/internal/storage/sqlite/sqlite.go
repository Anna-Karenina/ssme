package sqlite

import (
	"context"
	"database/sql"
	"errors"
	"fmt"
	"log"
	"log/slog"
	"strings"

	"github.com/Anna-Karenina/sme-engine/internal/domain/models"
	"github.com/Anna-Karenina/sme-engine/internal/storage"

	"github.com/mattn/go-sqlite3"
)

type Storage struct {
	db  *sql.DB
	log *slog.Logger
}

func New(
	log *slog.Logger,
	storagePath string) (*Storage, error) {
	const op = "storage.sqlite.New"

	db, err := sql.Open("sqlite3", storagePath)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	return &Storage{db: db, log: log}, nil
}

func (s *Storage) Stop() error {
	return s.db.Close()
}

func (s *Storage) Create(ctx context.Context, path string, name string) (*models.Node, error) {
	const op = "storage.sqlite.CreateApp"
	log := s.log.With(slog.String("op", op), slog.String(".path", path), slog.String(".name", name))

	stmt, err := s.db.Prepare("INSERT INTO nodes(path, name) VALUES(?, ?)")
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	res, err := stmt.ExecContext(ctx, path, name)
	if err != nil {
		var sqliteErr sqlite3.Error
		if errors.As(err, &sqliteErr) && sqliteErr.ExtendedCode == sqlite3.ErrConstraintUnique {
			return nil, fmt.Errorf("%s: %w", op, storage.ErrUnknow)
		}

		return nil, fmt.Errorf("%s: %w", op, err)
	}

	id, err := res.LastInsertId()
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	log.Info("node creating success")
	return &models.Node{Path: path, Id: int(id), Name: ""}, nil
}

func (s *Storage) Read(ctx context.Context, id int) (*models.Node, error) {
	const op = "storage.sqlite.Read"
	log := s.log.With(slog.String("op", op), slog.Int("id:", id))
	log.Info("searching node")

	row := s.db.QueryRowContext(ctx, "SELECT id, path, name, cmds, node_version, default_script FROM nodes WHERE id = ?", id)

	var node models.Node
	err := row.Scan(&node.Id, &node.Path, &node.Name, &node.Scripts, &node.NodeJsVersion, &node.DefaultScript)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, fmt.Errorf("%s: %w", op, storage.ErrNodeNotFound)
		}
		return nil, fmt.Errorf("%s: %w", op, err)
	}
	node.Scripts = strings.Split(node.Scripts[0], ", ")
	log.Info("find node")
	return &node, nil
}

func (s *Storage) Update(ctx context.Context, in *models.Node) (*models.Node, error) {
	const op = "storage.sqlite.Update"
	log := s.log.With(
		slog.String("op", op),
		slog.String(".version", in.NodeJsVersion),
		slog.String(".scripts", strings.Join(in.Scripts, ", ")),
		slog.String(".default srcipt", in.DefaultScript))

	log.Info("try update node")

	_, err := s.db.ExecContext(ctx, `UPDATE nodes SET cmds = json_array(?) , node_version = ? , default_script = ?  WHERE id = ?`, strings.Join(in.Scripts, ", "), in.NodeJsVersion, in.DefaultScript, in.Id)
	if err != nil {
		return nil, fmt.Errorf("%s: %w", op, err)
	}

	log.Info("node updated success")

	row := s.db.QueryRowContext(ctx, "SELECT id, path, name, cmds, default_script FROM nodes WHERE id = ?", in.Id)

	var node models.Node
	err = row.Scan(&node.Id, &node.Path, &node.Name, &node.Scripts, &node.DefaultScript)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, fmt.Errorf("%s: %w", op, storage.ErrNodeNotFound)
		}
		return nil, fmt.Errorf("%s: %w", op, err)
	}
	node.Scripts = strings.Split(node.Scripts[0], ", ")
	return &node, nil
}

func (s *Storage) GetAllApps(ctx context.Context) ([]*models.Node, error) {
	const op = "storage.sqlite.ReadAllApps"
	var nodes []*models.Node

	rows, err := s.db.Query("SELECT id, name, path, cmds, node_version, default_script FROM `nodes`")

	if err != nil {
		return nil, storage.ErrWrongRowParams
	}

	for rows.Next() {
		var node models.Node

		if err := rows.Scan(&node.Id, &node.Name, &node.Path, &node.Scripts, &node.NodeJsVersion, &node.DefaultScript); err != nil {
			log.Println(err.Error())
		}
		log.Println(op, node)
		node.Scripts = strings.Split(node.Scripts[0], ", ")
		nodes = append(nodes, &node)
	}
	return nodes, nil
}

func (s *Storage) InternalGetNodeById(ctx context.Context, id int) (*models.Node, error) {
	const op = "storage.sqlite.InternalGetNodeById"
	log := s.log.With(slog.String("op", op), slog.Int("id:", id))
	log.Info("searching node...")

	row := s.db.QueryRowContext(ctx, "SELECT id, path, name, cmds, node_version, default_script FROM nodes WHERE id = ?", id)
	var node models.Node
	err := row.Scan(&node.Id, &node.Path, &node.Name, &node.Scripts, &node.NodeJsVersion, &node.DefaultScript)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, fmt.Errorf("%s: %w", op, storage.ErrNodeNotFound)
		}
		return nil, fmt.Errorf("%s: %w", op, err)
	}
	node.Scripts = strings.Split(node.Scripts[0], ", ")
	log.Info("find node")
	return &node, nil
}

package appsruntime

type ID = int

type AppsStorage struct {
	Apps map[ID]*AppRuntime
}

func NewAppsStorage() *AppsStorage {
	i := make(map[ID]*AppRuntime)
	s := AppsStorage{Apps: i}
	return &s
}

func (as *AppsStorage) Create(id ID, data *AppRuntime) bool {
	as.Apps[id] = data
	return true
}

func (as *AppsStorage) Read(id ID) (*AppRuntime, error) {
	return as.Apps[id], nil
}

func (as *AppsStorage) Update() {

}

func (as *AppsStorage) Delete(id ID) bool {
	delete(as.Apps, id)
	return true
}

// @generated automatically by Diesel CLI.

diesel::table! {
    intalled_nodes (id) {
        id -> Integer,
        version -> Text,
    }
}

diesel::table! {
    projects (id) {
        id -> Integer,
        name -> Text,
        path -> Text,
        scripts -> Nullable<Text>,
        node_version -> Nullable<Text>,
        default_script -> Nullable<Text>,
        is_app_valid -> Bool,
        created_at -> Timestamp,
    }
}

diesel::allow_tables_to_appear_in_same_query!(
    intalled_nodes,
    projects,
);

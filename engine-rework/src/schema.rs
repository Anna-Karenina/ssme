// @generated automatically by Diesel CLI.

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

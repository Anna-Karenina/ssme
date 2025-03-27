use serde::{Deserialize, Deserializer};

pub fn deserialize_lts<'de, D>(deserializer: D) -> Result<bool, D::Error>
where
    D: Deserializer<'de>,
{
    use serde::de::{Error, Unexpected};

    let v = serde_json::Value::deserialize(deserializer)?;
    match v {
        serde_json::Value::Bool(b) => Ok(b), // Если bool — возвращаем как есть
        serde_json::Value::Number(_) => Ok(false), // Если число — считаем, что false
        serde_json::Value::String(_) => Ok(true), // Если строка — считаем, что true
        serde_json::Value::Null => Ok(false), // null -> false
        _ => Err(D::Error::invalid_type(
            Unexpected::Other("не bool или строка"),
            &"bool или строку",
        )),
    }
}

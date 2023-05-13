Select = "SELECT"
Update = "UPDATE"
Delete = "DELETE"
Insert = "INSERT"
Eq = "="
Ne = "!="
Gt = ">"
Lt = "<"
Gte = ">="
Lte = "<="

# Steps
STEP_SELECT = "step_select"
STEP_FROM = "step_from"
STEP_FROM_TABLE = "step_from_table"

SELECT_ALL_OPERATOR = "*"
FROM_CLAUSE = "FROM"

SCRATCHDB_TOKENS_TYPE = [
  Select,
  Update,
  Delete,
  Insert,
]

SCRATCHDB_OPERATOR_TOKENS = [ 
  Eq,
  Ne,
  Gt,
  Lt,
  Gte,
  Lte
]

STRING_MATCH_REGEX = /(?:[^"\\]|\\.)*/
COMMA_SEPRATED_STRING_MATCH_REGEX =  /\A\s*([^,\s]+(?:\s*,\s*[^,\s]+)*)\s*\z/

.PHONY: generate_diesel_schema
generate_diesel_schema: 
	diesel print-schema > src/persistence/schema.rs

.PHONY: diesel_mig_run
diesel_mig_run: 
	diesel migration run

.PHONY: diesel_mig_revert
diesel_mig_revert: 
	diesel migration revert
	





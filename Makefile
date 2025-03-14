codegen:
	@echo 'make build code generation'
	@dart pub run build_runner build --delete-conflicting-outputs

codegen-no-delete:
	@echo 'make codegen without deleting conflicting outputs'
	@dart pub run build_runner build

codegen-watch:
	@echo 'run watch code generation'
	@dart pub run build_runner watch

generate-icon:
	@echo 'Generate Launcher Icon'
	@dart run flutter_launcher_icons -f flutter_launcher_icons.yaml
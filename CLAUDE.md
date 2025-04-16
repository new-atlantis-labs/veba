# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build and Test Commands
- Activate main environment: `source activate VEBA`
- Run a module: `veba --module <module_name> --params "<PARAMS>"`
- Module-specific syntax: `source activate VEBA-<module>_env; <module>.py "<PARAMS>"`
- Install: `install/install.sh [log_directory] [conda_envs_path]`
- Download databases: `install/download_databases.sh`
- Docker build: `install/docker/build_docker_image.sh`

## Code Style Guidelines
- Python: Use snake_case for variables/functions, PascalCase for classes
- Import order: stdlib, third-party, local (soothsayer_utils, genopype, etc.)
- Version format: YYYY.MM.DD at top of files as `__version__`
- Error handling: Use try/except blocks with specific error types
- Documentation: Add descriptive comments for complex operations
- Formatting: Use 4-space indentation
- Scripts: Make Python scripts executable with shebang and proper permissions
- Follow the GenoPype architecture for workflow organization

## Module Dependency Documentation
When documenting a module's dependencies, follow the guidelines in `docs/dependencies.md` and create a Markdown file at `docs/dependencies/<module-name>.md` with this structure:

1. **Overview**: Brief description of the module's purpose
2. **Core Python Dependencies**: Essential Python libraries used
3. **External Tools**: Third-party tools the module relies on
4. **Databases**: Reference databases required by the module
5. **Environment Details**: Conda environment specifications with versions
6. **Pipeline Process**: Step-by-step workflow overview
7. **Requirements**: Additional requirements or constraints
8. **Usage**: Basic command examples
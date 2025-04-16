# VEBA Module Dependencies Documentation Guide

This document provides guidelines for documenting the dependencies of each VEBA module. The documentation should be comprehensive yet concise, highlighting all critical dependencies and their roles in the module's functionality.

## Documentation Structure

Each module's dependencies should be documented in a separate Markdown file located at `docs/dependencies/<module-name>.md` and should follow this structure:

1. **Overview**: Brief description of the module's purpose and functionality
2. **Core Python Dependencies**: Essential Python libraries used by the module
3. **External Tools**: Third-party applications and tools that the module relies on
4. **Databases**: Reference databases required by the module
5. **Environment Details**: Conda environment specifications with version numbers
6. **Pipeline Process**: Step-by-step overview of the module's workflow
7. **Requirements**: Additional requirements or constraints for the module
8. **Usage**: Basic usage examples

## Template

```markdown
# VEBA <Module-Name> Module Dependencies

## Overview
Brief description of what the module does and its primary purpose.

## Core Python Dependencies
- **Category**: Specific libraries (with roles if not obvious)
- **Category**: Specific libraries

## External Tools
- **Tool Name**: Brief description of purpose
- **Tool Name**: Brief description of purpose

## Databases
- **Database Name**: Purpose and version info (if available)
- **Database Name**: Purpose and version info (if available)

## Environment Details
The module requires a specific conda environment (`VEBA-<module>_env`):

### Main Packages
- package1=version
- package2=version

### Custom Tools (if applicable)
- custom_tool1==version
- custom_tool2==version

## Pipeline Process
1. **Step 1**: Brief description
2. **Step 2**: Brief description
3. **Step 3**: Brief description

## Requirements
- Any special requirements or constraints
- Hardware recommendations (if applicable)

## Usage
```bash
source activate VEBA-<module>_env
<module>.py <required_args> [options]
```
```

## Documentation Process

When documenting a module's dependencies:

1. **Analyze the module script**: Examine the main Python script to identify imported libraries, external tool calls, and database references
2. **Check the environment file**: Review the corresponding environment YAML file in `install/environments/` for exact package versions
3. **Identify key processes**: Outline the main steps in the module's workflow
4. **Document external dependencies**: List all non-Python dependencies like databases or external programs
5. **Specify version requirements**: Include version numbers for critical components
6. **Document usage patterns**: Include basic usage examples

## Updating Dependencies

When module dependencies change:

1. Update the corresponding `docs/dependencies/<module-name>.md` file
2. Document any breaking changes or new requirements
3. Update the module's environment file in `install/environments/`
4. Test the module with the updated dependencies
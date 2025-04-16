# VEBA Dependency Graph Visualization

This document provides instructions for creating, maintaining, and visualizing the VEBA module dependency graph using Graphviz.

## Overview

The VEBA dependency graph (`docs/dependencies/dependencies.gv`) is a Graphviz representation of all VEBA modules and their dependencies, including:

- Module relationships
- Conda environments
- Core Python libraries
- External tools
- Databases

The graph provides a visual representation of the VEBA workflow structure and helps users understand dependencies between different components.

## Visualization

### Generating the Graph Image

To convert the `.gv` file to a visual representation, use one of the following methods:

#### Using Graphviz command-line tools:

```bash
# Generate PNG
dot -Tpng docs/dependencies/dependencies.gv -o docs/dependencies/dependencies.png

# Generate SVG (better for web use and zooming)
dot -Tsvg docs/dependencies/dependencies.gv -o docs/dependencies/dependencies.svg

# Generate PDF (for high-quality print)
dot -Tpdf docs/dependencies/dependencies.gv -o docs/dependencies/dependencies.pdf
```

#### Using online Graphviz tools:

You can paste the contents of the `.gv` file into online tools such as:
- [Graphviz Online](https://dreampuf.github.io/GraphvizOnline/)
- [Edotor](https://edotor.net/)
- [Viz-js](http://viz-js.com/)

## Graph Structure

The dependency graph uses different visual elements to distinguish between types of components:

- **Modules** (blue boxes): VEBA workflow modules
- **Environments** (orange ellipses): Conda environments
- **Python Libraries** (green components): Core Python dependencies
- **External Tools** (purple rounded boxes): Third-party tools used by modules
- **Databases** (yellow cylinders): Reference databases 

Relationships between components are represented by directed edges:
- Standard black edges show dependency relationships
- Red edges with thicker lines show module workflow connections

## Updating the Graph

When adding a new module or updating dependencies:

1. Create or update the module's dependency documentation in `docs/dependencies/<module-name>.md`
2. Edit `docs/dependencies/dependencies.gv` to include:
   - The new module node
   - Environment relationship
   - Python library dependencies
   - External tool dependencies
   - Database dependencies
   - Workflow connections to other modules

### Adding a New Module

To add a new module to the graph:

1. Add the module node in the modules section:
   ```
   new_module [label="new-module"];
   ```

2. Add the module's environment:
   ```
   VEBA_new_module_env [label="VEBA-new-module_env"];
   ```

3. Add relationships:
   ```
   // Module to Environment
   new_module -> VEBA_new_module_env;
   
   // Module to Python Libraries
   new_module -> {lib1 lib2 lib3};
   
   // Module to External Tools
   new_module -> {tool1 tool2 tool3};
   
   // Module to Databases
   new_module -> {db1 db2};
   
   // Workflow connections (if applicable)
   other_module -> new_module;
   new_module -> another_module;
   ```

## Format Recommendations

- Keep node labels concise
- Use consistent naming patterns (snake_case for node IDs, human-readable labels)
- Group related nodes together
- Add comments to sections for clarity
- Use the established color scheme for consistency

## Best Practices

- Update the graph when adding new modules or changing significant dependencies
- Regenerate visualization files after graph updates
- For complex changes, test the graph in an online tool before committing
- Keep the `.gv` file well-formatted and commented for maintainability

## Additional Customization

The graph can be further customized with Graphviz attributes:

- Change `rankdir` to adjust layout direction
- Modify `nodesep` and `ranksep` to adjust spacing
- Adjust node styles, colors, and shapes for better visualization
- Create subgraphs to cluster related components

## References

- [Graphviz Documentation](https://graphviz.org/documentation/)
- [DOT Language Guide](https://graphviz.org/doc/info/lang.html)
- [Node Shapes Reference](https://graphviz.org/doc/info/shapes.html)
- [Edge Attributes](https://graphviz.org/doc/info/attrs.html#d:edge)
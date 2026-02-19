# Contributing to dfree

First off, thanks for taking the time to contribute! :tada:

The following is a set of guidelines for contributing to `dfree`. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## How Can I Contribute?

### Reporting Bugs

This section guides you through submitting a bug report for `dfree`. Following these guidelines helps maintainers and the community understand your report :pencil:, reproduce the behavior :computer:, and find related reports :mag_right:.

-   **Use a clear and descriptive title** for the issue to identify the problem.
-   **Describe the exact steps which reproduce the problem** in as much detail as possible.
-   **Provide specific examples to demonstrate the steps**. Include links to files or GitHub projects, or copy/pasteable snippets, which you use in those examples.

### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for `dfree`, including completely new features and minor improvements to existing functionality.

-   **Use a clear and descriptive title** for the issue to identify the suggestion.
-   **Provide a step-by-step description of the suggested enhancement** in as much detail as possible.
-   **Explain why this enhancement would be useful** to most `dfree` users.

### Pull Requests

-   Fill in the required template
-   Do not include issue numbers in the PR title
-   Include screenshots and animated GIFs in your pull request whenever possible.
-   Follow the ShellCheck analysis results.

## Styleguides

### Shell Styleguide

-   We use `shellcheck` to lint our scripts.
-   We follow the Google Shell Style Guide where possible.
-   We use Hexagonal Architecture. Please respect the layer boundaries (Core, Ports, Adapters).

### Formatting & Linting

We use [pre-commit](https://pre-commit.com/) to ensure code quality.

1.  **Install pre-commit**:
    ```bash
    pip install pre-commit
    pre-commit install
    ```

2.  **Manual Formatting**:
    You can also run the formatter manually:
    ```bash
    ./scripts/dev/format.sh
    ```

## License

By contributing to `dfree`, you agree that your contributions will be licensed under its MIT License.

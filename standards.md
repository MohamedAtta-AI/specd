# Engineering Standards

## General Principles
- Write clear, maintainable, modular code
- Favor simplicity over unnecessary complexity
- Avoid hidden side effects and implicit behavior
- Ensure major functionality is testable
- Keep behavior deterministic where possible

## Architecture
- Separate concerns across layers and modules
- Avoid tight coupling
- Prefer clear interfaces between components
- Keep responsibilities well-bounded

## Project Structure
- Organize code by feature or domain where appropriate
- Maintain a predictable and consistent structure
- Keep configuration separate from core logic
- Avoid unnecessary directory nesting

## Naming Conventions
- Use descriptive and consistent names
- Avoid unclear abbreviations unless widely understood
- Follow language-appropriate naming conventions consistently

## Error Handling
- Handle expected failures explicitly
- Return meaningful error messages
- Avoid silent failures
- Log important errors with enough context for diagnosis

## Validation
- Validate external inputs at boundaries
- Enforce schema or contract validation where applicable
- Reject malformed or unsafe data early

## Logging and Observability
- Log important system events and failures
- Avoid logging sensitive data
- Prefer structured logging where practical

## Testing
- Cover critical logic with automated tests
- Include unit tests and integration tests where appropriate
- Keep tests deterministic and maintainable

## Linting and Formatting
- Enforce consistent formatting
- Require code to pass linting checks before merge
- Use standard tooling appropriate for the chosen stack

## Documentation
- Document important modules, flows, and public interfaces
- Keep documentation aligned with implementation
- Record assumptions and major decisions clearly when relevant
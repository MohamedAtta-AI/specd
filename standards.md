# Engineering Standards

## General Principles
- Write clear, maintainable, modular code
- Favor simplicity; avoid unnecessary complexity
- Avoid hidden side effects and implicit behavior
- Keep behavior deterministic where possible
- Ensure major functionality is testable

## Architecture
- Separate concerns across layers and modules
- Avoid tight coupling; prefer clear interfaces between components
- Keep responsibilities well-bounded per component or service

## Project Structure
- Organize by feature or domain where appropriate
- Keep configuration separate from core logic
- Maintain a predictable, consistent structure; avoid unnecessary nesting

## Naming Conventions
- Use descriptive, consistent names; avoid unclear abbreviations
- Follow language-appropriate conventions (e.g. camelCase, PascalCase, snake_case)

## Error Handling & Validation
- Handle expected failures explicitly; avoid silent failures
- Return meaningful error messages with enough context for diagnosis
- Validate and sanitize all external inputs at system boundaries; reject malformed data early
- Enforce schema or contract validation where applicable

## Secrets & Security
- Never hardcode secrets, tokens, or credentials — use environment variables or a secrets manager
- Do not log sensitive data (PII, tokens, passwords)
- Apply least-privilege to service accounts and API keys
- Use HTTPS; verify TLS in outbound HTTP clients
- Do not expose internal error details in API or UI responses

## API Design
- Use noun-based, plural, kebab-case resource paths (e.g. `/v1/user-profiles`)
- Version APIs from the start (`/v1/`)
- Return standard HTTP status codes
- Always return structured error responses: `{ "code": "...", "message": "..." }`

## Logging & Observability
- Log important system events and failures with structured output
- Avoid logging sensitive data
- Include enough context in log entries for diagnosis

## Testing
- Cover critical logic with automated tests
- Include unit and integration tests where appropriate
- Keep tests deterministic and maintainable

## Linting & Formatting
- Enforce consistent formatting; require linting to pass before merge
- Use standard tooling appropriate for the chosen stack

## Documentation
- Document important modules, flows, and public interfaces
- Keep documentation aligned with implementation
- Record key assumptions and architectural decisions

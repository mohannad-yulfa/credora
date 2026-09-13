# Credora – Clean Architecture + MVVM

The supplied `lib` was primarily presentation code: screens, widgets, local UI state and static data. No API client, database data source, service layer, or existing repository/use-case implementation was present in the supplied archive.

## Structure

- `core/`: app-wide architecture, theme, utilities and reusable widgets.
- `features/<feature>/presentation/`: Views and ViewModels.
- `features/<feature>/domain/`: entities, repository contracts and use cases.
- `features/<feature>/data/`: reserved for data sources/models/repository implementations when real data access is introduced.

The existing UI classes and behavior were preserved rather than rewritten. This avoids silently changing navigation, animations, dimensions or interaction behavior. New domain contracts/ViewModels provide the dependency direction for subsequent extraction of screen logic.

## Dependency direction

`Presentation -> Domain <- Data`

Views should depend on ViewModels, ViewModels should call use cases, use cases depend on repository interfaces, and data implementations depend on those interfaces.

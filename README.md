# Flutter Template

A new Flutter Template attempts to provides some best practices, while avoiding weighing in on
business logic.

The Flutter Blueprint Template is a starter project designed to provide developers with a
well-structured foundation for building scalable, maintainable, and efficient Flutter applications.
It follows best practices in architecture and design, including:

- ### Modular Project Structure:

  Organized into core layers (presentation, business logic, data, and domain) to ensure easy scaling
  and separation of concerns.

- ### State Management:

  Built-in state management using the Bloc pattern or Provider, depending on the developer's
  preference.

- ### Localization Support:

  Easily customizable multi-language support using Flutter's localization libraries.

- ### Dependency Injection:

  Preconfigured with popular libraries like get_it for dependency injection.

- ### Responsive Design:

  Out-of-the-box support for responsive layouts across different screen sizes and devices.

- ### Routing and Navigation:

  Simplified routing with auto_route for nested and complex navigation flows.

- ### Theming:

  Dark mode and light mode support with customizable themes.

- ### Settings:

  Pre-built settings page with toggles for themes, language preferences, and other customizable
  options.

- ### Restoration:

  Providing a restorationScopeId allows the Navigator built by the MaterialApp to restore the
  navigation stack when a user leaves and returns to the app after it has been killed while running
  in the background.

- ### Testing Integration:

  Unit, widget, and integration testing setup to encourage a test-driven development approach.

This blueprint aims to reduce setup time for new projects and ensure developers have a strong base
to create feature-rich Flutter applications with clean, maintainable code.

## Project Structure

The project structure follows a common Flutter project layout:

```
├── android/
├── assets/
├── ios/
├── lib/
  ├── src/
     ── blocs/
        ── authorization/
        ── login/
        ── register/
     ── data/
        ── apis/
        ── http/
        ── mocks/
        ── models/
        ── repositories/
     ── l10n/
     ── ui/
        ── common/
        ── sample_feature/
           ── widgets/
           ── sample_feature_view.dart
  ├──  app.dart
  ├──  injector.dart
  ├──  environment
```

### Environments

Place the env files like `config.dart, google-services.json, GoogleService.plist` inside
respective `env/<dev|prod>`
folder.

And you can run `make set-env-dev | make set-env-prod` in terminal to set the required environment
files.

## Usage

You can start building your Flutter application on top of this template project. Modify or replace
the existing code to fit your application's requirements. The template project provides an example
structure and initial code to get you started quickly.

## Testing

The `test/` directory contains files and examples to help you write tests for your Flutter
application. It is recommended to follow good testing practices and write unit, integration, and
widget tests to ensure the stability and correctness of your code.

## Contributing

Contributions are welcome! If you have any ideas, suggestions, or bug reports, please open an issue
on the GitHub repository. If you'd like to contribute code, you can fork the repository, create a
new branch, make your changes, and submit a pull request.

Please make sure to follow the existing coding style and conventions in the project.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgments

- This project was inspired by the need for a starter template for Flutter projects.
- Special thanks to the Flutter community for their valuable contributions and support.
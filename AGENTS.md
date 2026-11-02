# Project guidance

## Purpose and scope

Personal Expense Tracking and Visualization System is a three-month course
project written in C++ with Qt. The agreed features are:

- Add, edit, and delete expenses: amount, date, category, and description.
- Store expenses locally using SQLite.
- Filter expenses by date and category.
- Visualize category spending, monthly comparisons, and spending over time.

Keep work within these features unless the user expands the scope.

## Current phase

This repository is a scaffold. The user has requested folders, build setup,
and project guidance only. Until the user asks for implementation, limit changes
to structure, configuration, and documentation. Do not create application source
files, headers, UI forms, QML views, database schemas, or sample application logic.

## Stack and structure

- C++17, Qt 6.8 or newer, and CMake 3.21 or newer.
- Qt Widgets for the desktop interface; Qt SQL with the QSQLITE driver for storage.
- Qt Graphs for charts; Qt Quick Widgets for embedding graph views in the UI.
- `src/`: C++ implementation files.
- `include/expense_tracker/`: project headers.
- `ui/`: Qt Designer forms added during implementation.
- `resources/`: images, resource manifests, and graph view assets added later.
- `tests/`: future tests for implemented behavior.
- `CMakeLists.txt` is the build configuration; `Makefile` delegates to CMake.
- Keep source file lists explicit in CMake. Avoid recursive file globbing.

## Implementation guidance for later

- Keep expense data, database access, and spending calculations separate from UI code.
- Prefer small classes and a simple local application architecture.
- Represent money using integer minor units; avoid floating-point storage of money.
- Use Qt date types and unambiguous date storage.
- Use prepared SQL statements with bound values for user input.
- Validate expense input and show clear errors when storage operations fail.
- Use Qt ownership and RAII for resource management.
- Store the runtime database in an appropriate user application-data directory.
- Keep real expense data, database files, generated files, and machine-specific
  Qt paths out of version control.

## Verification

- Follow the setup instructions in `README.md`.
- Configure with `cmake --preset debug` and build with
  `cmake --build --preset debug` once the toolchain is available.
- While source lists are empty, configuration intentionally creates no application
  target and skips Qt discovery. A successful scaffold build does not validate Qt.
- After implementation begins, test monetary totals, category grouping, date
  filtering, month boundaries, and persistence where appropriate.
- Report checks actually performed and any checks blocked by missing tools.

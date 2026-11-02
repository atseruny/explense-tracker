# Personal Expense Tracking and Visualization System

A C++/Qt desktop course project planned for three months.

**Current status:** project structure and build configuration only. There is no
application code, database schema, interface, or executable yet.

The [12-week project pipeline](docs/PROJECT_PLAN.md) covers implementation order,
weekly milestones, acceptance checks, and the final demonstration.

## Planned features

- Add, edit, and delete expenses with amount, date, category, and description.
- Save expenses in a local SQLite database.
- Filter expenses by date and category.
- Show spending by category, monthly comparisons, and spending over time.

## Folder structure

```text
NushikKurs/
|-- src/                      C++ implementation files, currently empty
|-- include/
|   `-- expense_tracker/       Project headers, currently empty
|-- ui/                       Future Qt Designer forms
|-- resources/                Future application and graph view assets
|-- tests/                    Future tests
|-- docs/                     Project pipeline and future course documentation
|-- CMakeLists.txt            C++/Qt build configuration
|-- CMakePresets.json         Debug and release configurations using Ninja
|-- Makefile                  GNU Make shortcuts for CMake
|-- AGENTS.md                 Guidance for future coding agents
`-- README.md
```

Empty folders contain `.gitkeep` placeholders so they can be tracked in Git.

## Stack

- C++17.
- Qt 6.8 or newer.
- Qt Widgets for the desktop interface.
- Qt SQL and its QSQLITE driver for local SQLite storage.
- Qt Graphs for visualizations, with Qt Quick Widgets to embed graph views.
- CMake 3.21 or newer; Ninja for the supplied presets.
- GNU Make is optional; use `mingw32-make` on Windows if that is installed.

The build is prepared for Qt Graphs. Qt documents how to embed its 2D graphs in
a Widgets application in the [Graphs 2D in Qt Widgets example](https://doc.qt.io/qt-6/qtgraphs-2d-quickwidgetgraphs-example.html).

## Qt setup for later

Nothing is installed automatically by this scaffold.

1. Install Qt using the [Qt installer](https://www.qt.io/download-qt-installer-oss).
2. Select a Qt 6.8+ desktop kit and its matching C++ compiler. On Windows, choose
   either a MinGW kit with its matching MinGW compiler or an MSVC kit with the
   matching Visual Studio C++ build tools. Keep the kit and compiler compatible.
3. Include Qt Graphs and Qt Quick support. Ensure Qt Widgets, Qt SQL, Qt Quick
   Widgets, and the QSQLITE driver are available for the chosen kit.
4. Install CMake, Ninja, and optionally Qt Creator through the installer or your
   preferred installation method.

### Qt Creator

Open `CMakeLists.txt` in Qt Creator, select the installed desktop kit, and choose
a build directory under `build/`. Qt Creator can supply the tool and Qt paths
through its selected kit.

### Command line on Windows

Use a terminal where CMake, Ninja, and your matching C++ compiler are available.
For MSVC, use the appropriate Visual Studio developer terminal. For MinGW, make
the selected kit's compiler available on the command path.

Set `QT_ROOT` to your actual Qt desktop kit directory, replacing both placeholders:

```powershell
$env:QT_ROOT = "C:/Qt/<version>/<kit>"
cmake --preset debug
cmake --build --preset debug
```

For release configuration, use `release` in both commands. The presets keep
outputs in `build/debug/` and `build/release/` respectively.

If Qt is installed elsewhere, use that kit directory. This is the directory
containing `bin/`, `include/`, and `lib/`, rather than the Qt installation root.
Changing compilers requires a fresh build directory.

### Makefile shortcuts

The Makefile wraps the same CMake presets and still requires Ninja and a compiler.
With GNU Make installed:

```text
make help
make configure
make build
make build PRESET=release
make clean
```

`QT_ROOT` is also used by these commands. Alternatively, supply
`QT_PREFIX="C:/Qt/<version>/<kit>"` to `make configure` or `make build`.
Use `mingw32-make` in place of `make` when using that Windows executable.
`make clean` requires an existing configured build directory for the selected preset.

## When implementation begins

Add source files to `src/`, headers to `include/expense_tracker/`, and register
them in the explicit file lists in `CMakeLists.txt`. Register future `.ui` and
`.qrc` files in their corresponding lists as needed. Once the source list is
populated, CMake enables the prepared `expense_tracker` Qt application target.

With the current empty source list, CMake intentionally skips Qt discovery and
creates no application target. Configuration still requires a C++ compiler and
the selected build tool. There is no application to launch yet, and a successful
scaffold build does not verify that Qt is installed correctly.

See [AGENTS.md](AGENTS.md) for project scope and implementation conventions.

## References

- [Building Qt applications with CMake](https://doc.qt.io/qt-6/cmake-get-started.html)
- [Qt Graphs](https://doc.qt.io/qt-6/qtgraphs-index.html)
- [Qt SQL database drivers](https://doc.qt.io/qt-6/sql-driver.html)

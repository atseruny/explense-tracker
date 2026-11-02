cmake_minimum_required(VERSION 3.21)

project(ExpenseTracker VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Keep file lists explicit. Add application files when implementation begins.
set(EXPENSE_TRACKER_SOURCES)
set(EXPENSE_TRACKER_HEADERS)
set(EXPENSE_TRACKER_FORMS)
set(EXPENSE_TRACKER_RESOURCES)

if(NOT EXPENSE_TRACKER_SOURCES)
    message(STATUS "Scaffold only: no application sources or executable yet.")
    return()
endif()

find_package(Qt6 6.8 REQUIRED COMPONENTS Widgets Sql Graphs QuickWidgets)
qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(expense_tracker
    ${EXPENSE_TRACKER_SOURCES}
    ${EXPENSE_TRACKER_HEADERS}
    ${EXPENSE_TRACKER_FORMS}
    ${EXPENSE_TRACKER_RESOURCES}
)

target_include_directories(expense_tracker PRIVATE
    "${CMAKE_CURRENT_SOURCE_DIR}/include"
)

target_link_libraries(expense_tracker PRIVATE
    Qt6::Widgets
    Qt6::Sql
    Qt6::Graphs
    Qt6::QuickWidgets
)

set_target_properties(expense_tracker PROPERTIES
    AUTORCC ON
    AUTOUIC_SEARCH_PATHS "${CMAKE_CURRENT_SOURCE_DIR}/ui"
)

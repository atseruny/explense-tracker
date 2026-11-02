# Project pipeline

Personal Expense Tracking and Visualization System

## Planning assumptions

- One developer, approximately 12 weeks, with regular weekly development time.
- A starting allowance of 12-15 focused hours per week; adjust after the first
  two weeks according to your C++ and Qt experience.
- Windows is the initial demonstration platform.
- The existing scaffold is complete. Application implementation has not started.
- This document is a plan; the implementation milestones below are future work.

## Release scope

The finished application will let one local user:

1. Add, view, edit, and delete expenses.
2. Save expenses locally and retrieve them after restarting.
3. Filter the expense list by date range and category together.
4. View spending by category, calendar-month comparisons, and spending over time.

Keep the first release focused on these agreed features. Revisit feature additions
after the complete demonstration is reliable.

## Working decisions to settle in week 2

Use these defaults unless course requirements call for something different:

| Decision | Proposed behavior |
| --- | --- |
| Currency | One application-wide currency; decide its display and precision before implementing money entry. |
| Amount | A positive amount stored as integer minor units. |
| Date | A valid calendar date; display in a readable format and store unambiguously. |
| Category | A required selection from a small predefined list, such as Food, Transport, Housing, Health, Education, Entertainment, and Other. |
| Description | Optional text; choose and enforce a reasonable maximum length. |
| Date filter | Include expenses on both the start and end dates; reject a start date after the end date. |
| Category filter | Allow one category or All categories. |
| Shared filters | The table, total, and all charts use the same filtered expenses. |
| Category chart | Bar chart showing total spending per category. |
| Monthly comparison | Bar chart showing totals grouped by year and calendar month. |
| Time trend | Line chart showing daily spending totals in date order. |
| Empty periods | Show zero for missing months/days within the selected range. |
| No matching expenses | Show a clear empty state and a zero total. |

Choose a useful initial date range in week 2. Label the active range clearly.
If a range starts or ends partway through a month, the monthly chart must make
clear that the corresponding total covers only that selected part of the month.

An expense needs a stable identifier in addition to its amount, date, category,
and description. Editing or deleting must identify the saved expense by this
identifier rather than its visible row number. This is a conceptual data model;
database definitions will be created during implementation.

## Application organization

Keep a small number of clear responsibilities:

| Part | Responsibility |
| --- | --- |
| Expense data | Represent an expense and its category without interface behavior. |
| SQLite storage | Open the local database, initialize it, save changes, and retrieve expenses. |
| Expense table model | Present the selected expenses to the Qt table view. |
| Spending calculations | Calculate category, monthly, and daily totals independently of charts. |
| Main window and expense form | Collect user input, display results, and coordinate actions. |
| Chart views | Draw the calculated results and display labels and empty states. |

The main flow is:

```text
Expense form -> validation -> save to SQLite
                                  |
                  reload using the active filters
                                  |
                         filtered expenses
                           /            \
                    expense table   spending calculations
                                           |
                                  totals and three charts
```

After a successful add, edit, or delete, refresh the table and charts using the
same active filters. If an edited expense no longer matches those filters, it
should disappear from the current results without being lost from storage.
If saving fails, report the failure without presenting an unsaved change as saved.

## Twelve-week implementation schedule

### 1. Verify the development environment - week 1

Tasks:

- Install Qt, a matching compiler, CMake, Ninja, and Qt Creator if desired.
- Configure and build using the existing project files.
- Begin the application with the smallest possible working Qt window.
- Verify that the QSQLITE driver can open a temporary database.
- Display one tiny Qt Graphs view inside the Widgets interface using an example
  appropriate to the installed Qt version.
- Record the working Qt version and desktop kit in the setup instructions.
- Start version control and use small, understandable commits.

Done when: a real application launches, SQLite opens, and an embedded graph
renders. The current empty scaffold cannot prove that these dependencies work.

### 2. Define behavior and sketch the interface - week 2

Tasks:

- Check the course's required deliverables and grading criteria.
- Finalize the working decisions listed above.
- Sketch an expense table, add/edit dialog, filter controls, and charts area.
- Decide which fields are required and how invalid input will be explained.
- Outline storage, table, calculation, and interface responsibilities.
- Prepare a small fictional expense dataset and expected totals.

Done when: every agreed feature has an observable success condition and the
screens and data rules are clear enough to implement.

### 3. Build the data and persistence foundation - week 3

Tasks:

- Introduce the expense/category data types and exact amount conversion.
- Create the initial SQLite structure and initialize predefined categories once.
- Store the database in the user's application-data directory.
- Implement storage operations with prepared statements and bound values.
- Verify that initialization is safe to repeat and does not duplicate categories.
- Check storage behavior using a temporary database.

Done when: expenses can be saved, retrieved, changed, and removed through the
storage component, and exact amounts survive a round trip.

### 4. Deliver the first usable flow: add and list - week 4

Tasks:

- Build the expense table and add-expense form.
- Connect valid input to persistent storage.
- Populate and refresh the table from saved expenses.
- Show useful column labels, readable amounts, dates, and categories.
- Handle an empty database and report database-open or save failures clearly.

Done when: a user can enter an expense, see it in the list, close the application,
and find the same expense after reopening it.

### 5. Complete editing and deletion - week 5

Tasks:

- Open an existing expense in the edit form and save changes by its stable ID.
- Support canceling an edit without changing stored data.
- Add deletion with confirmation and safe selection handling.
- Refresh the list after each successful change.
- Handle the case where no expense is selected.

Done when: add, edit, delete, and cancel all work on the intended saved expense.

### 6. Stabilize expense management - week 6

Tasks:

- Finish validation for invalid amounts, dates, categories, and description length.
- Check repeated edits and deletions, exact decimal input, and restart behavior.
- Keep failed storage operations from leaving a misleading interface state.
- Check keyboard navigation, resizing, and readable error messages.
- Capture a screenshot and update the progress notes for the course report.

Done when: the application is a reliable local expense tracker even before the
full visualization features are added.

### 7. Add shared filtering - week 7

Tasks:

- Add date-range and category controls.
- Apply both filters together and show the selected total.
- Use one shared filter state for the table and later chart calculations.
- Verify inclusive boundaries, a single-day range, and invalid ranges.
- Ensure add/edit/delete still refresh correctly while filters are active.

Done when: visible expenses and their total match the active filters, including
boundary dates and combinations of date and category.

### 8. Implement and verify spending calculations - week 8

Tasks:

- Calculate category totals from the filtered expenses.
- Calculate monthly totals using both year and month.
- Calculate daily totals for the spending-over-time view.
- Order time periods chronologically and fill missing periods with zero.
- Verify exact totals against the fictional dataset before connecting charts.
- Cover empty input, repeated dates, year changes, and leap-day boundaries.

Done when: each calculation matches hand-checked results and the sum of each
grouping equals the total for the same filtered dataset.

### 9. Connect the three charts - week 9

Tasks:

- Build the category bar chart, monthly bar chart, and daily line chart.
- Connect chart data to the verified calculations.
- Add chart titles, axis labels, currency units, and understandable values.
- Refresh every chart when filters or saved expenses change.
- Handle empty results and single-point/single-category results.
- Try an initial packaged build to catch graph-runtime dependency issues early.

Done when: the table, displayed total, and all three charts tell the same story
and update together.

### 10. Integrate and improve usability - week 10

Tasks:

- Exercise the whole application with several months of fictional expenses.
- Check layout at different window sizes and make long labels readable.
- Improve empty states, selection behavior, and confirmation/error wording.
- Verify the database location is independent of the launch directory.
- Fix integration problems and stop adding new features.
- Update the report with the final architecture and screen captures.

Done when: a complete realistic user session works smoothly without manual
database changes or development-only workarounds.

### 11. Test and prepare the Windows release - week 11

Tasks:

- Run focused automated checks for calculations, filtering, and persistence.
- Repeat the manual acceptance checklist below using fictional data.
- Build a release version and collect its Qt and compiler runtime dependencies.
- Include and verify the SQLite driver and graph runtime components.
- Test the packaged application in a clean Windows environment without Qt
  Creator or the development kit supplying missing dependencies.
- Write short installation, launch, build, and usage instructions.

Done when: the release package starts, saves data, and renders all charts outside
the development environment.

### 12. Finish the submission and rehearse - week 12

Tasks:

- Complete the report and presentation according to the course requirements.
- Include requirements, conceptual data model, architecture, interface images,
  calculation explanations, test results, and known limitations.
- Rehearse the demonstration below with prepared fictional data.
- Verify that source, build instructions, documentation, and release package agree.
- Keep remaining time for fixes and submission problems.

Done when: the project can be rebuilt, demonstrated, and explained confidently,
and all required submission files are ready.

## Acceptance checklist

- [ ] A first launch creates usable local storage.
- [ ] Valid expenses can be added, edited, and deleted.
- [ ] Canceling forms or deletion leaves data unchanged.
- [ ] Saved changes survive an application restart.
- [ ] Invalid input receives clear feedback.
- [ ] Failed storage operations do not appear successful.
- [ ] Date and category filters work separately and together.
- [ ] Both endpoints of the date range are included.
- [ ] Editing an expense outside the active filter updates the visible results correctly.
- [ ] Table totals and all chart groupings agree for the same active filters.
- [ ] Daily and monthly series are chronological and show missing periods correctly.
- [ ] Different years do not share the same monthly bucket.
- [ ] Empty data and single-expense cases work.
- [ ] The packaged application saves data and displays charts on a clean machine.

Use targeted tests as each component is implemented. Week 11 is a final review,
not the first time calculations or persistence are checked.

## Small hand-checkable dataset

For an example currency with two fractional digits:

| Date | Category | Amount |
| --- | --- | ---: |
| 2026-01-01 | Food | 10.25 |
| 2026-01-31 | Transport | 5.00 |
| 2026-02-01 | Food | 20.00 |
| 2026-04-15 | Other | 7.50 |

Expected results:

- All expenses total 42.75.
- Food totals 30.25, Transport totals 5.00, and Other totals 7.50.
- January totals 15.25; February 20.00; March 0.00; April 7.50.
- The inclusive January 1-31 filter totals 15.25.
- The same January filter combined with Food totals 10.25.

Adapt the displayed precision to the chosen currency. Add separate cases for
year boundaries, leap days, and failed storage operations.

## Final demonstration

1. Launch the packaged application and show prepared fictional expenses.
2. Add an expense and point out the updated table, total, and charts.
3. Edit its amount or category and show the recalculated results.
4. Apply a date range and category filter together.
5. Explain the category, monthly, and time-trend views.
6. Delete the selected expense and show consistent updates.
7. Restart the application to demonstrate persistence.

Keep a separate demonstration database so rehearsals do not affect personal data.

## Milestones to protect

- End of week 1: Qt window, SQLite connection, and embedded graph verified.
- End of week 4: add, display, and persistence work end to end.
- End of week 6: expense management is stable.
- End of week 9: every requested feature is implemented.
- End of week 11: the release runs outside the development environment.
- End of week 12: submission and demonstration are ready.

If a milestone slips, simplify chart styling and presentation details while
preserving the agreed functionality and final verification time.

## Technical references

Use documentation matching the Qt version installed during week 1.

- [Qt CMake setup](https://doc.qt.io/qt-6/cmake-get-started.html)
- [Embedding 2D Qt Graphs in Qt Widgets](https://doc.qt.io/qt-6/qtgraphs-2d-quickwidgetgraphs-example.html)
- [Qt SQL drivers, including QSQLITE](https://doc.qt.io/qt-6/sql-driver.html)
- [Qt Windows deployment](https://doc.qt.io/qt-6/windows-deployment.html)

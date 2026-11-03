#include <QMainWindow>

#include <QApplication>

int main(int argc, char **argv)
{
	// 1. Initialize the application event loop
	QApplication a(argc, argv);

	// 2. Instantiate the default main window
	QMainWindow w;

	// 3. Make the window visible
	w.show();

	// 4. Start the event loop and wait for it to exit
	return a.exec();
}

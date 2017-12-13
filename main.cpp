#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "filereader.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    FileReader fileReader;
    engine.rootContext()->setContextProperty("fileReader", &fileReader);

    return app.exec();
}

#include <QtCore>
#include <QtQuick>

int main(int argc, char **argv)
{
    QGuiApplication guiApp(argc, argv);
    auto engine = new QQmlEngine;
    engine = nullptr;
    qDebug() << engine->baseUrl();
}


#include <QtCore>

int main(int /*argc*/, char **/*argv*/)
{
    QStringList list = {"one", "two"};
    qDebug() << list[2];
}


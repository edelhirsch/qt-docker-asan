#include <QtCore>

int main(int /*argc*/, char **/*argv*/)
{
    auto parent = new QObject;
    auto child = new QObject(parent);
    delete parent;
    delete child;
}


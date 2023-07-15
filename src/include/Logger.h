#ifndef LOGGER_H
#define LOGGER_H

#include <QObject>
#include <QDebug>

#include "Database.h"

class Logger : public QObject
{
    Q_OBJECT

public:
    explicit Logger(QObject *parent = nullptr);
<<<<<<< HEAD
    void start();
=======
>>>>>>> 08fa7af (Migrate to Qt6 and start new repository)
    void log(QString message, QString scope, QString subject);

signals:

};

#endif // LOGGER_H

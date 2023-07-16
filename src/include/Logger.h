#ifndef LOGGER_H
#define LOGGER_H

#include <QObject>
#include <QDebug>


class Logger : public QObject
{
    Q_OBJECT

public:
    explicit Logger(QObject *parent = nullptr);

    void start();
    void log(QString message, QString scope, QString subject);

signals:

};

#endif // LOGGER_H

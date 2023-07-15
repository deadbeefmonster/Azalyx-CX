#include "Logger.h"

Logger::Logger(QObject *parent) : QObject(parent)
{

}

void Logger::start() {
    Database database;
    database.connectToDatabase();
    if (! database.getDb().tables().contains( QLatin1String("log"))) {
        qFatal() << "Database is missing the 'log' table. Ensure the sql/sqlite.sql is executed against the database and try again.";
    }
}

void Logger::log(QString message, QString scope, QString subject)
{
    Database database;

    QSqlQuery sqlQuery(database.getDb());
    sqlQuery.prepare("insert into log (message, scope, subject) values (:message, :scope, :subject)");
    sqlQuery.bindValue(":message", message);
    sqlQuery.bindValue(":scope", scope);
    sqlQuery.bindValue(":subject", subject);
    sqlQuery.exec();
}


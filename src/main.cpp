#include <QCommandLineParser>
#include <QCommandLineOption>
#include <QCoreApplication>
#include <QDateTime>
#include <QDebug>
#include <QDir>
#include <QFileInfo>
#include <QList>
#include <QListIterator>
#include <QSettings>
#include <QtSql>
#include <QString>
#include <QTextStream>
#include <QSysInfo>

#include "Database.h"
#include "InitializeSettings.h"
#include "Logger.h"
#include "ServiceTcp.h"


#ifndef THREAD_POOL_MAX
#define THREAD_POOL_MAX  QThread::idealThreadCount()
#endif


void myMessageOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    QByteArray localMsg = msg.toLocal8Bit();
    QByteArray timestamp = QDateTime::currentDateTime().toString().toLocal8Bit();
    switch (type) {
    case QtDebugMsg:
        fprintf(stderr, "[%s] DEBUG: [%s:%u] %s\r\n", timestamp.constData(), context.file, context.line, localMsg.constData());
        break;
    case QtInfoMsg:
        printf("[%s] INFO: %s\r\n", timestamp.constData(), localMsg.constData());
        break;
    case QtWarningMsg:
        printf("[%s] WARN: %s\r\n", timestamp.constData(), localMsg.constData());
        break;
    case QtCriticalMsg:
        printf("[%s] FATAL ERROR: %s\r\n", timestamp.constData(), localMsg.constData());
        printf("Exiting...\r\n");
        exit(EXIT_FAILURE);
    case QtFatalMsg:
        printf("[%s] FATAL ERROR: %s\r\n", timestamp.constData(), localMsg.constData());
        printf("Exiting...\r\n");
        exit(EXIT_FAILURE);
    }
}


int main(int argc, char *argv[])
{
    qInstallMessageHandler(myMessageOutput); // Install the handler

    QCoreApplication app(argc, argv);
    QCoreApplication::setOrganizationName("Christoff Humphries");
    QCoreApplication::setOrganizationDomain("azalyx.cx");
    QCoreApplication::setApplicationName("AzalyxCX");
    QCoreApplication::setApplicationVersion("v0.1");
    QTextStream out(stdout);
    QSettings settings;
    Database database;
    Logger logger;


    // Banner
    printf("░░▓█████████████░█████████████▓▒█████████████▒█████▒▓▓▓▓▓████▓▒░░▒▓▓▓██████▓▒░░░░░░▓████░███████████████▓▒░░░░░░▓████░\n");
    printf("░░▓████▒░░░▓████░░░░░░░▒▒▒████▓▒████▒░░░▒████▒█████░░░░░░░░▓████▓░░░░▒████████▒░░░░▓████░█████░░░░░░░▒▓████░░░░░▓████░\n");
    printf("░░▓███████▓█████░░░░▒▓████▓▓▓█▓▓████████▓████▒█████░░░░░░░░░▒████▒░░░▒████▒████▒░░░▓████░████▓░░░░░░░░░▓████▒░░░▓████░\n");
    printf("▒▒▓████░▒▓██████░░▒████▒░░░░░░▒▓████▒░▓██████▒█████░░░░░████▒█████░░░▒████░████▓░░░▓████░████▓░░░░▓████░████▓░░░▓████░\n");
    printf("░░▓████░░░░█████░▓████░░░░░░░░░▒████░░░░█████▒█████░░░░░████▒█████░░░▒████░████▓░░░▓████░████▓░░░░▓████░████▓░░░▓████░\n");
    printf("░░▓████░░░░▒████░████▒░░░░░░░░░▒████░░░░░████▒█████▒▒▒░░████▒▒▓███▒░▒▓██▓▓░▒▓███▒░▒███▓▒░█████▒▒▒░▓████░▓▓██▓▒░▒███▓▒░\n");
    printf("░░▒▓▓▓▓░░░░▒████░████▓░░░░░░░░░░▓▓▓▓░░░░░████▓▓▓▒▒▒▒▓███████▒░░░░▓████░░░░░▒▓▓██▒▒▒██▓▓▒▒▓▒▒▒▒▓████████░▒▓▓██▒▒▓██▓▓▒░\n");
    printf("░░░░░░░░░░░▒████▒█████████████▓░░░░░░░░░░████▒░░░░░░░░▒█████▒░░░░▓████░░░░░████▓░░░▓████░░░░░░░░▒██████░████▓░░░█████░\n");
    printf("░░░░░░░░░░░▒█████████████████▓░░░░░░░░░░░████▒░░░░░░░░░▒████▒░░░░▓███▓░░░░░████▓░░░▓████░░░░░░░░░░████▓░████▒░░░▓████░\n");
    printf("%s %s (Scarlet Fire) - A personal protocol research and Qt C++ programming project.\n",
           QCoreApplication::applicationName().toStdString().c_str(),
           QCoreApplication::applicationVersion().toStdString().c_str());
    printf("(c) 2023, Christoff Humphries <christoff@deadbeef.monster>\n\n");
    

    // System info
    qInfo().nospace().noquote() << "System Info: " << QSysInfo::prettyProductName()
                                << " - " << QSysInfo::kernelType() << " " << QSysInfo::kernelVersion()
                                << " - " << QSysInfo::buildAbi();
    // Configuration
    qInfo().nospace().noquote() << "Configuration file: " << settings.fileName() ;


    // ///////////////////////////////////////////////////////////////////////////////////////////////
    // CLI argument provisioning
    QCommandLineParser parser;
    parser.addHelpOption();
    parser.addVersionOption();

    // Initialize/first time stuff
    QCommandLineOption initializeOption("initialize", QCoreApplication::translate("main", "Initialize the settings data."));
    parser.addOption(initializeOption);

    // TCP Service
    QCommandLineOption serviceTcpOption("service-tcp", QCoreApplication::translate("main", "Enable raw TCP service."));
    QCommandLineOption serviceTcpPortOption("service-tcp-port", QCoreApplication::translate("main", "Raw TCP service port number."),
                                            QCoreApplication::translate("main", "port number"));
    parser.addOption(serviceTcpOption);
    parser.addOption(serviceTcpPortOption);

    parser.process(app);
    // ///////////////////////////////////////////////////////////////////////////////////////////////



    // ///////////////////////////////////////////////////////////////////////////////////////////////
    // Initialize stuff
    if (parser.isSet(initializeOption)) {
        qInfo().nospace().noquote() << "Initializing settings...";
        InitializeSettings initializeSettings;
        initializeSettings.initialize();
        qInfo().nospace().noquote() << "Initialized settings";

        qInfo().nospace().noquote() << "Initialization complete. Restart server without initialize flags. Exiting...";
        exit(EXIT_SUCCESS);
    }
    // ///////////////////////////////////////////////////////////////////////////////////////////////

    // Database
    database.connectToDatabase();
    logger.start();
    qInfo().nospace().noquote() << "Database: " << database.getDb().driverName()
                                << " for database " << database.getDb().databaseName();

    // ///////////////////////////////////////////////////////////////////////////////////////////////
    // Start services
    // Set the global thread pool count
    QThreadPool::globalInstance()->setMaxThreadCount(THREAD_POOL_MAX);

    bool servicesStarted = false;

    // Raw TCP service
    ServiceTcp serviceTcp;
    if (parser.isSet(serviceTcpOption) || settings.value("service/tcp").toBool()) {
        // Start the service
        quint16 port = settings.value("tcp/port").toInt();
        if (parser.isSet(serviceTcpPortOption)) {
            port = parser.value(serviceTcpPortOption).toInt();
        }
        if (port < 1 || port > 65535) {
            qCritical().nospace().noquote() << "The raw TCP port number should be between 1 and 65535.";
        }
        qInfo().nospace().noquote() << ServiceTcp::NAME << ": attempting to start... ";
        serviceTcp.startService(port);
        if (serviceTcp.isListening()) {
            qInfo().nospace().noquote() << ServiceTcp::NAME << ": listening on port " << port << ".";
            servicesStarted = true;
            logger.log("TCP service started","services startup", "services");
        }
        else {
            qWarning().nospace().noquote() << ServiceTcp::NAME << ": NOT listening on port " << port << ".";
            logger.log(QString("%1 not started, couldn't listen on port %2").arg(ServiceTcp::NAME, QString(port)), "services startup", "services");
        }
    }
    // End - Raw TCP service

    // Check if at least one service has started
    if (servicesStarted == false) {
        qWarning().nospace().noquote() << "No services are started! You need to start a service for this software to be useful.";
        logger.log("No services were started","services startup", "services");
    }
    // ///////////////////////////////////////////////////////////////////////////////////////////////


    // Application started without errors!
    qInfo().nospace().noquote() << QCoreApplication::applicationName() << " " << QCoreApplication::applicationVersion() << " started!";
    logger.log(QString("Application %1 %2 started").arg(QCoreApplication::applicationName(), QCoreApplication::applicationVersion()), "application state", "application");

    // Main loop
    return app.exec();
}

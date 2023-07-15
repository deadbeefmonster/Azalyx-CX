DROP TABLE IF EXISTS envelope;
CREATE TABLE envelope
(
    id         INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    uuid       TEXT UNIQUE,
    data_bytes BLOB,
    create_ts  DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS envelope_body;
CREATE TABLE envelope_body
(
    id            INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    uuid          TEXT,
    envelope_uuid TEXT REFERENCES envelope (uuid),
    data_bytes    BLOB,
    create_ts     DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS envelope_chunk;
CREATE TABLE envelope_chunk
(
    id                       INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    envelope_uuid            TEXT REFERENCES envelope (uuid),
    start_byte_position      INTEGER,
    chunk_size               INTEGER,
    is_transferred           boolean,
    is_acknowledged_required boolean,
    is_acknowledged          boolean,
    create_ts                DATETIME DEFAULT CURRENT_TIMESTAMP,
    transferred_ts           DATETIME,
    acknowledged_ts          DATETIME
);

DROP TABLE IF EXISTS envelope_fault;
CREATE TABLE envelope_fault
(
    id                 INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    uuid               TEXT NOT NULL UNIQUE,
    envelope_uuid      TEXT REFERENCES envelope (uuid),
    envelope_body_uuid TEXT REFERENCES envelope_body (uuid),
    data_bytes         BLOB,
    create_ts          DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS envelope_headers;
CREATE TABLE envelope_headers
(
    id            INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    envelope_uuid TEXT REFERENCES envelope (uuid),
    header_key    TEXT,
    header_value  TEXT,
    create_ts     DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS log;
CREATE TABLE log
(
    id        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    message   TEXT NOT NULL,
    scope     TEXT,
    subject   TEXT,
    create_ts DATETIME DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS service;
CREATE TABLE service
(
    id        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    uuid      TEXT NOT NULL UNIQUE,
    name      TEXT NOT NULL,
    type      TEXT NOT NULL,
    proto     TEXT NOT NULL,
    port      INTEGER,
    is_active boolean NOT NULL,
    create_ts DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_ts DATETIME
);

DROP TABLE IF EXISTS session;
CREATE TABLE session
(
    id        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    uuid      TEXT  NOT NULL UNIQUE,
    data      TEXT,
    create_ts DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_ts DATETIME,
    expire_ts DATETIME
);

DROP TABLE IF EXISTS queue;
CREATE TABLE queue
(
    id           INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    session_uuid TEXT REFERENCES session (uuid),
    data_bytes   BLOB,
    create_ts    DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_ts    DATETIME
);

DROP TABLE IF EXISTS request_response;
CREATE TABLE request_response
(
    id             INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT,
    session_uuid   INTEGER REFERENCES session (uuid),
    service_uuid   INTEGER REFERENCES service (uuid),
    request_bytes  BLOB,
    response_bytes BLOB,
    sender         TEXT,
    recipient      TEXT,
    create_ts      DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_ts      DATETIME
);

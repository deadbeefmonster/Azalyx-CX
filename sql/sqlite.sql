<<<<<<< HEAD
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


=======
drop table if exists "log";
CREATE TABLE "log" (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	message TEXT NOT NULL,
	"scope" TEXT,
	subject INTEGER,
	create_ts datetime DEFAULT current_timestamp
);

drop table if exists "session";
CREATE TABLE IF NOT EXISTS "session" (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    uuid text,
	"data" TEXT,
	create_ts datetime DEFAULT current_timestamp NOT NULL,
	update_ts datetime,
    expire_ts datetime
);

drop table if exists service;
create table if not exists "service" (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT,
    "type" TEXT,
    proto TEXT,
    port integer,
    is_active boolean,
    create_ts datetime DEFAULT current_timestamp NOT NULL,
    update_ts datetime
);

drop table if exists request_response;
CREATE TABLE request_response (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "session_id" integer,
	service_id INTEGER,
	request_bytes BLOB,
	response_bytes BLOB,
	sender TEXT,
	recipient TEXT,
	create_ts datetime DEFAULT current_timestamp,
    update_ts datetime
);

drop table if exists "envelope";
create table "envelope" (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    uuid varchar unique,
    data_bytes blob,
    create_ts datetime DEFAULT current_timestamp
);

drop table if exists "envelope_headers";
create table "envelope_headers" (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    envelope_uuid text, -- envelope.uuid
    header_key text,
    header_value text,
    create_ts datetime DEFAULT current_timestamp
);

drop table if exists "envelope_body";
create table "envelope_body" (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    uuid text,
    envelope_uuid text, -- envelope.uuid
    data_bytes blob,
    create_ts datetime DEFAULT current_timestamp
);

drop table if exists "envelope_fault";
create table "envelope_fault" (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    uuid text,
    envelope_uuid text, -- envelope.uuid
    envelope_body_uuid text, -- envelope_body.uuid
    data_bytes blob,
    create_ts datetime DEFAULT current_timestamp
);


drop table if exists "envelope_chunk";
create table "envelope_chunk" (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    envelope_uuid text, -- envelope.uuid
    start_byte_position integer,
    chunk_size integer,
    is_tranferred boolean,
    is_acknowledged_required boolean, 
    is_acknowledged boolean,
    create_ts datetime DEFAULT current_timestamp,
    transferred_ts datetime,
    acknowledged_ts datetime
);



drop table if exists "queue";
create table "queue" (
   	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "session_id" integer,
    data_bytes blob,
    create_ts datetime DEFAULT current_timestamp,
    update_ts datetime
);
>>>>>>> f7d6016 (Add SQLite SQL file)

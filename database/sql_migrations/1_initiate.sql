-- +migrate Up
-- +migrate StatementBegin

CREATE TABLE "patients" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar(255) NOT NULL,
  "gender" varchar(50) NOT NULL,
  "birth_date" timestamp NOT NULL,
  "mobile_number" varchar(20) NOT NULL,
  "medical_history" text,
  "created_by" int NOT NULL,
  "updated_by" int,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "doctors" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar(255) NOT NULL,
  "mobile_number" varchar(20) NOT NULL,
  "qualifications" varchar(255) NOT NULL,
  "departement_id" int NOT NULL,
  "created_by" int NOT NULL,
  "updated_by" int,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "departement" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "departement_name" varchar(255) UNIQUE NOT NULL,
  "location" varchar(255) NOT NULL,
  "created_by" int NOT NULL,
  "updated_by" int,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "appointment" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "appo_schedule" timestamp NOT NULL,
  "descriptions" varchar(255) NOT NULL,
  "patient_id" int NOT NULL,
  "doctors_id" int NOT NULL,
  "departement_id" int NOT NULL,
  "created_by" int NOT NULL,
  "updated_by" int,
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "user_admin" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "username" varchar(255) UNIQUE NOT NULL,
  "password" varchar(255) NOT NULL,
  "name" varchar(255),
  "role" varchar(100),
  "created_at" timestamp DEFAULT (now()),
  "updated_at" timestamp DEFAULT (now())
);

CREATE TABLE "user_credentials" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "admin_id" int,
  "uuid" varchar(255) UNIQUE
);

ALTER TABLE "appointment" ADD FOREIGN KEY ("doctors_id") REFERENCES "doctors" ("id") ON DELETE CASCADE;

ALTER TABLE "appointment" ADD FOREIGN KEY ("patient_id") REFERENCES "patients" ("id") ON DELETE CASCADE;

ALTER TABLE "appointment" ADD FOREIGN KEY ("departement_id") REFERENCES "departement" ("id") ON DELETE CASCADE;

ALTER TABLE "doctors" ADD FOREIGN KEY ("departement_id") REFERENCES "departement" ("id") ON DELETE CASCADE;

ALTER TABLE "patients" ADD FOREIGN KEY ("created_by") REFERENCES "user_admin" ("id") ON DELETE CASCADE;

ALTER TABLE "appointment" ADD FOREIGN KEY ("created_by") REFERENCES "user_admin" ("id") ON DELETE CASCADE;

ALTER TABLE "departement" ADD FOREIGN KEY ("created_by") REFERENCES "user_admin" ("id") ON DELETE CASCADE;

ALTER TABLE "doctors" ADD FOREIGN KEY ("created_by") REFERENCES "user_admin" ("id") ON DELETE CASCADE;

ALTER TABLE "appointment" ADD FOREIGN KEY ("updated_by") REFERENCES "user_admin" ("id") ON DELETE CASCADE;

ALTER TABLE "patients" ADD FOREIGN KEY ("updated_by") REFERENCES "user_admin" ("id") ON DELETE CASCADE;

ALTER TABLE "doctors" ADD FOREIGN KEY ("updated_by") REFERENCES "user_admin" ("id") ON DELETE CASCADE;

ALTER TABLE "departement" ADD FOREIGN KEY ("updated_by") REFERENCES "user_admin" ("id") ON DELETE CASCADE;

ALTER TABLE "user_credentials" ADD FOREIGN KEY ("admin_id") REFERENCES "user_admin" ("id") ON DELETE CASCADE;


-- +migrate StatementEnd
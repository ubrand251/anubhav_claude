// ===========================================================================
// db/common.cds
// ---------------------------------------------------------------------------
// Reusable artifacts for the Vacation & Traveller Management application.
// Single source of truth for code lists and shared type definitions.
// Business entities live in db/schema.cds and import from this file.
// UI texts are resolved from db/i18n/i18n*.properties.
// ===========================================================================

namespace anubhav.claude;

using { sap } from '@sap/cds/common';

// ---------------------------------------------------------------------------
// Code lists
// ---------------------------------------------------------------------------

/** Address types, e.g. Home, Office, Permanent, Temporary */
entity AddressTypes : sap.common.CodeList {
    @title: '{i18n>AddressTypeCode}'
    key code : String(1);
}

/** Traveller statuses, e.g. Active, Inactive, Suspended */
entity TravellerStatus : sap.common.CodeList {
    @title: '{i18n>StatusCode}'
    key code : String(1);
}

/** Application roles, e.g. ADMIN, TRAVELLER, AGENT */
entity Roles : sap.common.CodeList {
    @title: '{i18n>RoleCode}'
    key code : String(10);
}

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

type AddressType : Association to AddressTypes;
type Status      : Association to TravellerStatus;
type Role        : Association to Roles;

// ---------------------------------------------------------------------------
// Annotations for fields inherited from sap.common.CodeList
// ---------------------------------------------------------------------------

annotate AddressTypes with {
    name  @title: '{i18n>Name}';
    descr @title: '{i18n>Description}';
}

annotate TravellerStatus with {
    name  @title: '{i18n>Name}';
    descr @title: '{i18n>Description}';
}

annotate Roles with {
    name  @title: '{i18n>Name}';
    descr @title: '{i18n>Description}';
}

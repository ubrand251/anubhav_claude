// ===========================================================================
// db/schema.cds
// ---------------------------------------------------------------------------
// Business entities for the Vacation & Traveller Management application.
// Code lists and reusable types are defined in db/common.cds.
// UI texts are resolved from db/i18n/i18n*.properties.
// ===========================================================================

namespace anubhav.claude;

using {
    cuid,
    Currency,
    managed
} from '@sap/cds/common';

using {
    anubhav.claude.AddressType,
    anubhav.claude.Status,
    anubhav.claude.Role
} from './common';

// ---------------------------------------------------------------------------
// Main entities
// ---------------------------------------------------------------------------

entity Destinations : cuid {
    @title: '{i18n>StreetAddress}'
    address    : String(255);
    @title: '{i18n>City}'
    city       : String(40);
    @title: '{i18n>PostalCode}'
    postalCode : String(8);
    @title: '{i18n>Country}'
    country    : String(40);
    @title: '{i18n>Traveller}'
    traveller  : Association to Travellers;
}

entity Travellers : cuid, managed {
    @title: '{i18n>UserName}'
    @mandatory
    userName  : String(255);
    @title: '{i18n>FirstName}'
    firstName : String(255);
    @title: '{i18n>LastName}'
    lastName  : String(255);
    @title: '{i18n>Contacts}'
    contacts  : Composition of many Contacts
                    on contacts.traveller = $self;
    @title: '{i18n>Gender}'
    gender    : String(10);
    @title: '{i18n>Age}'
    age       : Integer;
    @title: '{i18n>Status}'
    status    : Status default 'A';
    @title: '{i18n>CreatedBy}'
    createdBy : String(40);
    @title: '{i18n>Destination}'
    address   : Composition of Destinations;
    @title: '{i18n>Vacations}'
    vacations : Composition of many Vacations
                    on vacations.traveller = $self;
}

entity Contacts : cuid {
    @title: '{i18n>ContactType}'
    type      : AddressType;
    @title: '{i18n>ContactDetail}'
    address   : String(255);
    @title: '{i18n>Traveller}'
    traveller : Association to Travellers;
}

entity Vacations : cuid {
    @title: '{i18n>VacationName}'
    name        : String(255);
    @title: '{i18n>Budget}'
    budget      : Decimal(10, 2);
    @title: '{i18n>Currency}'
    currency    : Currency;
    @title: '{i18n>Description}'
    description : String(1024);
    @title: '{i18n>StartsAt}'
    startsAt    : DateTime;
    @title: '{i18n>EndsAt}'
    endsAt      : DateTime;
    @title: '{i18n>Traveller}'
    traveller   : Association to Travellers;
}

// ---------------------------------------------------------------------------
// Users
// ---------------------------------------------------------------------------

entity AppUsers : cuid, managed {
    @title: '{i18n>UserName}'
    @mandatory
    userName    : String(100);
    @title: '{i18n>Email}'
    @mandatory
    email       : String(255);
    @title: '{i18n>FullName}'
    fullName    : String(255);
    @title: '{i18n>Role}'
    role        : Role;
    @title: '{i18n>IsActive}'
    isActive    : Boolean default true;
    @title: '{i18n>LastLoginAt}'
    lastLoginAt : DateTime;
    @title: '{i18n>Traveller}'
    traveller   : Association to Travellers; // optional: set when the user is a traveller
}

// ---------------------------------------------------------------------------
// Annotations for fields inherited from cuid / managed
// ---------------------------------------------------------------------------

annotate Destinations with {
    ID @title: '{i18n>ID}';
}

annotate Travellers with {
    ID         @title: '{i18n>ID}';
    createdAt  @title: '{i18n>CreatedAt}';
    modifiedAt @title: '{i18n>ModifiedAt}'  @odata.etag;
    modifiedBy @title: '{i18n>ModifiedBy}';
}

annotate Contacts with {
    ID @title: '{i18n>ID}';
}

annotate Vacations with {
    ID @title: '{i18n>ID}';
}

annotate AppUsers with {
    ID         @title: '{i18n>ID}';
    createdAt  @title: '{i18n>CreatedAt}';
    createdBy  @title: '{i18n>CreatedBy}';
    modifiedAt @title: '{i18n>ModifiedAt}';
    modifiedBy @title: '{i18n>ModifiedBy}';
}

CREATE SCHEMA logistics;


ALTER SCHEMA logistics OWNER TO pg_database_owner;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'Supply chain logistics schema';

--
-- Name: commodity; Type: TABLE; Schema: logistics; Owner: postgres
--

CREATE TABLE logistics.commodity (
    commoditycode character varying(20) NOT NULL,
    commoditydescription text,
    customersku integer,
    vendorsku integer,
    grossweight real,
    uom character varying(5),
    validfrom date,
    validto date,
    sellingprice real,
    currency character varying(10)
);


ALTER TABLE logistics.commodity OWNER TO postgres;

--
-- Name: partyaddressdetails; Type: TABLE; Schema: logistics; Owner: postgres
--

CREATE TABLE logistics.partyaddressdetails (
    partyaddressid integer NOT NULL,
    addressline1 character varying(200),
    addressline2 character varying(200),
    addressline3 character varying(200),
    addressline4 character varying(200),
    postalcode character varying(20),
    citycode character varying(20),
    provincecode character varying(100),
    countrycode character varying(100),
    partyprimaryemailaddress character varying(100),
    partysecondaryemailaddress1 character varying(100)
);


ALTER TABLE logistics.partyaddressdetails OWNER TO postgres;

--
-- Name: partyaddressdetails_partyaddressid_seq; Type: SEQUENCE; Schema: logistics; Owner: postgres
--

ALTER TABLE logistics.partyaddressdetails ALTER COLUMN partyaddressid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME logistics.partyaddressdetails_partyaddressid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: partyassociation; Type: TABLE; Schema: logistics; Owner: postgres
--

CREATE TABLE logistics.partyassociation (
    partyid integer NOT NULL,
    partyname character varying(60),
    deliveryaddressline character varying(200),
    deliverypostalcode character varying(20),
    deliverycitycode character varying(20),
    deliveryprovincecode character varying(100),
    deliverycountrycode character varying(100),
    commaddress character varying(200),
    commapostalcode character varying(20),
    commacitycode character varying(20),
    commaprovincecode character varying(100),
    commacountrycode character varying(100),
    billingaddress character varying(200),
    billingpostalcode character varying(20),
    billingcitycode character varying(20),
    billingprovincecode character varying(100),
    billingcountrycode character varying(100),
    partyprimaryemailaddress character varying(100),
    partysecondaryemailaddress1 character varying(100)
);


ALTER TABLE logistics.partyassociation OWNER TO postgres;

--
-- Name: partyassociation_partyid_seq; Type: SEQUENCE; Schema: logistics; Owner: postgres
--

ALTER TABLE logistics.partyassociation ALTER COLUMN partyid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME logistics.partyassociation_partyid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: serviceorder; Type: TABLE; Schema: logistics; Owner: postgres
--

CREATE TABLE logistics.serviceorder (
    ordernumber integer NOT NULL,
    ordertype character varying(20),
    orderstatus character varying(20),
    orderdate date,
    partyid integer,
    proposeddeliverydate date,
    orderedtotalpackagequantity integer,
    orderedtotalitemquantity integer,
    orderedtotalgrossweight real
);


ALTER TABLE logistics.serviceorder OWNER TO postgres;

--
-- Name: serviceorder_ordernumber_seq; Type: SEQUENCE; Schema: logistics; Owner: postgres
--

ALTER TABLE logistics.serviceorder ALTER COLUMN ordernumber ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME logistics.serviceorder_ordernumber_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: serviceorderline; Type: TABLE; Schema: logistics; Owner: postgres
--

CREATE TABLE logistics.serviceorderline (
    orderlinenumber integer NOT NULL,
    ordernumber integer,
    orderstatus character varying(20),
    orderedproductcode character varying(20),
    orderdate date,
    orderupdatedate date,
    deliverypoint character varying(200),
    proposeddeliverydate date,
    orderedtotalpackagequantity integer,
    orderedtotalitemquantity integer,
    orderedtotalgrossweight real,
    uom character varying(5),
    storenumber text
);


ALTER TABLE logistics.serviceorderline OWNER TO postgres;

--
-- Name: serviceorderline_orderlinenumber_seq; Type: SEQUENCE; Schema: logistics; Owner: postgres
--

ALTER TABLE logistics.serviceorderline ALTER COLUMN orderlinenumber ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME logistics.serviceorderline_orderlinenumber_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: serviceorderstatus; Type: TABLE; Schema: logistics; Owner: postgres
--

CREATE TABLE logistics.serviceorderstatus (
    orderstatuscode character varying(20) NOT NULL,
    description text
);


ALTER TABLE logistics.serviceorderstatus OWNER TO postgres;

--
-- Name: serviceordertype; Type: TABLE; Schema: logistics; Owner: postgres
--

CREATE TABLE logistics.serviceordertype (
    ordertypecode character varying(20) NOT NULL,
    description text
);


ALTER TABLE logistics.serviceordertype OWNER TO postgres;

--
-- Name: transportplan; Type: TABLE; Schema: logistics; Owner: postgres
--

CREATE TABLE logistics.transportplan (
    transportplannumber integer NOT NULL,
    transportownbookingnumber character varying(40),
    modeoftransport character varying(15),
    assignedvehiclenumber character varying(20),
    hasmilkrun boolean NOT NULL,
    hasmultipletransportlegs boolean NOT NULL,
    estimatedtransittime timestamp without time zone
);


ALTER TABLE logistics.transportplan OWNER TO postgres;

--
-- Name: transportplan_transportplannumber_seq; Type: SEQUENCE; Schema: logistics; Owner: postgres
--

ALTER TABLE logistics.transportplan ALTER COLUMN transportplannumber ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME logistics.transportplan_transportplannumber_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tripdetails; Type: TABLE; Schema: logistics; Owner: postgres
--

CREATE TABLE logistics.tripdetails (
    tripid integer NOT NULL,
    transportplannumber integer,
    legsequence integer,
    modeoftransport character varying(15),
    pickuppoint integer,
    droppoint integer,
    isreverselogistics boolean NOT NULL,
    earliesttimeofdeparture timestamp without time zone,
    latesttimeofdeparture timestamp without time zone,
    scheduledtimeofdeparture timestamp without time zone,
    actualtimeofdeparture timestamp without time zone,
    earliesttimeofarrival timestamp without time zone,
    latesttimeofarrival timestamp without time zone,
    scheduledtimeofarrival timestamp without time zone,
    actualtimeofarrival timestamp without time zone
);


ALTER TABLE logistics.tripdetails OWNER TO postgres;

--
-- Name: tripdetails_tripid_seq; Type: SEQUENCE; Schema: logistics; Owner: postgres
--

ALTER TABLE logistics.tripdetails ALTER COLUMN tripid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME logistics.tripdetails_tripid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: vehicledetails; Type: TABLE; Schema: logistics; Owner: postgres
--

CREATE TABLE logistics.vehicledetails (
    vehicleplatenumber character varying(20) NOT NULL,
    vehicletype character varying(30),
    vehicleowner character varying(50),
    loadingmeter real
);


ALTER TABLE logistics.vehicledetails OWNER TO postgres;

--
-- Name: logistics.partyaddressdetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."logistics.partyaddressdetails" (
    index bigint,
    addressline1 text,
    postalcode text,
    city text,
    country text,
    email text
);


ALTER TABLE public."logistics.partyaddressdetails" OWNER TO postgres;

--
-- Name: partyaddressdetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partyaddressdetails (
    index bigint,
    addressline1 text,
    postalcode text,
    city text,
    country text,
    email text
);


ALTER TABLE public.partyaddressdetails OWNER TO postgres;

CCREATE TABLE genetic_code.gencode (
	gencode_id int4 NOT NULL,
	organismstr varchar(512) NOT NULL,
	PRIMARY KEY (gencode_id)
);

CREATE TABLE genetic_code.gencode_codon_aa (
	gencode_id int4 NOT NULL,
	codon char(3) NOT NULL,
	aa char(1) NOT NULL
);

CREATE TABLE genetic_code.gencode_startcodon (
	gencode_id int4 NOT NULL,
	codon char(3)
);

ALTER TABLE genetic_code.gencode_codon_aa
	ADD FOREIGN KEY (gencode_id) 
	REFERENCES genetic_code.gencode (gencode_id);



ALTER TABLE genetic_code.gencode_startcodon
	ADD FOREIGN KEY (gencode_id) 
	REFERENCES genetic_code.gencode (gencode_id);



CREATE INDEX gencode_codon_aa_i1 ON genetic_code.gencode_codon_aa USING btree (gencode_id, codon, aa)

CREATE UNIQUE INDEX gencode_codon_unique ON genetic_code.gencode_codon_aa USING btree (gencode_id, codon)

CREATE UNIQUE INDEX gencode_pkey ON genetic_code.gencode USING btree (gencode_id)

CREATE UNIQUE INDEX gencode_startcodon_unique ON genetic_code.gencode_startcodon USING btree (gencode_id, codon)

REATE TABLE chado.acquisition (
	acquisition_id serial NOT NULL,
	assay_id int4 NOT NULL,
	protocol_id int4,
	channel_id int4,
	acquisitiondate timestamp DEFAULT now(),
	"name" text,
	"uri" text,
	PRIMARY KEY (acquisition_id)
);

CREATE TABLE chado.acquisition_relationship (
	acquisition_relationship_id serial NOT NULL,
	subject_id int4 NOT NULL,
	type_id int4 NOT NULL,
	object_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (acquisition_relationship_id)
);

CREATE TABLE chado.acquisitionprop (
	acquisitionprop_id serial NOT NULL,
	acquisition_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (acquisitionprop_id)
);

CREATE TABLE chado.analysis (
	analysis_id serial NOT NULL,
	"name" varchar(255),
	description text,
	program varchar(255) NOT NULL,
	programversion varchar(255) NOT NULL,
	algorithm varchar(255),
	sourcename varchar(255),
	sourceversion varchar(255),
	sourceuri text,
	timeexecuted timestamp DEFAULT now() NOT NULL,
	PRIMARY KEY (analysis_id)
);

CREATE TABLE chado.analysis_organism (
	analysis_id int4 NOT NULL,
	organism_id int4 NOT NULL
);

CREATE TABLE chado.analysisfeature (
	analysisfeature_id serial NOT NULL,
	feature_id int4 NOT NULL,
	analysis_id int4 NOT NULL,
	rawscore float8,
	normscore float8,
	significance float8,
	"identity" float8,
	PRIMARY KEY (analysisfeature_id)
);

CREATE TABLE chado.analysisfeatureprop (
	analysisfeatureprop_id serial NOT NULL,
	analysisfeature_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 NOT NULL,
	PRIMARY KEY (analysisfeatureprop_id)
);

CREATE TABLE chado.analysisprop (
	analysisprop_id serial NOT NULL,
	analysis_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (analysisprop_id)
);

CREATE TABLE chado.arraydesign (
	arraydesign_id serial NOT NULL,
	manufacturer_id int4 NOT NULL,
	platformtype_id int4 NOT NULL,
	substratetype_id int4,
	protocol_id int4,
	dbxref_id int4,
	"name" text NOT NULL,
	"version" text,
	description text,
	array_dimensions text,
	element_dimensions text,
	num_of_elements int4,
	num_array_columns int4,
	num_array_rows int4,
	num_grid_columns int4,
	num_grid_rows int4,
	num_sub_columns int4,
	num_sub_rows int4,
	PRIMARY KEY (arraydesign_id)
);

CREATE TABLE chado.arraydesignprop (
	arraydesignprop_id serial NOT NULL,
	arraydesign_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (arraydesignprop_id)
);

CREATE TABLE chado.assay (
	assay_id serial NOT NULL,
	arraydesign_id int4 NOT NULL,
	protocol_id int4,
	assaydate timestamp DEFAULT now(),
	arrayidentifier text,
	arraybatchidentifier text,
	operator_id int4 NOT NULL,
	dbxref_id int4,
	"name" text,
	description text,
	PRIMARY KEY (assay_id)
);

CREATE TABLE chado.assay_biomaterial (
	assay_biomaterial_id serial NOT NULL,
	assay_id int4 NOT NULL,
	biomaterial_id int4 NOT NULL,
	channel_id int4,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (assay_biomaterial_id)
);

CREATE TABLE chado.assay_project (
	assay_project_id serial NOT NULL,
	assay_id int4 NOT NULL,
	project_id int4 NOT NULL,
	PRIMARY KEY (assay_project_id)
);

CREATE TABLE chado.assayprop (
	assayprop_id serial NOT NULL,
	assay_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (assayprop_id)
);

CREATE TABLE chado.biomaterial (
	biomaterial_id serial NOT NULL,
	taxon_id int4,
	biosourceprovider_id int4,
	dbxref_id int4,
	"name" text,
	description text,
	PRIMARY KEY (biomaterial_id)
);

CREATE TABLE chado.biomaterial_dbxref (
	biomaterial_dbxref_id serial NOT NULL,
	biomaterial_id int4 NOT NULL,
	dbxref_id int4 NOT NULL,
	PRIMARY KEY (biomaterial_dbxref_id)
);

CREATE TABLE chado.biomaterial_relationship (
	biomaterial_relationship_id serial NOT NULL,
	subject_id int4 NOT NULL,
	type_id int4 NOT NULL,
	object_id int4 NOT NULL,
	PRIMARY KEY (biomaterial_relationship_id)
);

CREATE TABLE chado.biomaterial_treatment (
	biomaterial_treatment_id serial NOT NULL,
	biomaterial_id int4 NOT NULL,
	treatment_id int4 NOT NULL,
	unittype_id int4,
	"value" float4,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (biomaterial_treatment_id)
);

CREATE TABLE chado.biomaterialprop (
	biomaterialprop_id serial NOT NULL,
	biomaterial_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (biomaterialprop_id)
);

CREATE TABLE chado.cache_libraries (
	cid varchar(255) DEFAULT ''::character varying NOT NULL,
	"data" bytea,
	expire int4 DEFAULT 0 NOT NULL,
	created int4 DEFAULT 0 NOT NULL,
	serialized int2 DEFAULT 0 NOT NULL,
	PRIMARY KEY (cid)
);

CREATE TABLE chado.cell_line (
	cell_line_id serial NOT NULL,
	"name" varchar(255),
	uniquename varchar(255) NOT NULL,
	organism_id int4 NOT NULL,
	timeaccessioned timestamp DEFAULT now() NOT NULL,
	timelastmodified timestamp DEFAULT now() NOT NULL,
	PRIMARY KEY (cell_line_id)
);

CREATE TABLE chado.cell_line_cvterm (
	cell_line_cvterm_id serial NOT NULL,
	cell_line_id int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (cell_line_cvterm_id)
);

CREATE TABLE chado.cell_line_cvtermprop (
	cell_line_cvtermprop_id serial NOT NULL,
	cell_line_cvterm_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (cell_line_cvtermprop_id)
);

CREATE TABLE chado.cell_line_dbxref (
	cell_line_dbxref_id serial NOT NULL,
	cell_line_id int4 NOT NULL,
	dbxref_id int4 NOT NULL,
	is_current bool DEFAULT true NOT NULL,
	PRIMARY KEY (cell_line_dbxref_id)
);

CREATE TABLE chado.cell_line_feature (
	cell_line_feature_id serial NOT NULL,
	cell_line_id int4 NOT NULL,
	feature_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (cell_line_feature_id)
);

CREATE TABLE chado.cell_line_library (
	cell_line_library_id serial NOT NULL,
	cell_line_id int4 NOT NULL,
	library_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (cell_line_library_id)
);

CREATE TABLE chado.cell_line_pub (
	cell_line_pub_id serial NOT NULL,
	cell_line_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (cell_line_pub_id)
);

CREATE TABLE chado.cell_line_relationship (
	cell_line_relationship_id serial NOT NULL,
	subject_id int4 NOT NULL,
	object_id int4 NOT NULL,
	type_id int4 NOT NULL,
	PRIMARY KEY (cell_line_relationship_id)
);

CREATE TABLE chado.cell_line_synonym (
	cell_line_synonym_id serial NOT NULL,
	cell_line_id int4 NOT NULL,
	synonym_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	is_current bool DEFAULT false NOT NULL,
	is_internal bool DEFAULT false NOT NULL,
	PRIMARY KEY (cell_line_synonym_id)
);

CREATE TABLE chado.cell_lineprop (
	cell_lineprop_id serial NOT NULL,
	cell_line_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (cell_lineprop_id)
);

CREATE TABLE chado.cell_lineprop_pub (
	cell_lineprop_pub_id serial NOT NULL,
	cell_lineprop_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (cell_lineprop_pub_id)
);

CREATE TABLE chado.chadoprop (
	chadoprop_id serial NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (chadoprop_id)
);

CREATE TABLE chado.channel (
	channel_id serial NOT NULL,
	"name" text NOT NULL,
	definition text NOT NULL,
	PRIMARY KEY (channel_id)
);

CREATE TABLE chado.contact (
	contact_id serial NOT NULL,
	type_id int4,
	"name" varchar(255) NOT NULL,
	description varchar(255),
	PRIMARY KEY (contact_id)
);

CREATE TABLE chado.contact_relationship (
	contact_relationship_id serial NOT NULL,
	type_id int4 NOT NULL,
	subject_id int4 NOT NULL,
	object_id int4 NOT NULL,
	PRIMARY KEY (contact_relationship_id)
);

CREATE TABLE chado.contactprop (
	contactprop_id serial NOT NULL,
	contact_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (contactprop_id)
);

CREATE TABLE chado."control" (
	control_id serial NOT NULL,
	type_id int4 NOT NULL,
	assay_id int4 NOT NULL,
	tableinfo_id int4 NOT NULL,
	row_id int4 NOT NULL,
	"name" text,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (control_id)
);

CREATE TABLE chado.cv (
	cv_id serial NOT NULL,
	"name" varchar(255) NOT NULL,
	definition text,
	PRIMARY KEY (cv_id)
);

CREATE TABLE chado.cv_root_mview (
	"name" varchar(255) NOT NULL,
	cvterm_id int4 NOT NULL,
	cv_id int4 NOT NULL,
	cv_name varchar(255) NOT NULL
);

CREATE TABLE chado.cvprop (
	cvprop_id serial NOT NULL,
	cv_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (cvprop_id)
);

CREATE TABLE chado.cvterm (
	cvterm_id serial NOT NULL,
	cv_id int4 NOT NULL,
	"name" varchar(1024) NOT NULL,
	definition text,
	dbxref_id int4 NOT NULL,
	is_obsolete int4 DEFAULT 0 NOT NULL,
	is_relationshiptype int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (cvterm_id)
);

CREATE TABLE chado.cvterm_dbxref (
	cvterm_dbxref_id serial NOT NULL,
	cvterm_id int4 NOT NULL,
	dbxref_id int4 NOT NULL,
	is_for_definition int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (cvterm_dbxref_id)
);

CREATE TABLE chado.cvterm_relationship (
	cvterm_relationship_id serial NOT NULL,
	type_id int4 NOT NULL,
	subject_id int4 NOT NULL,
	object_id int4 NOT NULL,
	PRIMARY KEY (cvterm_relationship_id)
);

CREATE TABLE chado.cvtermpath (
	cvtermpath_id serial NOT NULL,
	type_id int4,
	subject_id int4 NOT NULL,
	object_id int4 NOT NULL,
	cv_id int4 NOT NULL,
	pathdistance int4,
	PRIMARY KEY (cvtermpath_id)
);

CREATE TABLE chado.cvtermprop (
	cvtermprop_id serial NOT NULL,
	cvterm_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text DEFAULT ''::text NOT NULL,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (cvtermprop_id)
);

CREATE TABLE chado.cvtermsynonym (
	cvtermsynonym_id serial NOT NULL,
	cvterm_id int4 NOT NULL,
	synonym varchar(1024) NOT NULL,
	type_id int4,
	PRIMARY KEY (cvtermsynonym_id)
);

CREATE TABLE chado."db" (
	db_id serial NOT NULL,
	"name" varchar(255) NOT NULL,
	description varchar(255),
	urlprefix varchar(255),
	url varchar(255),
	PRIMARY KEY (db_id)
);

CREATE TABLE chado.dbxref (
	dbxref_id serial NOT NULL,
	db_id int4 NOT NULL,
	accession varchar(255) NOT NULL,
	"version" varchar(255) DEFAULT ''::character varying NOT NULL,
	description text,
	PRIMARY KEY (dbxref_id)
);

CREATE TABLE chado.dbxrefprop (
	dbxrefprop_id serial NOT NULL,
	dbxref_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text DEFAULT ''::text NOT NULL,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (dbxrefprop_id)
);

CREATE TABLE chado.eimage (
	eimage_id serial NOT NULL,
	eimage_data text,
	eimage_type varchar(255) NOT NULL,
	image_uri varchar(255),
	PRIMARY KEY (eimage_id)
);

CREATE TABLE chado."element" (
	element_id serial NOT NULL,
	feature_id int4,
	arraydesign_id int4 NOT NULL,
	type_id int4,
	dbxref_id int4,
	PRIMARY KEY (element_id)
);

CREATE TABLE chado.element_relationship (
	element_relationship_id serial NOT NULL,
	subject_id int4 NOT NULL,
	type_id int4 NOT NULL,
	object_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (element_relationship_id)
);

CREATE TABLE chado.elementresult (
	elementresult_id serial NOT NULL,
	element_id int4 NOT NULL,
	quantification_id int4 NOT NULL,
	signal float8 NOT NULL,
	PRIMARY KEY (elementresult_id)
);

CREATE TABLE chado.elementresult_relationship (
	elementresult_relationship_id serial NOT NULL,
	subject_id int4 NOT NULL,
	type_id int4 NOT NULL,
	object_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (elementresult_relationship_id)
);

CREATE TABLE chado.environment (
	environment_id serial NOT NULL,
	uniquename text NOT NULL,
	description text,
	PRIMARY KEY (environment_id)
);

CREATE TABLE chado.environment_cvterm (
	environment_cvterm_id serial NOT NULL,
	environment_id int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	PRIMARY KEY (environment_cvterm_id)
);

CREATE TABLE chado.expression (
	expression_id serial NOT NULL,
	uniquename text NOT NULL,
	md5checksum char(32),
	description text,
	PRIMARY KEY (expression_id)
);

CREATE TABLE chado.expression_cvterm (
	expression_cvterm_id serial NOT NULL,
	expression_id int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	"rank" int4 DEFAULT 0 NOT NULL,
	cvterm_type_id int4 NOT NULL,
	PRIMARY KEY (expression_cvterm_id)
);

CREATE TABLE chado.expression_cvtermprop (
	expression_cvtermprop_id serial NOT NULL,
	expression_cvterm_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (expression_cvtermprop_id)
);

CREATE TABLE chado.expression_image (
	expression_image_id serial NOT NULL,
	expression_id int4 NOT NULL,
	eimage_id int4 NOT NULL,
	PRIMARY KEY (expression_image_id)
);

CREATE TABLE chado.expression_pub (
	expression_pub_id serial NOT NULL,
	expression_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (expression_pub_id)
);

CREATE TABLE chado.expressionprop (
	expressionprop_id serial NOT NULL,
	expression_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (expressionprop_id)
);

CREATE TABLE chado.feature (
	feature_id serial NOT NULL,
	dbxref_id int4,
	organism_id int4 NOT NULL,
	"name" varchar(255),
	uniquename text NOT NULL,
	residues text,
	seqlen int4,
	md5checksum char(32),
	type_id int4 NOT NULL,
	is_analysis bool DEFAULT false NOT NULL,
	is_obsolete bool DEFAULT false NOT NULL,
	timeaccessioned timestamp DEFAULT now() NOT NULL,
	timelastmodified timestamp DEFAULT now() NOT NULL,
	PRIMARY KEY (feature_id)
);

CREATE TABLE chado.feature_cvterm (
	feature_cvterm_id serial NOT NULL,
	feature_id int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	pub_id int4,
	is_not bool DEFAULT false NOT NULL,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (feature_cvterm_id)
);

CREATE TABLE chado.feature_cvterm_dbxref (
	feature_cvterm_dbxref_id serial NOT NULL,
	feature_cvterm_id int4 NOT NULL,
	dbxref_id int4 NOT NULL,
	PRIMARY KEY (feature_cvterm_dbxref_id)
);

CREATE TABLE chado.feature_cvterm_pub (
	feature_cvterm_pub_id serial NOT NULL,
	feature_cvterm_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (feature_cvterm_pub_id)
);

CREATE TABLE chado.feature_cvtermprop (
	feature_cvtermprop_id serial NOT NULL,
	feature_cvterm_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (feature_cvtermprop_id)
);

CREATE TABLE chado.feature_dbxref (
	feature_dbxref_id serial NOT NULL,
	feature_id int4 NOT NULL,
	dbxref_id int4 NOT NULL,
	is_current bool DEFAULT true NOT NULL,
	PRIMARY KEY (feature_dbxref_id)
);

CREATE TABLE chado.feature_expression (
	feature_expression_id serial NOT NULL,
	expression_id int4 NOT NULL,
	feature_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (feature_expression_id)
);

CREATE TABLE chado.feature_expressionprop (
	feature_expressionprop_id serial NOT NULL,
	feature_expression_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (feature_expressionprop_id)
);

CREATE TABLE chado.feature_genotype (
	feature_genotype_id serial NOT NULL,
	feature_id int4 NOT NULL,
	genotype_id int4 NOT NULL,
	chromosome_id int4,
	"rank" int4 NOT NULL,
	cgroup int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	background_accession_id int4,
	PRIMARY KEY (feature_genotype_id)
);

CREATE TABLE chado.feature_genotype_cvterm (
	feature_genotype_cvterm_id serial NOT NULL,
	feature_genotype_id int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	pub_id int4,
	is_not bool,
	"rank" int4,
	PRIMARY KEY (feature_genotype_cvterm_id)
);

CREATE TABLE chado.feature_genotype_prop (
	feature_genotype_prop_id serial NOT NULL,
	feature_genotype_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (feature_genotype_prop_id)
);

CREATE TABLE chado.feature_phenotype (
	feature_phenotype_id serial NOT NULL,
	feature_id int4 NOT NULL,
	phenotype_id int4 NOT NULL,
	PRIMARY KEY (feature_phenotype_id)
);

CREATE TABLE chado.feature_pub (
	feature_pub_id serial NOT NULL,
	feature_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (feature_pub_id)
);

CREATE TABLE chado.feature_pubprop (
	feature_pubprop_id serial NOT NULL,
	feature_pub_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (feature_pubprop_id)
);

CREATE TABLE chado.feature_relationship (
	feature_relationship_id serial NOT NULL,
	subject_id int4 NOT NULL,
	object_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (feature_relationship_id)
);

CREATE TABLE chado.feature_relationship_pub (
	feature_relationship_pub_id serial NOT NULL,
	feature_relationship_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (feature_relationship_pub_id)
);

CREATE TABLE chado.feature_relationshipprop (
	feature_relationshipprop_id serial NOT NULL,
	feature_relationship_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (feature_relationshipprop_id)
);

create sequence feature_relationshipprop_pub_feature_relationshipprop_pub_i_seq;
CREATE TABLE chado.feature_relationshipprop_pub (
	feature_relationshipprop_pub_id int4 DEFAULT nextval('feature_relationshipprop_pub_feature_relationshipprop_pub_i_seq'::regclass) NOT NULL,
	feature_relationshipprop_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (feature_relationshipprop_pub_id)
);

CREATE TABLE chado.feature_synonym (
	feature_synonym_id serial NOT NULL,
	synonym_id int4 NOT NULL,
	feature_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	is_current bool DEFAULT false NOT NULL,
	is_internal bool DEFAULT false NOT NULL,
	PRIMARY KEY (feature_synonym_id)
);

CREATE TABLE chado.featureloc (
	featureloc_id serial NOT NULL,
	feature_id int4 NOT NULL,
	srcfeature_id int4,
	fmin int4,
	is_fmin_partial bool DEFAULT false NOT NULL,
	fmax int4,
	is_fmax_partial bool DEFAULT false NOT NULL,
	strand int2,
	phase int4,
	residue_info text,
	locgroup int4 DEFAULT 0 NOT NULL,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (featureloc_id)
);

CREATE TABLE chado.featureloc_pub (
	featureloc_pub_id serial NOT NULL,
	featureloc_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (featureloc_pub_id)
);

CREATE TABLE chado.featuremap (
	featuremap_id serial NOT NULL,
	"name" varchar(255),
	description text,
	unittype_id int4,
	PRIMARY KEY (featuremap_id)
);

CREATE TABLE chado.featuremap_pub (
	featuremap_pub_id serial NOT NULL,
	featuremap_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (featuremap_pub_id)
);

CREATE TABLE chado.featurepos (
	featurepos_id serial NOT NULL,
	featuremap_id serial NOT NULL,
	feature_id int4 NOT NULL,
	map_feature_id int4 NOT NULL,
	mappos float8 NOT NULL,
	PRIMARY KEY (featurepos_id)
);

CREATE TABLE chado.featureprop (
	featureprop_id serial NOT NULL,
	feature_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (featureprop_id)
);

CREATE TABLE chado.featureprop_pub (
	featureprop_pub_id serial NOT NULL,
	featureprop_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (featureprop_pub_id)
);

CREATE TABLE chado.featurerange (
	featurerange_id serial NOT NULL,
	featuremap_id int4 NOT NULL,
	feature_id int4 NOT NULL,
	leftstartf_id int4 NOT NULL,
	leftendf_id int4,
	rightstartf_id int4,
	rightendf_id int4 NOT NULL,
	rangestr varchar(255),
	PRIMARY KEY (featurerange_id)
);

CREATE TABLE chado.genotype (
	genotype_id serial NOT NULL,
	"name" text,
	uniquename text NOT NULL,
	description text,
	type_id int4 NOT NULL,
	dbxref_id int4,
	PRIMARY KEY (genotype_id)
);

CREATE TABLE chado.genotype_cvterm (
	genotype_cvterm_id serial NOT NULL,
	genotype_id int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	pub_id int4,
	is_not bool DEFAULT false NOT NULL,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (genotype_cvterm_id)
);

CREATE TABLE chado.genotype_dbxref (
	genotype_dbxref_id serial NOT NULL,
	genotype_id int4 NOT NULL,
	dbxref_id int4 NOT NULL,
	is_current bool DEFAULT true NOT NULL,
	PRIMARY KEY (genotype_dbxref_id)
);

CREATE TABLE chado.genotype_synonym (
	genotype_synonym_id serial NOT NULL,
	synonym_id int4 NOT NULL,
	genotype_id int4 NOT NULL,
	pub_id int4,
	is_current bool DEFAULT true NOT NULL,
	is_internal bool DEFAULT false NOT NULL,
	PRIMARY KEY (genotype_synonym_id)
);

CREATE TABLE chado.genotypeprop (
	genotypeprop_id serial NOT NULL,
	genotype_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (genotypeprop_id)
);

CREATE TABLE chado."library" (
	library_id serial NOT NULL,
	organism_id int4 NOT NULL,
	"name" varchar(255),
	uniquename text NOT NULL,
	type_id int4 NOT NULL,
	is_obsolete int4 DEFAULT 0 NOT NULL,
	timeaccessioned timestamp DEFAULT now() NOT NULL,
	timelastmodified timestamp DEFAULT now() NOT NULL,
	PRIMARY KEY (library_id)
);

CREATE TABLE chado.library_cvterm (
	library_cvterm_id serial NOT NULL,
	library_id int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (library_cvterm_id)
);

CREATE TABLE chado.library_dbxref (
	library_dbxref_id serial NOT NULL,
	library_id int4 NOT NULL,
	dbxref_id int4 NOT NULL,
	is_current bool DEFAULT true NOT NULL,
	PRIMARY KEY (library_dbxref_id)
);

CREATE TABLE chado.library_feature (
	library_feature_id serial NOT NULL,
	library_id int4 NOT NULL,
	feature_id int4 NOT NULL,
	PRIMARY KEY (library_feature_id)
);

CREATE TABLE chado.library_pub (
	library_pub_id serial NOT NULL,
	library_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (library_pub_id)
);

CREATE TABLE chado.library_synonym (
	library_synonym_id serial NOT NULL,
	synonym_id int4 NOT NULL,
	library_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	is_current bool DEFAULT true NOT NULL,
	is_internal bool DEFAULT false NOT NULL,
	PRIMARY KEY (library_synonym_id)
);

CREATE TABLE chado.libraryprop (
	libraryprop_id serial NOT NULL,
	library_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (libraryprop_id)
);

CREATE TABLE chado.libraryprop_pub (
	libraryprop_pub_id serial NOT NULL,
	libraryprop_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (libraryprop_pub_id)
);

CREATE TABLE chado.magedocumentation (
	magedocumentation_id serial NOT NULL,
	mageml_id int4 NOT NULL,
	tableinfo_id int4 NOT NULL,
	row_id int4 NOT NULL,
	mageidentifier text NOT NULL,
	PRIMARY KEY (magedocumentation_id)
);

CREATE TABLE chado.mageml (
	mageml_id serial NOT NULL,
	mage_package text NOT NULL,
	mage_ml text NOT NULL,
	PRIMARY KEY (mageml_id)
);

CREATE TABLE chado.materialized_view (
	materialized_view_id serial NOT NULL,
	last_update timestamp,
	refresh_time int4,
	"name" varchar(64),
	mv_schema varchar(64),
	mv_table varchar(128),
	mv_specs text,
	indexed text,
	query text,
	special_index text
);

CREATE TABLE chado.nd_experiment (
	nd_experiment_id serial NOT NULL,
	nd_geolocation_id int4 NOT NULL,
	type_id int4 NOT NULL,
	PRIMARY KEY (nd_experiment_id)
);

CREATE TABLE chado.nd_experiment_contact (
	nd_experiment_contact_id serial NOT NULL,
	nd_experiment_id int4 NOT NULL,
	contact_id int4 NOT NULL,
	PRIMARY KEY (nd_experiment_contact_id)
);

CREATE TABLE chado.nd_experiment_dbxref (
	nd_experiment_dbxref_id serial NOT NULL,
	nd_experiment_id int4 NOT NULL,
	dbxref_id int4 NOT NULL,
	PRIMARY KEY (nd_experiment_dbxref_id)
);

CREATE TABLE chado.nd_experiment_genotype (
	nd_experiment_genotype_id serial NOT NULL,
	nd_experiment_id int4 NOT NULL,
	genotype_id int4 NOT NULL,
	PRIMARY KEY (nd_experiment_genotype_id)
);

CREATE TABLE chado.nd_experiment_phenotype (
	nd_experiment_phenotype_id serial NOT NULL,
	nd_experiment_id int4 NOT NULL,
	phenotype_id int4 NOT NULL,
	PRIMARY KEY (nd_experiment_phenotype_id)
);

CREATE TABLE chado.nd_experiment_project (
	nd_experiment_project_id serial NOT NULL,
	project_id int4 NOT NULL,
	nd_experiment_id int4 NOT NULL,
	PRIMARY KEY (nd_experiment_project_id)
);

CREATE TABLE chado.nd_experiment_protocol (
	nd_experiment_protocol_id serial NOT NULL,
	nd_experiment_id int4 NOT NULL,
	nd_protocol_id int4 NOT NULL,
	PRIMARY KEY (nd_experiment_protocol_id)
);

CREATE TABLE chado.nd_experiment_pub (
	nd_experiment_pub_id serial NOT NULL,
	nd_experiment_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (nd_experiment_pub_id)
);

CREATE TABLE chado.nd_experiment_stock (
	nd_experiment_stock_id serial NOT NULL,
	nd_experiment_id int4 NOT NULL,
	stock_id int4 NOT NULL,
	type_id int4 NOT NULL,
	PRIMARY KEY (nd_experiment_stock_id)
);

CREATE TABLE chado.nd_experiment_stock_dbxref (
	nd_experiment_stock_dbxref_id serial NOT NULL,
	nd_experiment_stock_id int4 NOT NULL,
	dbxref_id int4 NOT NULL,
	PRIMARY KEY (nd_experiment_stock_dbxref_id)
);

CREATE TABLE chado.nd_experiment_stockprop (
	nd_experiment_stockprop_id serial NOT NULL,
	nd_experiment_stock_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (nd_experiment_stockprop_id)
);

CREATE TABLE chado.nd_experimentprop (
	nd_experimentprop_id serial NOT NULL,
	nd_experiment_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (nd_experimentprop_id)
);

CREATE TABLE chado.nd_geolocation (
	nd_geolocation_id serial NOT NULL,
	description varchar(255),
	latitude float4,
	longitude float4,
	geodetic_datum varchar(32),
	altitude float4,
	PRIMARY KEY (nd_geolocation_id)
);

CREATE TABLE chado.nd_geolocationprop (
	nd_geolocationprop_id serial NOT NULL,
	nd_geolocation_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (nd_geolocationprop_id)
);

CREATE TABLE chado.nd_protocol (
	nd_protocol_id serial NOT NULL,
	"name" varchar(255) NOT NULL,
	type_id int4 NOT NULL,
	PRIMARY KEY (nd_protocol_id)
);

CREATE TABLE chado.nd_protocol_reagent (
	nd_protocol_reagent_id serial NOT NULL,
	nd_protocol_id int4 NOT NULL,
	reagent_id int4 NOT NULL,
	type_id int4 NOT NULL,
	PRIMARY KEY (nd_protocol_reagent_id)
);

CREATE TABLE chado.nd_protocolprop (
	nd_protocolprop_id serial NOT NULL,
	nd_protocol_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (nd_protocolprop_id)
);

CREATE TABLE chado.nd_reagent (
	nd_reagent_id serial NOT NULL,
	"name" varchar(80) NOT NULL,
	type_id int4 NOT NULL,
	feature_id int4,
	PRIMARY KEY (nd_reagent_id)
);

CREATE TABLE chado.nd_reagent_relationship (
	nd_reagent_relationship_id serial NOT NULL,
	subject_reagent_id int4 NOT NULL,
	object_reagent_id int4 NOT NULL,
	type_id int4 NOT NULL,
	PRIMARY KEY (nd_reagent_relationship_id)
);

CREATE TABLE chado.nd_reagentprop (
	nd_reagentprop_id serial NOT NULL,
	nd_reagent_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (nd_reagentprop_id)
);

CREATE TABLE chado.oauth_common_consumer (
	csid serial NOT NULL,
	key_hash char(40) NOT NULL,
	consumer_key text NOT NULL,
	secret text NOT NULL,
	"configuration" text NOT NULL,
	PRIMARY KEY (csid)
);

CREATE TABLE chado.oauth_common_context (
	cid serial NOT NULL,
	"name" varchar(32) NOT NULL,
	title varchar(100) NOT NULL,
	authorization_options text NOT NULL,
	authorization_levels text NOT NULL,
	PRIMARY KEY (cid)
);

CREATE TABLE chado.oauth_common_nonce (
	nonce varchar(255) NOT NULL,
	"timestamp" int4 NOT NULL,
	token_key varchar(32) NOT NULL,
	PRIMARY KEY (nonce)
);

CREATE TABLE chado.oauth_common_provider_consumer (
	csid int8 DEFAULT 0,
	consumer_key char(32) NOT NULL,
	created int4 DEFAULT 0 NOT NULL,
	changed int4 DEFAULT 0 NOT NULL,
	uid int8 NOT NULL,
	"name" varchar(128) NOT NULL,
	context varchar(32) DEFAULT ''::character varying NOT NULL,
	callback_url varchar(255) NOT NULL,
	PRIMARY KEY (consumer_key)
);

CREATE TABLE chado.oauth_common_provider_token (
	tid int8 DEFAULT 0,
	token_key char(32) NOT NULL,
	created int4 DEFAULT 0 NOT NULL,
	changed int4 DEFAULT 0 NOT NULL,
	services text,
	authorized int2 DEFAULT 0 NOT NULL,
	PRIMARY KEY (token_key)
);

CREATE TABLE chado.oauth_common_token (
	tid serial NOT NULL,
	csid int8 DEFAULT 0 NOT NULL,
	key_hash char(40) NOT NULL,
	token_key text NOT NULL,
	secret text NOT NULL,
	expires int4 DEFAULT 0 NOT NULL,
	"type" int2 DEFAULT 1 NOT NULL,
	uid int8 DEFAULT 0 NOT NULL,
	PRIMARY KEY (tid)
);

CREATE TABLE chado.organism (
	organism_id serial NOT NULL,
	abbreviation varchar(255),
	genus varchar(255) NOT NULL,
	species varchar(255) NOT NULL,
	common_name varchar(255),
	"comment" text,
	PRIMARY KEY (organism_id)
);

CREATE TABLE chado.organism_dbxref (
	organism_dbxref_id serial NOT NULL,
	organism_id int4 NOT NULL,
	dbxref_id int4 NOT NULL,
	PRIMARY KEY (organism_dbxref_id)
);

CREATE TABLE chado.organism_feature_count (
	organism_id int4 NOT NULL,
	genus varchar(255) NOT NULL,
	species varchar(255) NOT NULL,
	common_name varchar(255),
	num_features int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	feature_type varchar(255) NOT NULL
);

CREATE TABLE chado.organismprop (
	organismprop_id serial NOT NULL,
	organism_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (organismprop_id)
);

CREATE TABLE chado.phendesc (
	phendesc_id serial NOT NULL,
	genotype_id int4 NOT NULL,
	environment_id int4 NOT NULL,
	description text NOT NULL,
	type_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (phendesc_id)
);

CREATE TABLE chado.phenotype (
	phenotype_id serial NOT NULL,
	uniquename text NOT NULL,
	"name" text,
	observable_id int4,
	attr_id int4,
	"value" text,
	cvalue_id int4,
	assay_id int4,
	PRIMARY KEY (phenotype_id)
);

CREATE TABLE chado.phenotype_comparison (
	phenotype_comparison_id serial NOT NULL,
	genotype1_id int4 NOT NULL,
	environment1_id int4 NOT NULL,
	genotype2_id int4 NOT NULL,
	environment2_id int4 NOT NULL,
	phenotype1_id int4 NOT NULL,
	phenotype2_id int4,
	pub_id int4 NOT NULL,
	organism_id int4 NOT NULL,
	PRIMARY KEY (phenotype_comparison_id)
);

CREATE TABLE chado.phenotype_comparison_cvterm (
	phenotype_comparison_cvterm_id serial NOT NULL,
	phenotype_comparison_id int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (phenotype_comparison_cvterm_id)
);

CREATE TABLE chado.phenotype_cvterm (
	phenotype_cvterm_id serial NOT NULL,
	phenotype_id int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (phenotype_cvterm_id)
);

CREATE TABLE chado.phenstatement (
	phenstatement_id serial NOT NULL,
	genotype_id int4 NOT NULL,
	environment_id int4 NOT NULL,
	phenotype_id int4 NOT NULL,
	type_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (phenstatement_id)
);

CREATE TABLE chado.phylonode (
	phylonode_id serial NOT NULL,
	phylotree_id int4 NOT NULL,
	parent_phylonode_id int4,
	left_idx int4 NOT NULL,
	right_idx int4 NOT NULL,
	type_id int4,
	feature_id int4,
	"label" varchar(255),
	distance float8,
	PRIMARY KEY (phylonode_id)
);

CREATE TABLE chado.phylonode_dbxref (
	phylonode_dbxref_id serial NOT NULL,
	phylonode_id int4 NOT NULL,
	dbxref_id int4 NOT NULL,
	PRIMARY KEY (phylonode_dbxref_id)
);

CREATE TABLE chado.phylonode_organism (
	phylonode_organism_id serial NOT NULL,
	phylonode_id int4 NOT NULL,
	organism_id int4 NOT NULL,
	PRIMARY KEY (phylonode_organism_id)
);

CREATE TABLE chado.phylonode_pub (
	phylonode_pub_id serial NOT NULL,
	phylonode_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (phylonode_pub_id)
);

CREATE TABLE chado.phylonode_relationship (
	phylonode_relationship_id serial NOT NULL,
	subject_id int4 NOT NULL,
	object_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"rank" int4,
	phylotree_id int4 NOT NULL,
	PRIMARY KEY (phylonode_relationship_id)
);

CREATE TABLE chado.phylonodeprop (
	phylonodeprop_id serial NOT NULL,
	phylonode_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text DEFAULT ''::text NOT NULL,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (phylonodeprop_id)
);

CREATE TABLE chado.phylotree (
	phylotree_id serial NOT NULL,
	dbxref_id int4 NOT NULL,
	"name" varchar(255),
	type_id int4,
	analysis_id int4,
	"comment" text,
	PRIMARY KEY (phylotree_id)
);

CREATE TABLE chado.phylotree_pub (
	phylotree_pub_id serial NOT NULL,
	phylotree_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (phylotree_pub_id)
);

CREATE TABLE chado.project (
	project_id serial NOT NULL,
	"name" varchar(255) NOT NULL,
	description varchar(255) NOT NULL,
	PRIMARY KEY (project_id)
);

CREATE TABLE chado.project_contact (
	project_contact_id serial NOT NULL,
	project_id int4 NOT NULL,
	contact_id int4 NOT NULL,
	PRIMARY KEY (project_contact_id)
);

CREATE TABLE chado.project_pub (
	project_pub_id serial NOT NULL,
	project_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (project_pub_id)
);

CREATE TABLE chado.project_relationship (
	project_relationship_id serial NOT NULL,
	subject_project_id int4 NOT NULL,
	object_project_id int4 NOT NULL,
	type_id int4 NOT NULL,
	PRIMARY KEY (project_relationship_id)
);

CREATE TABLE chado.projectprop (
	projectprop_id serial NOT NULL,
	project_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (projectprop_id)
);

CREATE TABLE chado.protocol (
	protocol_id serial NOT NULL,
	type_id int4 NOT NULL,
	pub_id int4,
	dbxref_id int4,
	"name" text NOT NULL,
	"uri" text,
	protocoldescription text,
	hardwaredescription text,
	softwaredescription text,
	PRIMARY KEY (protocol_id)
);

CREATE TABLE chado.protocolparam (
	protocolparam_id serial NOT NULL,
	protocol_id int4 NOT NULL,
	"name" text NOT NULL,
	datatype_id int4,
	unittype_id int4,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (protocolparam_id)
);

CREATE TABLE chado.pub (
	pub_id serial NOT NULL,
	title text,
	volumetitle text,
	volume varchar(255),
	series_name varchar(255),
	issue varchar(255),
	pyear varchar(255),
	pages varchar(255),
	miniref varchar(255),
	uniquename text NOT NULL,
	type_id int4 NOT NULL,
	is_obsolete bool DEFAULT false,
	publisher varchar(255),
	pubplace varchar(255),
	PRIMARY KEY (pub_id)
);

CREATE TABLE chado.pub_dbxref (
	pub_dbxref_id serial NOT NULL,
	pub_id int4 NOT NULL,
	dbxref_id int4 NOT NULL,
	is_current bool DEFAULT true NOT NULL,
	PRIMARY KEY (pub_dbxref_id)
);

CREATE TABLE chado.pub_relationship (
	pub_relationship_id serial NOT NULL,
	subject_id int4 NOT NULL,
	object_id int4 NOT NULL,
	type_id int4 NOT NULL,
	PRIMARY KEY (pub_relationship_id)
);

CREATE TABLE chado.pubauthor (
	pubauthor_id serial NOT NULL,
	pub_id int4 NOT NULL,
	"rank" int4 NOT NULL,
	editor bool DEFAULT false,
	surname varchar(100) NOT NULL,
	givennames varchar(100),
	suffix varchar(100),
	PRIMARY KEY (pubauthor_id)
);

CREATE TABLE chado.pubauthor_contact (
	pubauthor_contact_id serial NOT NULL,
	contact_id int4 NOT NULL,
	pubauthor_id int4 NOT NULL,
	PRIMARY KEY (pubauthor_contact_id)
);

CREATE TABLE chado.pubprop (
	pubprop_id serial NOT NULL,
	pub_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text NOT NULL,
	"rank" int4,
	PRIMARY KEY (pubprop_id)
);

CREATE TABLE chado.quantification (
	quantification_id serial NOT NULL,
	acquisition_id int4 NOT NULL,
	operator_id int4,
	protocol_id int4,
	analysis_id int4 NOT NULL,
	quantificationdate timestamp DEFAULT now(),
	"name" text,
	"uri" text,
	PRIMARY KEY (quantification_id)
);

CREATE TABLE chado.quantification_relationship (
	quantification_relationship_id serial NOT NULL,
	subject_id int4 NOT NULL,
	type_id int4 NOT NULL,
	object_id int4 NOT NULL,
	PRIMARY KEY (quantification_relationship_id)
);

CREATE TABLE chado.quantificationprop (
	quantificationprop_id serial NOT NULL,
	quantification_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (quantificationprop_id)
);

CREATE TABLE chado.services_endpoint (
	eid serial NOT NULL,
	"name" varchar(255) NOT NULL,
	"server" varchar(32) NOT NULL,
	"path" varchar(255) NOT NULL,
	authentication text NOT NULL,
	server_settings bytea NOT NULL,
	resources text NOT NULL,
	debug int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (eid)
);

CREATE TABLE chado.services_user (
	uid int8 NOT NULL,
	created int4 DEFAULT 0 NOT NULL,
	changed int4 DEFAULT 0 NOT NULL
);

CREATE TABLE chado.stock (
	stock_id serial NOT NULL,
	dbxref_id int4,
	organism_id int4,
	"name" varchar(255),
	uniquename text NOT NULL,
	description text,
	type_id int4 NOT NULL,
	is_obsolete bool DEFAULT false NOT NULL,
	PRIMARY KEY (stock_id)
);

CREATE TABLE chado.stock_cvterm (
	stock_cvterm_id serial NOT NULL,
	stock_id int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	pub_id int4,
	is_not bool DEFAULT false NOT NULL,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (stock_cvterm_id)
);

CREATE TABLE chado.stock_cvtermprop (
	stock_cvtermprop_id serial NOT NULL,
	stock_cvterm_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (stock_cvtermprop_id)
);

CREATE TABLE chado.stock_dbxref (
	stock_dbxref_id serial NOT NULL,
	stock_id int4 NOT NULL,
	dbxref_id int4 NOT NULL,
	is_current bool DEFAULT true NOT NULL,
	PRIMARY KEY (stock_dbxref_id)
);

CREATE TABLE chado.stock_dbxrefprop (
	stock_dbxrefprop_id serial NOT NULL,
	stock_dbxref_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (stock_dbxrefprop_id)
);

CREATE TABLE chado.stock_genotype (
	stock_genotype_id serial NOT NULL,
	stock_id int4 NOT NULL,
	genotype_id int4 NOT NULL,
	PRIMARY KEY (stock_genotype_id)
);

CREATE TABLE chado.stock_genotype_cvterm (
	stock_genotype_cvterm_id serial NOT NULL,
	stock_genotype_id int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	pub_id int4,
	PRIMARY KEY (stock_genotype_cvterm_id)
);

CREATE TABLE chado.stock_genotype_prop (
	stock_genotype_prop_id serial NOT NULL,
	stock_genotype_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (stock_genotype_prop_id)
);

CREATE TABLE chado.stock_pub (
	stock_pub_id serial NOT NULL,
	stock_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (stock_pub_id)
);

CREATE TABLE chado.stock_relationship (
	stock_relationship_id serial NOT NULL,
	subject_id int4 NOT NULL,
	object_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	background_accession_id int8,
	PRIMARY KEY (stock_relationship_id)
);

CREATE TABLE chado.stock_relationship_cvterm (
	stock_relationship_cvterm_id serial NOT NULL,
	stock_relationship_id int4 NOT NULL,
	cvterm_id int4 NOT NULL,
	pub_id int4,
	PRIMARY KEY (stock_relationship_cvterm_id)
);

CREATE TABLE chado.stock_relationship_pub (
	stock_relationship_pub_id serial NOT NULL,
	stock_relationship_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (stock_relationship_pub_id)
);

CREATE TABLE chado.stock_synonym (
	stock_synonym_id serial NOT NULL,
	synonym_id int4 NOT NULL,
	stock_id int4 NOT NULL,
	pub_id int4,
	is_current bool DEFAULT true NOT NULL,
	is_internal bool DEFAULT false NOT NULL,
	PRIMARY KEY (stock_synonym_id)
);

CREATE TABLE chado.stockcollection (
	stockcollection_id serial NOT NULL,
	type_id int4 NOT NULL,
	contact_id int4,
	"name" varchar(255),
	uniquename text NOT NULL,
	PRIMARY KEY (stockcollection_id)
);

CREATE TABLE chado.stockcollection_stock (
	stockcollection_stock_id serial NOT NULL,
	stockcollection_id int4 NOT NULL,
	stock_id int4 NOT NULL,
	PRIMARY KEY (stockcollection_stock_id)
);

CREATE TABLE chado.stockcollectionprop (
	stockcollectionprop_id serial NOT NULL,
	stockcollection_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (stockcollectionprop_id)
);

CREATE TABLE chado.stockprop (
	stockprop_id serial NOT NULL,
	stock_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (stockprop_id)
);

CREATE TABLE chado.stockprop_pub (
	stockprop_pub_id serial NOT NULL,
	stockprop_id int4 NOT NULL,
	pub_id int4 NOT NULL,
	PRIMARY KEY (stockprop_pub_id)
);

CREATE TABLE chado.study (
	study_id serial NOT NULL,
	contact_id int4 NOT NULL,
	pub_id int4,
	dbxref_id int4,
	"name" text NOT NULL,
	description text,
	PRIMARY KEY (study_id)
);

CREATE TABLE chado.study_assay (
	study_assay_id serial NOT NULL,
	study_id int4 NOT NULL,
	assay_id int4 NOT NULL,
	PRIMARY KEY (study_assay_id)
);

CREATE TABLE chado.studydesign (
	studydesign_id serial NOT NULL,
	study_id int4 NOT NULL,
	description text,
	PRIMARY KEY (studydesign_id)
);

CREATE TABLE chado.studydesignprop (
	studydesignprop_id serial NOT NULL,
	studydesign_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (studydesignprop_id)
);

CREATE TABLE chado.studyfactor (
	studyfactor_id serial NOT NULL,
	studydesign_id int4 NOT NULL,
	type_id int4,
	"name" text NOT NULL,
	description text,
	PRIMARY KEY (studyfactor_id)
);

CREATE TABLE chado.studyfactorvalue (
	studyfactorvalue_id serial NOT NULL,
	studyfactor_id int4 NOT NULL,
	assay_id int4 NOT NULL,
	factorvalue text,
	"name" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (studyfactorvalue_id)
);

CREATE TABLE chado.studyprop (
	studyprop_id serial NOT NULL,
	study_id int4 NOT NULL,
	type_id int4 NOT NULL,
	"value" text,
	"rank" int4 DEFAULT 0 NOT NULL,
	PRIMARY KEY (studyprop_id)
);

CREATE TABLE chado.studyprop_feature (
	studyprop_feature_id serial NOT NULL,
	studyprop_id int4 NOT NULL,
	feature_id int4 NOT NULL,
	type_id int4,
	PRIMARY KEY (studyprop_feature_id)
);

CREATE TABLE chado.synonym (
	synonym_id serial NOT NULL,
	"name" varchar(255) NOT NULL,
	type_id int4 NOT NULL,
	synonym_sgml varchar(255) NOT NULL,
	PRIMARY KEY (synonym_id)
);

CREATE TABLE chado.tableinfo (
	tableinfo_id serial NOT NULL,
	"name" varchar(30) NOT NULL,
	primary_key_column varchar(30),
	is_view int4 DEFAULT 0 NOT NULL,
	view_on_table_id int4,
	superclass_table_id int4,
	is_updateable int4 DEFAULT 1 NOT NULL,
	modification_date date DEFAULT now() NOT NULL,
	PRIMARY KEY (tableinfo_id)
);

CREATE TABLE chado.treatment (
	treatment_id serial NOT NULL,
	"rank" int4 DEFAULT 0 NOT NULL,
	biomaterial_id int4 NOT NULL,
	type_id int4 NOT NULL,
	protocol_id int4,
	"name" text,
	PRIMARY KEY (treatment_id)
);

CREATE TABLE chado.tripal_gff_temp (
	feature_id int4 NOT NULL,
	organism_id int4 NOT NULL,
	uniquename text NOT NULL,
	type_name varchar(1024) NOT NULL
);

CREATE TABLE chado.tripal_obo_temp (
	"id" varchar(255) NOT NULL,
	stanza text NOT NULL,
	"type" varchar(50) NOT NULL
);

ALTER TABLE chado.acquisition
	ADD FOREIGN KEY (assay_id) 
	REFERENCES chado.assay (assay_id);

ALTER TABLE chado.acquisition
	ADD FOREIGN KEY (channel_id) 
	REFERENCES chado.channel (channel_id);

ALTER TABLE chado.acquisition
	ADD FOREIGN KEY (protocol_id) 
	REFERENCES chado.protocol (protocol_id);



ALTER TABLE chado.acquisition_relationship
	ADD FOREIGN KEY (object_id,subject_id) 
	REFERENCES chado.acquisition (acquisition_id,acquisition_id);

ALTER TABLE chado.acquisition_relationship
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.acquisitionprop
	ADD FOREIGN KEY (acquisition_id) 
	REFERENCES chado.acquisition (acquisition_id);

ALTER TABLE chado.acquisitionprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.analysis_organism
	ADD FOREIGN KEY (analysis_id) 
	REFERENCES chado.analysis (analysis_id);

ALTER TABLE chado.analysis_organism
	ADD FOREIGN KEY (organism_id) 
	REFERENCES chado.organism (organism_id);



ALTER TABLE chado.analysisfeature
	ADD FOREIGN KEY (analysis_id) 
	REFERENCES chado.analysis (analysis_id);

ALTER TABLE chado.analysisfeature
	ADD FOREIGN KEY (feature_id) 
	REFERENCES chado.feature (feature_id);



ALTER TABLE chado.analysisfeatureprop
	ADD FOREIGN KEY (analysisfeature_id) 
	REFERENCES chado.analysisfeature (analysisfeature_id);

ALTER TABLE chado.analysisfeatureprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.analysisprop
	ADD FOREIGN KEY (analysis_id) 
	REFERENCES chado.analysis (analysis_id);

ALTER TABLE chado.analysisprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.arraydesign
	ADD FOREIGN KEY (manufacturer_id) 
	REFERENCES chado.contact (contact_id);

ALTER TABLE chado.arraydesign
	ADD FOREIGN KEY (platformtype_id,substratetype_id) 
	REFERENCES chado.cvterm (cvterm_id,cvterm_id);

ALTER TABLE chado.arraydesign
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.arraydesign
	ADD FOREIGN KEY (protocol_id) 
	REFERENCES chado.protocol (protocol_id);



ALTER TABLE chado.arraydesignprop
	ADD FOREIGN KEY (arraydesign_id) 
	REFERENCES chado.arraydesign (arraydesign_id);

ALTER TABLE chado.arraydesignprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.assay
	ADD FOREIGN KEY (arraydesign_id) 
	REFERENCES chado.arraydesign (arraydesign_id);

ALTER TABLE chado.assay
	ADD FOREIGN KEY (operator_id) 
	REFERENCES chado.contact (contact_id);

ALTER TABLE chado.assay
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.assay
	ADD FOREIGN KEY (protocol_id) 
	REFERENCES chado.protocol (protocol_id);



ALTER TABLE chado.assay_biomaterial
	ADD FOREIGN KEY (assay_id) 
	REFERENCES chado.assay (assay_id);

ALTER TABLE chado.assay_biomaterial
	ADD FOREIGN KEY (biomaterial_id) 
	REFERENCES chado.biomaterial (biomaterial_id);

ALTER TABLE chado.assay_biomaterial
	ADD FOREIGN KEY (channel_id) 
	REFERENCES chado.channel (channel_id);



ALTER TABLE chado.assay_project
	ADD FOREIGN KEY (assay_id) 
	REFERENCES chado.assay (assay_id);

ALTER TABLE chado.assay_project
	ADD FOREIGN KEY (project_id) 
	REFERENCES chado.project (project_id);



ALTER TABLE chado.assayprop
	ADD FOREIGN KEY (assay_id) 
	REFERENCES chado.assay (assay_id);

ALTER TABLE chado.assayprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.biomaterial
	ADD FOREIGN KEY (biosourceprovider_id) 
	REFERENCES chado.contact (contact_id);

ALTER TABLE chado.biomaterial
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.biomaterial
	ADD FOREIGN KEY (taxon_id) 
	REFERENCES chado.organism (organism_id);



ALTER TABLE chado.biomaterial_dbxref
	ADD FOREIGN KEY (biomaterial_id) 
	REFERENCES chado.biomaterial (biomaterial_id);

ALTER TABLE chado.biomaterial_dbxref
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);



ALTER TABLE chado.biomaterial_relationship
	ADD FOREIGN KEY (object_id,subject_id) 
	REFERENCES chado.biomaterial (biomaterial_id,biomaterial_id);

ALTER TABLE chado.biomaterial_relationship
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.biomaterial_treatment
	ADD FOREIGN KEY (biomaterial_id) 
	REFERENCES chado.biomaterial (biomaterial_id);

ALTER TABLE chado.biomaterial_treatment
	ADD FOREIGN KEY (unittype_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.biomaterial_treatment
	ADD FOREIGN KEY (treatment_id) 
	REFERENCES chado.treatment (treatment_id);



ALTER TABLE chado.biomaterialprop
	ADD FOREIGN KEY (biomaterial_id) 
	REFERENCES chado.biomaterial (biomaterial_id);

ALTER TABLE chado.biomaterialprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.cell_line
	ADD FOREIGN KEY (organism_id) 
	REFERENCES chado.organism (organism_id);



ALTER TABLE chado.cell_line_cvterm
	ADD FOREIGN KEY (cell_line_id) 
	REFERENCES chado.cell_line (cell_line_id);

ALTER TABLE chado.cell_line_cvterm
	ADD FOREIGN KEY (cvterm_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.cell_line_cvterm
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.cell_line_cvtermprop
	ADD FOREIGN KEY (cell_line_cvterm_id) 
	REFERENCES chado.cell_line_cvterm (cell_line_cvterm_id);

ALTER TABLE chado.cell_line_cvtermprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.cell_line_dbxref
	ADD FOREIGN KEY (cell_line_id) 
	REFERENCES chado.cell_line (cell_line_id);

ALTER TABLE chado.cell_line_dbxref
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);



ALTER TABLE chado.cell_line_feature
	ADD FOREIGN KEY (cell_line_id) 
	REFERENCES chado.cell_line (cell_line_id);

ALTER TABLE chado.cell_line_feature
	ADD FOREIGN KEY (feature_id) 
	REFERENCES chado.feature (feature_id);

ALTER TABLE chado.cell_line_feature
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.cell_line_library
	ADD FOREIGN KEY (cell_line_id) 
	REFERENCES chado.cell_line (cell_line_id);

ALTER TABLE chado.cell_line_library
	ADD FOREIGN KEY (library_id) 
	REFERENCES chado."library" (library_id);

ALTER TABLE chado.cell_line_library
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.cell_line_pub
	ADD FOREIGN KEY (cell_line_id) 
	REFERENCES chado.cell_line (cell_line_id);

ALTER TABLE chado.cell_line_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.cell_line_relationship
	ADD FOREIGN KEY (object_id,subject_id) 
	REFERENCES chado.cell_line (cell_line_id,cell_line_id);

ALTER TABLE chado.cell_line_relationship
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.cell_line_synonym
	ADD FOREIGN KEY (cell_line_id) 
	REFERENCES chado.cell_line (cell_line_id);

ALTER TABLE chado.cell_line_synonym
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);

ALTER TABLE chado.cell_line_synonym
	ADD FOREIGN KEY (synonym_id) 
	REFERENCES chado.synonym (synonym_id);



ALTER TABLE chado.cell_lineprop
	ADD FOREIGN KEY (cell_line_id) 
	REFERENCES chado.cell_line (cell_line_id);

ALTER TABLE chado.cell_lineprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.cell_lineprop_pub
	ADD FOREIGN KEY (cell_lineprop_id) 
	REFERENCES chado.cell_lineprop (cell_lineprop_id);

ALTER TABLE chado.cell_lineprop_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.chadoprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.contact
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.contact_relationship
	ADD FOREIGN KEY (object_id,subject_id) 
	REFERENCES chado.contact (contact_id,contact_id);

ALTER TABLE chado.contact_relationship
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado."control"
	ADD FOREIGN KEY (assay_id) 
	REFERENCES chado.assay (assay_id);

ALTER TABLE chado."control"
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado."control"
	ADD FOREIGN KEY (tableinfo_id) 
	REFERENCES chado.tableinfo (tableinfo_id);



ALTER TABLE chado.cvprop
	ADD FOREIGN KEY (cv_id) 
	REFERENCES chado.cv (cv_id);

ALTER TABLE chado.cvprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.cvterm
	ADD FOREIGN KEY (cv_id) 
	REFERENCES chado.cv (cv_id);

ALTER TABLE chado.cvterm
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);



ALTER TABLE chado.cvterm_dbxref
	ADD FOREIGN KEY (cvterm_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.cvterm_dbxref
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);



ALTER TABLE chado.cvterm_relationship
	ADD FOREIGN KEY (object_id,subject_id,type_id) 
	REFERENCES chado.cvterm (cvterm_id,cvterm_id,cvterm_id);



ALTER TABLE chado.cvtermpath
	ADD FOREIGN KEY (cv_id) 
	REFERENCES chado.cv (cv_id);

ALTER TABLE chado.cvtermpath
	ADD FOREIGN KEY (object_id,subject_id,type_id) 
	REFERENCES chado.cvterm (cvterm_id,cvterm_id,cvterm_id);



ALTER TABLE chado.cvtermprop
	ADD FOREIGN KEY (cvterm_id,type_id) 
	REFERENCES chado.cvterm (cvterm_id,cvterm_id);



ALTER TABLE chado.cvtermsynonym
	ADD FOREIGN KEY (cvterm_id,type_id) 
	REFERENCES chado.cvterm (cvterm_id,cvterm_id);



ALTER TABLE chado.dbxref
	ADD FOREIGN KEY (db_id) 
	REFERENCES chado."db" (db_id);



ALTER TABLE chado.dbxrefprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.dbxrefprop
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);



ALTER TABLE chado."element"
	ADD FOREIGN KEY (arraydesign_id) 
	REFERENCES chado.arraydesign (arraydesign_id);

ALTER TABLE chado."element"
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado."element"
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado."element"
	ADD FOREIGN KEY (feature_id) 
	REFERENCES chado.feature (feature_id);



ALTER TABLE chado.element_relationship
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.element_relationship
	ADD FOREIGN KEY (object_id,subject_id) 
	REFERENCES chado."element" (element_id,element_id);



ALTER TABLE chado.elementresult
	ADD FOREIGN KEY (element_id) 
	REFERENCES chado."element" (element_id);

ALTER TABLE chado.elementresult
	ADD FOREIGN KEY (quantification_id) 
	REFERENCES chado.quantification (quantification_id);



ALTER TABLE chado.elementresult_relationship
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.elementresult_relationship
	ADD FOREIGN KEY (object_id,subject_id) 
	REFERENCES chado.elementresult (elementresult_id,elementresult_id);



ALTER TABLE chado.environment_cvterm
	ADD FOREIGN KEY (cvterm_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.environment_cvterm
	ADD FOREIGN KEY (environment_id) 
	REFERENCES chado.environment (environment_id);



ALTER TABLE chado.expression_cvterm
	ADD FOREIGN KEY (cvterm_id,cvterm_type_id) 
	REFERENCES chado.cvterm (cvterm_id,cvterm_id);

ALTER TABLE chado.expression_cvterm
	ADD FOREIGN KEY (expression_id) 
	REFERENCES chado.expression (expression_id);



ALTER TABLE chado.expression_cvtermprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.expression_cvtermprop
	ADD FOREIGN KEY (expression_cvterm_id) 
	REFERENCES chado.expression_cvterm (expression_cvterm_id);



ALTER TABLE chado.expression_image
	ADD FOREIGN KEY (eimage_id) 
	REFERENCES chado.eimage (eimage_id);

ALTER TABLE chado.expression_image
	ADD FOREIGN KEY (expression_id) 
	REFERENCES chado.expression (expression_id);



ALTER TABLE chado.expression_pub
	ADD FOREIGN KEY (expression_id) 
	REFERENCES chado.expression (expression_id);

ALTER TABLE chado.expression_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.expressionprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.expressionprop
	ADD FOREIGN KEY (expression_id) 
	REFERENCES chado.expression (expression_id);



ALTER TABLE chado.feature
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.feature
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.feature
	ADD FOREIGN KEY (organism_id) 
	REFERENCES chado.organism (organism_id);



ALTER TABLE chado.feature_cvterm
	ADD FOREIGN KEY (cvterm_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.feature_cvterm
	ADD FOREIGN KEY (feature_id) 
	REFERENCES chado.feature (feature_id);

ALTER TABLE chado.feature_cvterm
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.feature_cvterm_dbxref
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.feature_cvterm_dbxref
	ADD FOREIGN KEY (feature_cvterm_id) 
	REFERENCES chado.feature_cvterm (feature_cvterm_id);



ALTER TABLE chado.feature_cvterm_pub
	ADD FOREIGN KEY (feature_cvterm_id) 
	REFERENCES chado.feature_cvterm (feature_cvterm_id);

ALTER TABLE chado.feature_cvterm_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.feature_cvtermprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.feature_cvtermprop
	ADD FOREIGN KEY (feature_cvterm_id) 
	REFERENCES chado.feature_cvterm (feature_cvterm_id);



ALTER TABLE chado.feature_dbxref
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.feature_dbxref
	ADD FOREIGN KEY (feature_id) 
	REFERENCES chado.feature (feature_id);



ALTER TABLE chado.feature_expression
	ADD FOREIGN KEY (expression_id) 
	REFERENCES chado.expression (expression_id);

ALTER TABLE chado.feature_expression
	ADD FOREIGN KEY (feature_id) 
	REFERENCES chado.feature (feature_id);

ALTER TABLE chado.feature_expression
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.feature_expressionprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.feature_expressionprop
	ADD FOREIGN KEY (feature_expression_id) 
	REFERENCES chado.feature_expression (feature_expression_id);



ALTER TABLE chado.feature_genotype
	ADD FOREIGN KEY (cvterm_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.feature_genotype
	ADD FOREIGN KEY (chromosome_id,feature_id) 
	REFERENCES chado.feature (feature_id,feature_id);

ALTER TABLE chado.feature_genotype
	ADD FOREIGN KEY (genotype_id) 
	REFERENCES chado.genotype (genotype_id);

ALTER TABLE chado.feature_genotype
	ADD FOREIGN KEY (background_accession_id) 
	REFERENCES chado.stock (stock_id);



ALTER TABLE chado.feature_genotype_cvterm
	ADD FOREIGN KEY (cvterm_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.feature_genotype_cvterm
	ADD FOREIGN KEY (feature_genotype_id) 
	REFERENCES chado.feature_genotype (feature_genotype_id);

ALTER TABLE chado.feature_genotype_cvterm
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.feature_genotype_prop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.feature_genotype_prop
	ADD FOREIGN KEY (feature_genotype_id) 
	REFERENCES chado.feature_genotype (feature_genotype_id);



ALTER TABLE chado.feature_phenotype
	ADD FOREIGN KEY (feature_id) 
	REFERENCES chado.feature (feature_id);

ALTER TABLE chado.feature_phenotype
	ADD FOREIGN KEY (phenotype_id) 
	REFERENCES chado.phenotype (phenotype_id);



ALTER TABLE chado.feature_pub
	ADD FOREIGN KEY (feature_id) 
	REFERENCES chado.feature (feature_id);

ALTER TABLE chado.feature_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.feature_pubprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.feature_pubprop
	ADD FOREIGN KEY (feature_pub_id) 
	REFERENCES chado.feature_pub (feature_pub_id);



ALTER TABLE chado.feature_relationship
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.feature_relationship
	ADD FOREIGN KEY (object_id,subject_id) 
	REFERENCES chado.feature (feature_id,feature_id);



ALTER TABLE chado.feature_relationship_pub
	ADD FOREIGN KEY (feature_relationship_id) 
	REFERENCES chado.feature_relationship (feature_relationship_id);

ALTER TABLE chado.feature_relationship_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.feature_relationshipprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.feature_relationshipprop
	ADD FOREIGN KEY (feature_relationship_id) 
	REFERENCES chado.feature_relationship (feature_relationship_id);



ALTER TABLE chado.feature_relationshipprop_pub
	ADD FOREIGN KEY (feature_relationshipprop_id) 
	REFERENCES chado.feature_relationshipprop (feature_relationshipprop_id);

ALTER TABLE chado.feature_relationshipprop_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.feature_synonym
	ADD FOREIGN KEY (feature_id) 
	REFERENCES chado.feature (feature_id);

ALTER TABLE chado.feature_synonym
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);

ALTER TABLE chado.feature_synonym
	ADD FOREIGN KEY (synonym_id) 
	REFERENCES chado.synonym (synonym_id);



ALTER TABLE chado.featureloc
	ADD FOREIGN KEY (feature_id,srcfeature_id) 
	REFERENCES chado.feature (feature_id,feature_id);



ALTER TABLE chado.featureloc_pub
	ADD FOREIGN KEY (featureloc_id) 
	REFERENCES chado.featureloc (featureloc_id);

ALTER TABLE chado.featureloc_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.featuremap
	ADD FOREIGN KEY (unittype_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.featuremap_pub
	ADD FOREIGN KEY (featuremap_id) 
	REFERENCES chado.featuremap (featuremap_id);

ALTER TABLE chado.featuremap_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.featurepos
	ADD FOREIGN KEY (feature_id,map_feature_id) 
	REFERENCES chado.feature (feature_id,feature_id);

ALTER TABLE chado.featurepos
	ADD FOREIGN KEY (featuremap_id) 
	REFERENCES chado.featuremap (featuremap_id);



ALTER TABLE chado.featureprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.featureprop
	ADD FOREIGN KEY (feature_id) 
	REFERENCES chado.feature (feature_id);



ALTER TABLE chado.featureprop_pub
	ADD FOREIGN KEY (featureprop_id) 
	REFERENCES chado.featureprop (featureprop_id);

ALTER TABLE chado.featureprop_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.featurerange
	ADD FOREIGN KEY (feature_id,leftendf_id,leftstartf_id,rightendf_id,rightstartf_id) 
	REFERENCES chado.feature (feature_id,feature_id,feature_id,feature_id,feature_id);

ALTER TABLE chado.featurerange
	ADD FOREIGN KEY (featuremap_id) 
	REFERENCES chado.featuremap (featuremap_id);



ALTER TABLE chado.genotype
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.genotype
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);



ALTER TABLE chado.genotype_cvterm
	ADD FOREIGN KEY (cvterm_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.genotype_cvterm
	ADD FOREIGN KEY (genotype_id) 
	REFERENCES chado.genotype (genotype_id);

ALTER TABLE chado.genotype_cvterm
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.genotype_dbxref
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.genotype_dbxref
	ADD FOREIGN KEY (genotype_id) 
	REFERENCES chado.genotype (genotype_id);



ALTER TABLE chado.genotype_synonym
	ADD FOREIGN KEY (synonym_id) 
	REFERENCES chado.synonym (synonym_id);



ALTER TABLE chado.genotypeprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.genotypeprop
	ADD FOREIGN KEY (genotype_id) 
	REFERENCES chado.genotype (genotype_id);



ALTER TABLE chado."library"
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado."library"
	ADD FOREIGN KEY (organism_id) 
	REFERENCES chado.organism (organism_id);



ALTER TABLE chado.library_cvterm
	ADD FOREIGN KEY (cvterm_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.library_cvterm
	ADD FOREIGN KEY (library_id) 
	REFERENCES chado."library" (library_id);

ALTER TABLE chado.library_cvterm
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.library_dbxref
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.library_dbxref
	ADD FOREIGN KEY (library_id) 
	REFERENCES chado."library" (library_id);



ALTER TABLE chado.library_feature
	ADD FOREIGN KEY (feature_id) 
	REFERENCES chado.feature (feature_id);

ALTER TABLE chado.library_feature
	ADD FOREIGN KEY (library_id) 
	REFERENCES chado."library" (library_id);



ALTER TABLE chado.library_pub
	ADD FOREIGN KEY (library_id) 
	REFERENCES chado."library" (library_id);

ALTER TABLE chado.library_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.library_synonym
	ADD FOREIGN KEY (library_id) 
	REFERENCES chado."library" (library_id);

ALTER TABLE chado.library_synonym
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);

ALTER TABLE chado.library_synonym
	ADD FOREIGN KEY (synonym_id) 
	REFERENCES chado.synonym (synonym_id);



ALTER TABLE chado.libraryprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.libraryprop
	ADD FOREIGN KEY (library_id) 
	REFERENCES chado."library" (library_id);



ALTER TABLE chado.libraryprop_pub
	ADD FOREIGN KEY (libraryprop_id) 
	REFERENCES chado.libraryprop (libraryprop_id);

ALTER TABLE chado.libraryprop_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.magedocumentation
	ADD FOREIGN KEY (mageml_id) 
	REFERENCES chado.mageml (mageml_id);

ALTER TABLE chado.magedocumentation
	ADD FOREIGN KEY (tableinfo_id) 
	REFERENCES chado.tableinfo (tableinfo_id);



ALTER TABLE chado.nd_experiment
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.nd_experiment
	ADD FOREIGN KEY (nd_geolocation_id) 
	REFERENCES chado.nd_geolocation (nd_geolocation_id);



ALTER TABLE chado.nd_experiment_contact
	ADD FOREIGN KEY (contact_id) 
	REFERENCES chado.contact (contact_id);

ALTER TABLE chado.nd_experiment_contact
	ADD FOREIGN KEY (nd_experiment_id) 
	REFERENCES chado.nd_experiment (nd_experiment_id);



ALTER TABLE chado.nd_experiment_dbxref
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.nd_experiment_dbxref
	ADD FOREIGN KEY (nd_experiment_id) 
	REFERENCES chado.nd_experiment (nd_experiment_id);



ALTER TABLE chado.nd_experiment_genotype
	ADD FOREIGN KEY (genotype_id) 
	REFERENCES chado.genotype (genotype_id);

ALTER TABLE chado.nd_experiment_genotype
	ADD FOREIGN KEY (nd_experiment_id) 
	REFERENCES chado.nd_experiment (nd_experiment_id);



ALTER TABLE chado.nd_experiment_phenotype
	ADD FOREIGN KEY (nd_experiment_id) 
	REFERENCES chado.nd_experiment (nd_experiment_id);

ALTER TABLE chado.nd_experiment_phenotype
	ADD FOREIGN KEY (phenotype_id) 
	REFERENCES chado.phenotype (phenotype_id);



ALTER TABLE chado.nd_experiment_project
	ADD FOREIGN KEY (nd_experiment_id) 
	REFERENCES chado.nd_experiment (nd_experiment_id);

ALTER TABLE chado.nd_experiment_project
	ADD FOREIGN KEY (project_id) 
	REFERENCES chado.project (project_id);



ALTER TABLE chado.nd_experiment_protocol
	ADD FOREIGN KEY (nd_experiment_id) 
	REFERENCES chado.nd_experiment (nd_experiment_id);

ALTER TABLE chado.nd_experiment_protocol
	ADD FOREIGN KEY (nd_protocol_id) 
	REFERENCES chado.nd_protocol (nd_protocol_id);



ALTER TABLE chado.nd_experiment_pub
	ADD FOREIGN KEY (nd_experiment_id) 
	REFERENCES chado.nd_experiment (nd_experiment_id);

ALTER TABLE chado.nd_experiment_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.nd_experiment_stock
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.nd_experiment_stock
	ADD FOREIGN KEY (nd_experiment_id) 
	REFERENCES chado.nd_experiment (nd_experiment_id);

ALTER TABLE chado.nd_experiment_stock
	ADD FOREIGN KEY (stock_id) 
	REFERENCES chado.stock (stock_id);



ALTER TABLE chado.nd_experiment_stock_dbxref
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.nd_experiment_stock_dbxref
	ADD FOREIGN KEY (nd_experiment_stock_id) 
	REFERENCES chado.nd_experiment_stock (nd_experiment_stock_id);



ALTER TABLE chado.nd_experiment_stockprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.nd_experiment_stockprop
	ADD FOREIGN KEY (nd_experiment_stock_id) 
	REFERENCES chado.nd_experiment_stock (nd_experiment_stock_id);



ALTER TABLE chado.nd_experimentprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.nd_experimentprop
	ADD FOREIGN KEY (nd_experiment_id) 
	REFERENCES chado.nd_experiment (nd_experiment_id);



ALTER TABLE chado.nd_geolocationprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.nd_geolocationprop
	ADD FOREIGN KEY (nd_geolocation_id) 
	REFERENCES chado.nd_geolocation (nd_geolocation_id);



ALTER TABLE chado.nd_protocol
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.nd_protocol_reagent
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.nd_protocol_reagent
	ADD FOREIGN KEY (nd_protocol_id) 
	REFERENCES chado.nd_protocol (nd_protocol_id);

ALTER TABLE chado.nd_protocol_reagent
	ADD FOREIGN KEY (reagent_id) 
	REFERENCES chado.nd_reagent (nd_reagent_id);



ALTER TABLE chado.nd_protocolprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.nd_protocolprop
	ADD FOREIGN KEY (nd_protocol_id) 
	REFERENCES chado.nd_protocol (nd_protocol_id);



ALTER TABLE chado.nd_reagent
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.nd_reagent_relationship
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.nd_reagent_relationship
	ADD FOREIGN KEY (object_reagent_id,subject_reagent_id) 
	REFERENCES chado.nd_reagent (nd_reagent_id,nd_reagent_id);



ALTER TABLE chado.nd_reagentprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.nd_reagentprop
	ADD FOREIGN KEY (nd_reagent_id) 
	REFERENCES chado.nd_reagent (nd_reagent_id);



ALTER TABLE chado.organism_dbxref
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.organism_dbxref
	ADD FOREIGN KEY (organism_id) 
	REFERENCES chado.organism (organism_id);



ALTER TABLE chado.organismprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.organismprop
	ADD FOREIGN KEY (organism_id) 
	REFERENCES chado.organism (organism_id);



ALTER TABLE chado.phendesc
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.phendesc
	ADD FOREIGN KEY (environment_id) 
	REFERENCES chado.environment (environment_id);

ALTER TABLE chado.phendesc
	ADD FOREIGN KEY (genotype_id) 
	REFERENCES chado.genotype (genotype_id);

ALTER TABLE chado.phendesc
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.phenotype
	ADD FOREIGN KEY (assay_id,attr_id,cvalue_id,observable_id) 
	REFERENCES chado.cvterm (cvterm_id,cvterm_id,cvterm_id,cvterm_id);



ALTER TABLE chado.phenotype_comparison
	ADD FOREIGN KEY (environment1_id,environment2_id) 
	REFERENCES chado.environment (environment_id,environment_id);

ALTER TABLE chado.phenotype_comparison
	ADD FOREIGN KEY (genotype1_id,genotype2_id) 
	REFERENCES chado.genotype (genotype_id,genotype_id);

ALTER TABLE chado.phenotype_comparison
	ADD FOREIGN KEY (organism_id) 
	REFERENCES chado.organism (organism_id);

ALTER TABLE chado.phenotype_comparison
	ADD FOREIGN KEY (phenotype1_id,phenotype2_id) 
	REFERENCES chado.phenotype (phenotype_id,phenotype_id);

ALTER TABLE chado.phenotype_comparison
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.phenotype_comparison_cvterm
	ADD FOREIGN KEY (cvterm_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.phenotype_comparison_cvterm
	ADD FOREIGN KEY (phenotype_comparison_id) 
	REFERENCES chado.phenotype_comparison (phenotype_comparison_id);

ALTER TABLE chado.phenotype_comparison_cvterm
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.phenotype_cvterm
	ADD FOREIGN KEY (cvterm_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.phenotype_cvterm
	ADD FOREIGN KEY (phenotype_id) 
	REFERENCES chado.phenotype (phenotype_id);



ALTER TABLE chado.phenstatement
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.phenstatement
	ADD FOREIGN KEY (environment_id) 
	REFERENCES chado.environment (environment_id);

ALTER TABLE chado.phenstatement
	ADD FOREIGN KEY (genotype_id) 
	REFERENCES chado.genotype (genotype_id);

ALTER TABLE chado.phenstatement
	ADD FOREIGN KEY (phenotype_id) 
	REFERENCES chado.phenotype (phenotype_id);

ALTER TABLE chado.phenstatement
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.phylonode
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.phylonode
	ADD FOREIGN KEY (feature_id) 
	REFERENCES chado.feature (feature_id);

ALTER TABLE chado.phylonode
	ADD FOREIGN KEY (parent_phylonode_id) 
	REFERENCES chado.phylonode (phylonode_id);

ALTER TABLE chado.phylonode
	ADD FOREIGN KEY (phylotree_id) 
	REFERENCES chado.phylotree (phylotree_id);



ALTER TABLE chado.phylonode_dbxref
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.phylonode_dbxref
	ADD FOREIGN KEY (phylonode_id) 
	REFERENCES chado.phylonode (phylonode_id);



ALTER TABLE chado.phylonode_organism
	ADD FOREIGN KEY (organism_id) 
	REFERENCES chado.organism (organism_id);

ALTER TABLE chado.phylonode_organism
	ADD FOREIGN KEY (phylonode_id) 
	REFERENCES chado.phylonode (phylonode_id);



ALTER TABLE chado.phylonode_pub
	ADD FOREIGN KEY (phylonode_id) 
	REFERENCES chado.phylonode (phylonode_id);

ALTER TABLE chado.phylonode_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.phylonode_relationship
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.phylonode_relationship
	ADD FOREIGN KEY (object_id,subject_id) 
	REFERENCES chado.phylonode (phylonode_id,phylonode_id);

ALTER TABLE chado.phylonode_relationship
	ADD FOREIGN KEY (phylotree_id) 
	REFERENCES chado.phylotree (phylotree_id);



ALTER TABLE chado.phylonodeprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.phylonodeprop
	ADD FOREIGN KEY (phylonode_id) 
	REFERENCES chado.phylonode (phylonode_id);



ALTER TABLE chado.phylotree
	ADD FOREIGN KEY (analysis_id) 
	REFERENCES chado.analysis (analysis_id);

ALTER TABLE chado.phylotree
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.phylotree
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);



ALTER TABLE chado.phylotree_pub
	ADD FOREIGN KEY (phylotree_id) 
	REFERENCES chado.phylotree (phylotree_id);

ALTER TABLE chado.phylotree_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.project_contact
	ADD FOREIGN KEY (contact_id) 
	REFERENCES chado.contact (contact_id);

ALTER TABLE chado.project_contact
	ADD FOREIGN KEY (project_id) 
	REFERENCES chado.project (project_id);



ALTER TABLE chado.project_pub
	ADD FOREIGN KEY (project_id) 
	REFERENCES chado.project (project_id);

ALTER TABLE chado.project_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.project_relationship
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.project_relationship
	ADD FOREIGN KEY (object_project_id,subject_project_id) 
	REFERENCES chado.project (project_id,project_id);



ALTER TABLE chado.projectprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.projectprop
	ADD FOREIGN KEY (project_id) 
	REFERENCES chado.project (project_id);



ALTER TABLE chado.protocol
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.protocol
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.protocol
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.protocolparam
	ADD FOREIGN KEY (datatype_id,unittype_id) 
	REFERENCES chado.cvterm (cvterm_id,cvterm_id);

ALTER TABLE chado.protocolparam
	ADD FOREIGN KEY (protocol_id) 
	REFERENCES chado.protocol (protocol_id);



ALTER TABLE chado.pub
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.pub_dbxref
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.pub_dbxref
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.pub_relationship
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.pub_relationship
	ADD FOREIGN KEY (object_id,subject_id) 
	REFERENCES chado.pub (pub_id,pub_id);



ALTER TABLE chado.pubauthor
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.pubprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.pubprop
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.quantification
	ADD FOREIGN KEY (acquisition_id) 
	REFERENCES chado.acquisition (acquisition_id);

ALTER TABLE chado.quantification
	ADD FOREIGN KEY (analysis_id) 
	REFERENCES chado.analysis (analysis_id);

ALTER TABLE chado.quantification
	ADD FOREIGN KEY (operator_id) 
	REFERENCES chado.contact (contact_id);

ALTER TABLE chado.quantification
	ADD FOREIGN KEY (protocol_id) 
	REFERENCES chado.protocol (protocol_id);



ALTER TABLE chado.quantification_relationship
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.quantification_relationship
	ADD FOREIGN KEY (object_id,subject_id) 
	REFERENCES chado.quantification (quantification_id,quantification_id);



ALTER TABLE chado.quantificationprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.quantificationprop
	ADD FOREIGN KEY (quantification_id) 
	REFERENCES chado.quantification (quantification_id);



ALTER TABLE chado.stock
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.stock
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.stock
	ADD FOREIGN KEY (organism_id) 
	REFERENCES chado.organism (organism_id);



ALTER TABLE chado.stock_cvterm
	ADD FOREIGN KEY (cvterm_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.stock_cvterm
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);

ALTER TABLE chado.stock_cvterm
	ADD FOREIGN KEY (stock_id) 
	REFERENCES chado.stock (stock_id);



ALTER TABLE chado.stock_cvtermprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.stock_cvtermprop
	ADD FOREIGN KEY (stock_cvterm_id) 
	REFERENCES chado.stock_cvterm (stock_cvterm_id);



ALTER TABLE chado.stock_dbxref
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.stock_dbxref
	ADD FOREIGN KEY (stock_id) 
	REFERENCES chado.stock (stock_id);



ALTER TABLE chado.stock_dbxrefprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.stock_dbxrefprop
	ADD FOREIGN KEY (stock_dbxref_id) 
	REFERENCES chado.stock_dbxref (stock_dbxref_id);



ALTER TABLE chado.stock_genotype
	ADD FOREIGN KEY (genotype_id) 
	REFERENCES chado.genotype (genotype_id);

ALTER TABLE chado.stock_genotype
	ADD FOREIGN KEY (stock_id) 
	REFERENCES chado.stock (stock_id);



ALTER TABLE chado.stock_genotype_cvterm
	ADD FOREIGN KEY (cvterm_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.stock_genotype_cvterm
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);

ALTER TABLE chado.stock_genotype_cvterm
	ADD FOREIGN KEY (stock_genotype_id) 
	REFERENCES chado.stock_genotype (stock_genotype_id);



ALTER TABLE chado.stock_genotype_prop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.stock_genotype_prop
	ADD FOREIGN KEY (stock_genotype_id) 
	REFERENCES chado.stock_genotype (stock_genotype_id);



ALTER TABLE chado.stock_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);

ALTER TABLE chado.stock_pub
	ADD FOREIGN KEY (stock_id) 
	REFERENCES chado.stock (stock_id);



ALTER TABLE chado.stock_relationship
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.stock_relationship
	ADD FOREIGN KEY (object_id,subject_id,background_accession_id) 
	REFERENCES chado.stock (stock_id,stock_id,stock_id);



ALTER TABLE chado.stock_relationship_cvterm
	ADD FOREIGN KEY (cvterm_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.stock_relationship_cvterm
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);

ALTER TABLE chado.stock_relationship_cvterm
	ADD FOREIGN KEY (stock_relationship_id) 
	REFERENCES chado.stock_relationship (stock_relationship_id);



ALTER TABLE chado.stock_relationship_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);

ALTER TABLE chado.stock_relationship_pub
	ADD FOREIGN KEY (stock_relationship_id) 
	REFERENCES chado.stock_relationship (stock_relationship_id);



ALTER TABLE chado.stock_synonym
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);

ALTER TABLE chado.stock_synonym
	ADD FOREIGN KEY (stock_id) 
	REFERENCES chado.stock (stock_id);

ALTER TABLE chado.stock_synonym
	ADD FOREIGN KEY (synonym_id) 
	REFERENCES chado.synonym (synonym_id);



ALTER TABLE chado.stockcollection
	ADD FOREIGN KEY (contact_id) 
	REFERENCES chado.contact (contact_id);

ALTER TABLE chado.stockcollection
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.stockcollection_stock
	ADD FOREIGN KEY (stock_id) 
	REFERENCES chado.stock (stock_id);

ALTER TABLE chado.stockcollection_stock
	ADD FOREIGN KEY (stockcollection_id) 
	REFERENCES chado.stockcollection (stockcollection_id);



ALTER TABLE chado.stockcollectionprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.stockcollectionprop
	ADD FOREIGN KEY (stockcollection_id) 
	REFERENCES chado.stockcollection (stockcollection_id);



ALTER TABLE chado.stockprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.stockprop
	ADD FOREIGN KEY (stock_id) 
	REFERENCES chado.stock (stock_id);



ALTER TABLE chado.stockprop_pub
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);

ALTER TABLE chado.stockprop_pub
	ADD FOREIGN KEY (stockprop_id) 
	REFERENCES chado.stockprop (stockprop_id);



ALTER TABLE chado.study
	ADD FOREIGN KEY (contact_id) 
	REFERENCES chado.contact (contact_id);

ALTER TABLE chado.study
	ADD FOREIGN KEY (dbxref_id) 
	REFERENCES chado.dbxref (dbxref_id);

ALTER TABLE chado.study
	ADD FOREIGN KEY (pub_id) 
	REFERENCES chado.pub (pub_id);



ALTER TABLE chado.study_assay
	ADD FOREIGN KEY (assay_id) 
	REFERENCES chado.assay (assay_id);

ALTER TABLE chado.study_assay
	ADD FOREIGN KEY (study_id) 
	REFERENCES chado.study (study_id);



ALTER TABLE chado.studydesign
	ADD FOREIGN KEY (study_id) 
	REFERENCES chado.study (study_id);



ALTER TABLE chado.studydesignprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.studydesignprop
	ADD FOREIGN KEY (studydesign_id) 
	REFERENCES chado.studydesign (studydesign_id);



ALTER TABLE chado.studyfactor
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.studyfactor
	ADD FOREIGN KEY (studydesign_id) 
	REFERENCES chado.studydesign (studydesign_id);



ALTER TABLE chado.studyfactorvalue
	ADD FOREIGN KEY (assay_id) 
	REFERENCES chado.assay (assay_id);

ALTER TABLE chado.studyfactorvalue
	ADD FOREIGN KEY (studyfactor_id) 
	REFERENCES chado.studyfactor (studyfactor_id);



ALTER TABLE chado.studyprop
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.studyprop
	ADD FOREIGN KEY (study_id) 
	REFERENCES chado.study (study_id);



ALTER TABLE chado.studyprop_feature
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.studyprop_feature
	ADD FOREIGN KEY (feature_id) 
	REFERENCES chado.feature (feature_id);

ALTER TABLE chado.studyprop_feature
	ADD FOREIGN KEY (studyprop_id) 
	REFERENCES chado.studyprop (studyprop_id);



ALTER TABLE chado.synonym
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);



ALTER TABLE chado.treatment
	ADD FOREIGN KEY (biomaterial_id) 
	REFERENCES chado.biomaterial (biomaterial_id);

ALTER TABLE chado.treatment
	ADD FOREIGN KEY (type_id) 
	REFERENCES chado.cvterm (cvterm_id);

ALTER TABLE chado.treatment
	ADD FOREIGN KEY (protocol_id) 
	REFERENCES chado.protocol (protocol_id);



CREATE VIEW chado.all_feature_names (feature_id,"name",organism_id) AS  SELECT feature.feature_id,
    ("substring"(feature.uniquename, 0, 255))::character varying(255) AS name,
    feature.organism_id
   FROM feature
UNION
 SELECT feature.feature_id,
    feature.name,
    feature.organism_id
   FROM feature
  WHERE (feature.name IS NOT NULL)
UNION
 SELECT fs.feature_id,
    s.name,
    f.organism_id
   FROM feature_synonym fs,
    synonym s,
    feature f
  WHERE ((fs.synonym_id = s.synonym_id) AND (fs.feature_id = f.feature_id))
UNION
 SELECT fp.feature_id,
    ("substring"(fp.value, 0, 255))::character varying(255) AS name,
    f.organism_id
   FROM featureprop fp,
    feature f
  WHERE (f.feature_id = fp.feature_id)
UNION
 SELECT fd.feature_id,
    d.accession AS name,
    f.organism_id
   FROM feature_dbxref fd,
    dbxref d,
    feature f
  WHERE ((fd.dbxref_id = d.dbxref_id) AND (fd.feature_id = f.feature_id));

CREATE VIEW chado.common_ancestor_cvterm (cvterm1_id,cvterm2_id,ancestor_cvterm_id,pathdistance1,pathdistance2,total_pathdistance) AS  SELECT p1.subject_id AS cvterm1_id,
    p2.subject_id AS cvterm2_id,
    p1.object_id AS ancestor_cvterm_id,
    p1.pathdistance AS pathdistance1,
    p2.pathdistance AS pathdistance2,
    (p1.pathdistance + p2.pathdistance) AS total_pathdistance
   FROM cvtermpath p1,
    cvtermpath p2
  WHERE (p1.object_id = p2.object_id);

CREATE VIEW chado.common_descendant_cvterm (cvterm1_id,cvterm2_id,ancestor_cvterm_id,pathdistance1,pathdistance2,total_pathdistance) AS  SELECT p1.object_id AS cvterm1_id,
    p2.object_id AS cvterm2_id,
    p1.subject_id AS ancestor_cvterm_id,
    p1.pathdistance AS pathdistance1,
    p2.pathdistance AS pathdistance2,
    (p1.pathdistance + p2.pathdistance) AS total_pathdistance
   FROM cvtermpath p1,
    cvtermpath p2
  WHERE (p1.subject_id = p2.subject_id);

CREATE VIEW chado.cv_cvterm_count ("name",num_terms_excl_obs) AS  SELECT cv.name,
    count(*) AS num_terms_excl_obs
   FROM (cv
     JOIN cvterm USING (cv_id))
  WHERE (cvterm.is_obsolete = 0)
  GROUP BY cv.name;

CREATE VIEW chado.cv_cvterm_count_with_obs ("name",num_terms_incl_obs) AS  SELECT cv.name,
    count(*) AS num_terms_incl_obs
   FROM (cv
     JOIN cvterm USING (cv_id))
  GROUP BY cv.name;

CREATE VIEW chado.cv_leaf (cv_id,cvterm_id) AS  SELECT cvterm.cv_id,
    cvterm.cvterm_id
   FROM cvterm
  WHERE (NOT (cvterm.cvterm_id IN ( SELECT cvterm_relationship.object_id
           FROM cvterm_relationship)));

CREATE VIEW chado.cv_link_count (cv_name,relation_name,relation_cv_name,num_links) AS  SELECT cv.name AS cv_name,
    relation.name AS relation_name,
    relation_cv.name AS relation_cv_name,
    count(*) AS num_links
   FROM ((((cv
     JOIN cvterm ON ((cvterm.cv_id = cv.cv_id)))
     JOIN cvterm_relationship ON ((cvterm.cvterm_id = cvterm_relationship.subject_id)))
     JOIN cvterm relation ON ((cvterm_relationship.type_id = relation.cvterm_id)))
     JOIN cv relation_cv ON ((relation.cv_id = relation_cv.cv_id)))
  GROUP BY cv.name, relation.name, relation_cv.name;

CREATE VIEW chado.cv_path_count (cv_name,relation_name,relation_cv_name,num_paths) AS  SELECT cv.name AS cv_name,
    relation.name AS relation_name,
    relation_cv.name AS relation_cv_name,
    count(*) AS num_paths
   FROM ((((cv
     JOIN cvterm ON ((cvterm.cv_id = cv.cv_id)))
     JOIN cvtermpath ON ((cvterm.cvterm_id = cvtermpath.subject_id)))
     JOIN cvterm relation ON ((cvtermpath.type_id = relation.cvterm_id)))
     JOIN cv relation_cv ON ((relation.cv_id = relation_cv.cv_id)))
  GROUP BY cv.name, relation.name, relation_cv.name;

CREATE VIEW chado.cv_root (cv_id,root_cvterm_id) AS  SELECT cvterm.cv_id,
    cvterm.cvterm_id AS root_cvterm_id
   FROM cvterm
  WHERE ((NOT (cvterm.cvterm_id IN ( SELECT cvterm_relationship.subject_id
           FROM cvterm_relationship))) AND (cvterm.is_obsolete = 0));

CREATE VIEW chado.db_dbxref_count ("name",num_dbxrefs) AS  SELECT db.name,
    count(*) AS num_dbxrefs
   FROM (db
     JOIN dbxref USING (db_id))
  GROUP BY db.name;

CREATE VIEW chado.dfeatureloc (featureloc_id,feature_id,srcfeature_id,nbeg,is_nbeg_partial,nend,is_nend_partial,strand,phase,residue_info,locgroup,"rank") AS  SELECT featureloc.featureloc_id,
    featureloc.feature_id,
    featureloc.srcfeature_id,
    featureloc.fmin AS nbeg,
    featureloc.is_fmin_partial AS is_nbeg_partial,
    featureloc.fmax AS nend,
    featureloc.is_fmax_partial AS is_nend_partial,
    featureloc.strand,
    featureloc.phase,
    featureloc.residue_info,
    featureloc.locgroup,
    featureloc.rank
   FROM featureloc
  WHERE ((featureloc.strand < 0) OR (featureloc.phase < 0))
UNION
 SELECT featureloc.featureloc_id,
    featureloc.feature_id,
    featureloc.srcfeature_id,
    featureloc.fmax AS nbeg,
    featureloc.is_fmax_partial AS is_nbeg_partial,
    featureloc.fmin AS nend,
    featureloc.is_fmin_partial AS is_nend_partial,
    featureloc.strand,
    featureloc.phase,
    featureloc.residue_info,
    featureloc.locgroup,
    featureloc.rank
   FROM featureloc
  WHERE (((featureloc.strand IS NULL) OR (featureloc.strand >= 0)) OR (featureloc.phase >= 0));

CREATE VIEW chado.f_loc (feature_id,"name",dbxref_id,nbeg,nend,strand) AS  SELECT f.feature_id,
    f.name,
    f.dbxref_id,
    fl.nbeg,
    fl.nend,
    fl.strand
   FROM dfeatureloc fl,
    f_type f
  WHERE (f.feature_id = fl.feature_id);

CREATE VIEW chado.f_type (feature_id,"name",dbxref_id,"type",residues,seqlen,md5checksum,type_id,timeaccessioned,timelastmodified) AS  SELECT f.feature_id,
    f.name,
    f.dbxref_id,
    c.name AS type,
    f.residues,
    f.seqlen,
    f.md5checksum,
    f.type_id,
    f.timeaccessioned,
    f.timelastmodified
   FROM feature f,
    cvterm c
  WHERE (f.type_id = c.cvterm_id);

CREATE VIEW chado.feature_contains (subject_id,object_id) AS  SELECT x.feature_id AS subject_id,
    y.feature_id AS object_id
   FROM featureloc x,
    featureloc y
  WHERE ((x.srcfeature_id = y.srcfeature_id) AND ((y.fmin >= x.fmin) AND (y.fmin <= x.fmax)));

CREATE VIEW chado.feature_difference (subject_id,object_id,srcfeature_id,fmin,fmax,strand) AS  SELECT x.feature_id AS subject_id,
    y.feature_id AS object_id,
    x.strand AS srcfeature_id,
    x.srcfeature_id AS fmin,
    x.fmin AS fmax,
    y.fmin AS strand
   FROM featureloc x,
    featureloc y
  WHERE ((x.srcfeature_id = y.srcfeature_id) AND ((x.fmin < y.fmin) AND (x.fmax >= y.fmax)))
UNION
 SELECT x.feature_id AS subject_id,
    y.feature_id AS object_id,
    x.strand AS srcfeature_id,
    x.srcfeature_id AS fmin,
    y.fmax,
    x.fmax AS strand
   FROM featureloc x,
    featureloc y
  WHERE ((x.srcfeature_id = y.srcfeature_id) AND ((x.fmax > y.fmax) AND (x.fmin <= y.fmin)));

CREATE VIEW chado.feature_disjoint (subject_id,object_id) AS  SELECT x.feature_id AS subject_id,
    y.feature_id AS object_id
   FROM featureloc x,
    featureloc y
  WHERE ((x.srcfeature_id = y.srcfeature_id) AND ((x.fmax < y.fmin) AND (x.fmin > y.fmax)));

CREATE VIEW chado.feature_distance (subject_id,object_id,srcfeature_id,subject_strand,object_strand,distance) AS  SELECT x.feature_id AS subject_id,
    y.feature_id AS object_id,
    x.srcfeature_id,
    x.strand AS subject_strand,
    y.strand AS object_strand,
        CASE
            WHEN (x.fmax <= y.fmin) THEN (x.fmax - y.fmin)
            ELSE (y.fmax - x.fmin)
        END AS distance
   FROM featureloc x,
    featureloc y
  WHERE ((x.srcfeature_id = y.srcfeature_id) AND ((x.fmax <= y.fmin) OR (x.fmin >= y.fmax)));

CREATE VIEW chado.feature_intersection (subject_id,object_id,srcfeature_id,subject_strand,object_strand,fmin,fmax) AS  SELECT x.feature_id AS subject_id,
    y.feature_id AS object_id,
    x.srcfeature_id,
    x.strand AS subject_strand,
    y.strand AS object_strand,
        CASE
            WHEN (x.fmin < y.fmin) THEN y.fmin
            ELSE x.fmin
        END AS fmin,
        CASE
            WHEN (x.fmax > y.fmax) THEN y.fmax
            ELSE x.fmax
        END AS fmax
   FROM featureloc x,
    featureloc y
  WHERE ((x.srcfeature_id = y.srcfeature_id) AND ((x.fmax >= y.fmin) AND (x.fmin <= y.fmax)));

CREATE VIEW chado.feature_meets (subject_id,object_id) AS  SELECT x.feature_id AS subject_id,
    y.feature_id AS object_id
   FROM featureloc x,
    featureloc y
  WHERE ((x.srcfeature_id = y.srcfeature_id) AND ((x.fmax >= y.fmin) AND (x.fmin <= y.fmax)));

CREATE VIEW chado.feature_meets_on_same_strand (subject_id,object_id) AS  SELECT x.feature_id AS subject_id,
    y.feature_id AS object_id
   FROM featureloc x,
    featureloc y
  WHERE (((x.srcfeature_id = y.srcfeature_id) AND (x.strand = y.strand)) AND ((x.fmax >= y.fmin) AND (x.fmin <= y.fmax)));

CREATE VIEW chado.feature_union (subject_id,object_id,srcfeature_id,subject_strand,object_strand,fmin,fmax) AS  SELECT x.feature_id AS subject_id,
    y.feature_id AS object_id,
    x.srcfeature_id,
    x.strand AS subject_strand,
    y.strand AS object_strand,
        CASE
            WHEN (x.fmin < y.fmin) THEN x.fmin
            ELSE y.fmin
        END AS fmin,
        CASE
            WHEN (x.fmax > y.fmax) THEN x.fmax
            ELSE y.fmax
        END AS fmax
   FROM featureloc x,
    featureloc y
  WHERE ((x.srcfeature_id = y.srcfeature_id) AND ((x.fmax >= y.fmin) AND (x.fmin <= y.fmax)));

CREATE VIEW chado.featureset_meets (subject_id,object_id) AS  SELECT x.object_id AS subject_id,
    y.object_id
   FROM ((feature_meets r
     JOIN feature_relationship x ON ((r.subject_id = x.subject_id)))
     JOIN feature_relationship y ON ((r.object_id = y.subject_id)));

CREATE VIEW chado.fnr_type (feature_id,"name",dbxref_id,"type",residues,seqlen,md5checksum,type_id,timeaccessioned,timelastmodified) AS  SELECT f.feature_id,
    f.name,
    f.dbxref_id,
    c.name AS type,
    f.residues,
    f.seqlen,
    f.md5checksum,
    f.type_id,
    f.timeaccessioned,
    f.timelastmodified
   FROM (feature f
     LEFT JOIN analysisfeature af ON ((f.feature_id = af.feature_id))),
    cvterm c
  WHERE ((f.type_id = c.cvterm_id) AND (af.feature_id IS NULL));

CREATE VIEW chado.fp_key (feature_id,pkey,"value") AS  SELECT fp.feature_id,
    c.name AS pkey,
    fp.value
   FROM featureprop fp,
    cvterm c
  WHERE (fp.featureprop_id = c.cvterm_id);

CREATE VIEW chado.gff3atts (feature_id,"type","attribute") AS  SELECT fs.feature_id,
    'Ontology_term'::text AS type,
        CASE
            WHEN ((db.name)::text ~~ '%Gene Ontology%'::text) THEN (('GO:'::text || (dbx.accession)::text))::character varying
            WHEN ((db.name)::text ~~ 'Sequence Ontology%'::text) THEN (('SO:'::text || (dbx.accession)::text))::character varying
            ELSE ((((db.name)::text || ':'::text) || (dbx.accession)::text))::character varying
        END AS attribute
   FROM cvterm s,
    dbxref dbx,
    feature_cvterm fs,
    db
  WHERE (((fs.cvterm_id = s.cvterm_id) AND (s.dbxref_id = dbx.dbxref_id)) AND (db.db_id = dbx.db_id))
UNION ALL
 SELECT fs.feature_id,
    'Dbxref'::text AS type,
    (((d.name)::text || ':'::text) || (s.accession)::text) AS attribute
   FROM dbxref s,
    feature_dbxref fs,
    db d
  WHERE (((fs.dbxref_id = s.dbxref_id) AND (s.db_id = d.db_id)) AND ((d.name)::text <> 'GFF_source'::text))
UNION ALL
 SELECT f.feature_id,
    'Alias'::text AS type,
    s.name AS attribute
   FROM synonym s,
    feature_synonym fs,
    feature f
  WHERE ((((fs.synonym_id = s.synonym_id) AND (f.feature_id = fs.feature_id)) AND ((f.name)::text <> (s.name)::text)) AND (f.uniquename <> (s.name)::text))
UNION ALL
 SELECT fp.feature_id,
    cv.name AS type,
    fp.value AS attribute
   FROM featureprop fp,
    cvterm cv
  WHERE (fp.type_id = cv.cvterm_id)
UNION ALL
 SELECT fs.feature_id,
    'pub'::text AS type,
    (((s.series_name)::text || ':'::text) || s.title) AS attribute
   FROM pub s,
    feature_pub fs
  WHERE (fs.pub_id = s.pub_id)
UNION ALL
 SELECT fr.subject_id AS feature_id,
    'Parent'::text AS type,
    parent.uniquename AS attribute
   FROM feature_relationship fr,
    feature parent
  WHERE ((fr.object_id = parent.feature_id) AND (fr.type_id = ( SELECT cvterm.cvterm_id
           FROM cvterm
          WHERE (((cvterm.name)::text = 'part_of'::text) AND (cvterm.cv_id IN ( SELECT cv.cv_id
                   FROM cv
                  WHERE ((cv.name)::text = 'relationship'::text)))))))
UNION ALL
 SELECT fr.subject_id AS feature_id,
    'Derives_from'::text AS type,
    parent.uniquename AS attribute
   FROM feature_relationship fr,
    feature parent
  WHERE ((fr.object_id = parent.feature_id) AND (fr.type_id = ( SELECT cvterm.cvterm_id
           FROM cvterm
          WHERE (((cvterm.name)::text = 'derives_from'::text) AND (cvterm.cv_id IN ( SELECT cv.cv_id
                   FROM cv
                  WHERE ((cv.name)::text = 'relationship'::text)))))))
UNION ALL
 SELECT fl.feature_id,
    'Target'::text AS type,
    (((((((target.name)::text || ' '::text) || (fl.fmin + 1)) || ' '::text) || fl.fmax) || ' '::text) || fl.strand) AS attribute
   FROM featureloc fl,
    feature target
  WHERE ((fl.srcfeature_id = target.feature_id) AND (fl.rank <> 0))
UNION ALL
 SELECT feature.feature_id,
    'ID'::text AS type,
    feature.uniquename AS attribute
   FROM feature
  WHERE (NOT (feature.type_id IN ( SELECT cvterm.cvterm_id
           FROM cvterm
          WHERE ((cvterm.name)::text = 'CDS'::text))))
UNION ALL
 SELECT feature.feature_id,
    'chado_feature_id'::text AS type,
    (feature.feature_id)::character varying AS attribute
   FROM feature
UNION ALL
 SELECT feature.feature_id,
    'Name'::text AS type,
    feature.name AS attribute
   FROM feature;

CREATE VIEW chado.gff3view (feature_id,"ref","source","type",fstart,fend,score,strand,phase,seqlen,"name",organism_id) AS  SELECT f.feature_id,
    sf.name AS ref,
    COALESCE(gffdbx.accession, '.'::character varying(255)) AS source,
    cv.name AS type,
    (fl.fmin + 1) AS fstart,
    fl.fmax AS fend,
    COALESCE((af.significance)::text, '.'::text) AS score,
        CASE
            WHEN (fl.strand = (-1)) THEN '-'::text
            WHEN (fl.strand = 1) THEN '+'::text
            ELSE '.'::text
        END AS strand,
    COALESCE((fl.phase)::text, '.'::text) AS phase,
    f.seqlen,
    f.name,
    f.organism_id
   FROM (((((feature f
     LEFT JOIN featureloc fl ON ((f.feature_id = fl.feature_id)))
     LEFT JOIN feature sf ON ((fl.srcfeature_id = sf.feature_id)))
     LEFT JOIN ( SELECT fd.feature_id,
            d.accession
           FROM ((feature_dbxref fd
             JOIN dbxref d USING (dbxref_id))
             JOIN db USING (db_id))
          WHERE ((db.name)::text = 'GFF_source'::text)) gffdbx ON ((f.feature_id = gffdbx.feature_id)))
     LEFT JOIN cvterm cv ON ((f.type_id = cv.cvterm_id)))
     LEFT JOIN analysisfeature af ON ((f.feature_id = af.feature_id)));

CREATE VIEW chado.gffatts (feature_id,"type","attribute") AS  SELECT fs.feature_id,
    'Ontology_term'::text AS type,
    s.name AS attribute
   FROM cvterm s,
    feature_cvterm fs
  WHERE (fs.cvterm_id = s.cvterm_id)
UNION ALL
 SELECT fs.feature_id,
    'Dbxref'::text AS type,
    (((d.name)::text || ':'::text) || (s.accession)::text) AS attribute
   FROM dbxref s,
    feature_dbxref fs,
    db d
  WHERE ((fs.dbxref_id = s.dbxref_id) AND (s.db_id = d.db_id))
UNION ALL
 SELECT fs.feature_id,
    'Alias'::text AS type,
    s.name AS attribute
   FROM synonym s,
    feature_synonym fs
  WHERE (fs.synonym_id = s.synonym_id)
UNION ALL
 SELECT fp.feature_id,
    cv.name AS type,
    fp.value AS attribute
   FROM featureprop fp,
    cvterm cv
  WHERE (fp.type_id = cv.cvterm_id)
UNION ALL
 SELECT fs.feature_id,
    'pub'::text AS type,
    (((s.series_name)::text || ':'::text) || s.title) AS attribute
   FROM pub s,
    feature_pub fs
  WHERE (fs.pub_id = s.pub_id);

CREATE VIEW chado.intron_combined_view (exon1_id,exon2_id,fmin,fmax,strand,srcfeature_id,intron_rank,transcript_id) AS  SELECT x1.feature_id AS exon1_id,
    x2.feature_id AS exon2_id,
        CASE
            WHEN (l1.strand = (-1)) THEN l2.fmax
            ELSE l1.fmax
        END AS fmin,
        CASE
            WHEN (l1.strand = (-1)) THEN l1.fmin
            ELSE l2.fmin
        END AS fmax,
    l1.strand,
    l1.srcfeature_id,
    r1.rank AS intron_rank,
    r1.object_id AS transcript_id
   FROM ((((((cvterm
     JOIN feature x1 ON ((x1.type_id = cvterm.cvterm_id)))
     JOIN feature_relationship r1 ON ((x1.feature_id = r1.subject_id)))
     JOIN featureloc l1 ON ((x1.feature_id = l1.feature_id)))
     JOIN feature x2 ON ((x2.type_id = cvterm.cvterm_id)))
     JOIN feature_relationship r2 ON ((x2.feature_id = r2.subject_id)))
     JOIN featureloc l2 ON ((x2.feature_id = l2.feature_id)))
  WHERE ((((((((cvterm.name)::text = 'exon'::text) AND ((r2.rank - r1.rank) = 1)) AND (r1.object_id = r2.object_id)) AND (l1.strand = l2.strand)) AND (l1.srcfeature_id = l2.srcfeature_id)) AND (l1.locgroup = 0)) AND (l2.locgroup = 0));

CREATE VIEW chado.intronloc_view (exon1_id,exon2_id,fmin,fmax,strand,srcfeature_id) AS  SELECT DISTINCT intron_combined_view.exon1_id,
    intron_combined_view.exon2_id,
    intron_combined_view.fmin,
    intron_combined_view.fmax,
    intron_combined_view.strand,
    intron_combined_view.srcfeature_id
   FROM intron_combined_view;

CREATE VIEW chado.protein_coding_gene (feature_id,dbxref_id,organism_id,"name",uniquename,residues,seqlen,md5checksum,type_id,is_analysis,is_obsolete,timeaccessioned,timelastmodified) AS  SELECT DISTINCT gene.feature_id,
    gene.dbxref_id,
    gene.organism_id,
    gene.name,
    gene.uniquename,
    gene.residues,
    gene.seqlen,
    gene.md5checksum,
    gene.type_id,
    gene.is_analysis,
    gene.is_obsolete,
    gene.timeaccessioned,
    gene.timelastmodified
   FROM ((feature gene
     JOIN feature_relationship fr ON ((gene.feature_id = fr.object_id)))
     JOIN so.mrna ON ((mrna.feature_id = fr.subject_id)));

CREATE VIEW chado.stats_paths_to_root (cvterm_id,total_paths,avg_distance,min_distance,max_distance) AS  SELECT cvtermpath.subject_id AS cvterm_id,
    count(DISTINCT cvtermpath.cvtermpath_id) AS total_paths,
    avg(cvtermpath.pathdistance) AS avg_distance,
    min(cvtermpath.pathdistance) AS min_distance,
    max(cvtermpath.pathdistance) AS max_distance
   FROM (cvtermpath
     JOIN cv_root ON ((cvtermpath.object_id = cv_root.root_cvterm_id)))
  GROUP BY cvtermpath.subject_id;

CREATE VIEW chado.type_feature_count ("type",num_features) AS  SELECT t.name AS type,
    count(*) AS num_features
   FROM (cvterm t
     JOIN feature ON ((feature.type_id = t.cvterm_id)))
  GROUP BY t.name;

CREATE UNIQUE INDEX acquisition_c1 ON acquisition USING btree (name)

CREATE INDEX acquisition_idx1 ON acquisition USING btree (assay_id)

CREATE INDEX acquisition_idx2 ON acquisition USING btree (protocol_id)

CREATE INDEX acquisition_idx3 ON acquisition USING btree (channel_id)

CREATE UNIQUE INDEX acquisition_pkey ON acquisition USING btree (acquisition_id)

CREATE UNIQUE INDEX acquisition_relationship_c1 ON acquisition_relationship USING btree (subject_id, object_id, type_id, rank)

CREATE INDEX acquisition_relationship_idx1 ON acquisition_relationship USING btree (subject_id)

CREATE INDEX acquisition_relationship_idx2 ON acquisition_relationship USING btree (type_id)

CREATE INDEX acquisition_relationship_idx3 ON acquisition_relationship USING btree (object_id)

CREATE UNIQUE INDEX acquisition_relationship_pkey ON acquisition_relationship USING btree (acquisition_relationship_id)

CREATE UNIQUE INDEX acquisitionprop_c1 ON acquisitionprop USING btree (acquisition_id, type_id, rank)

CREATE INDEX acquisitionprop_idx1 ON acquisitionprop USING btree (acquisition_id)

CREATE INDEX acquisitionprop_idx2 ON acquisitionprop USING btree (type_id)

CREATE UNIQUE INDEX acquisitionprop_pkey ON acquisitionprop USING btree (acquisitionprop_id)

CREATE UNIQUE INDEX analysis_c1 ON analysis USING btree (program, programversion, sourcename)

CREATE INDEX analysis_organism_networkmod_qtl_indx0_idx ON analysis_organism USING btree (analysis_id)

CREATE INDEX analysis_organism_networkmod_qtl_indx1_idx ON analysis_organism USING btree (organism_id)

CREATE UNIQUE INDEX analysis_pkey ON analysis USING btree (analysis_id)

CREATE UNIQUE INDEX analysisfeature_c1 ON analysisfeature USING btree (feature_id, analysis_id)

CREATE UNIQUE INDEX analysisfeature_id_type_id_rank ON analysisfeatureprop USING btree (analysisfeature_id, type_id, rank)

CREATE INDEX analysisfeature_idx1 ON analysisfeature USING btree (feature_id)

CREATE INDEX analysisfeature_idx2 ON analysisfeature USING btree (analysis_id)

CREATE UNIQUE INDEX analysisfeature_pkey ON analysisfeature USING btree (analysisfeature_id)

CREATE UNIQUE INDEX analysisfeatureprop_pkey ON analysisfeatureprop USING btree (analysisfeatureprop_id)

CREATE UNIQUE INDEX analysisprop_c1 ON analysisprop USING btree (analysis_id, type_id, rank)

CREATE INDEX analysisprop_idx1 ON analysisprop USING btree (analysis_id)

CREATE INDEX analysisprop_idx2 ON analysisprop USING btree (type_id)

CREATE UNIQUE INDEX analysisprop_pkey ON analysisprop USING btree (analysisprop_id)

CREATE UNIQUE INDEX arraydesign_c1 ON arraydesign USING btree (name)

CREATE INDEX arraydesign_idx1 ON arraydesign USING btree (manufacturer_id)

CREATE INDEX arraydesign_idx2 ON arraydesign USING btree (platformtype_id)

CREATE INDEX arraydesign_idx3 ON arraydesign USING btree (substratetype_id)

CREATE INDEX arraydesign_idx4 ON arraydesign USING btree (protocol_id)

CREATE INDEX arraydesign_idx5 ON arraydesign USING btree (dbxref_id)

CREATE UNIQUE INDEX arraydesign_pkey ON arraydesign USING btree (arraydesign_id)

CREATE UNIQUE INDEX arraydesignprop_c1 ON arraydesignprop USING btree (arraydesign_id, type_id, rank)

CREATE INDEX arraydesignprop_idx1 ON arraydesignprop USING btree (arraydesign_id)

CREATE INDEX arraydesignprop_idx2 ON arraydesignprop USING btree (type_id)

CREATE UNIQUE INDEX arraydesignprop_pkey ON arraydesignprop USING btree (arraydesignprop_id)

CREATE UNIQUE INDEX assay_biomaterial_c1 ON assay_biomaterial USING btree (assay_id, biomaterial_id, channel_id, rank)

CREATE INDEX assay_biomaterial_idx1 ON assay_biomaterial USING btree (assay_id)

CREATE INDEX assay_biomaterial_idx2 ON assay_biomaterial USING btree (biomaterial_id)

CREATE INDEX assay_biomaterial_idx3 ON assay_biomaterial USING btree (channel_id)

CREATE UNIQUE INDEX assay_biomaterial_pkey ON assay_biomaterial USING btree (assay_biomaterial_id)

CREATE UNIQUE INDEX assay_c1 ON assay USING btree (name)

CREATE INDEX assay_idx1 ON assay USING btree (arraydesign_id)

CREATE INDEX assay_idx2 ON assay USING btree (protocol_id)

CREATE INDEX assay_idx3 ON assay USING btree (operator_id)

CREATE INDEX assay_idx4 ON assay USING btree (dbxref_id)

CREATE UNIQUE INDEX assay_pkey ON assay USING btree (assay_id)

CREATE UNIQUE INDEX assay_project_c1 ON assay_project USING btree (assay_id, project_id)

CREATE INDEX assay_project_idx1 ON assay_project USING btree (assay_id)

CREATE INDEX assay_project_idx2 ON assay_project USING btree (project_id)

CREATE UNIQUE INDEX assay_project_pkey ON assay_project USING btree (assay_project_id)

CREATE UNIQUE INDEX assayprop_c1 ON assayprop USING btree (assay_id, type_id, rank)

CREATE INDEX assayprop_idx1 ON assayprop USING btree (assay_id)

CREATE INDEX assayprop_idx2 ON assayprop USING btree (type_id)

CREATE UNIQUE INDEX assayprop_pkey ON assayprop USING btree (assayprop_id)

CREATE INDEX binloc_boxrange ON featureloc USING gist (boxrange(fmin, fmax))

CREATE INDEX binloc_boxrange_src ON featureloc USING gist (boxrange(srcfeature_id, fmin, fmax))

CREATE UNIQUE INDEX biomaterial_c1 ON biomaterial USING btree (name)

CREATE UNIQUE INDEX biomaterial_dbxref_c1 ON biomaterial_dbxref USING btree (biomaterial_id, dbxref_id)

CREATE INDEX biomaterial_dbxref_idx1 ON biomaterial_dbxref USING btree (biomaterial_id)

CREATE INDEX biomaterial_dbxref_idx2 ON biomaterial_dbxref USING btree (dbxref_id)

CREATE UNIQUE INDEX biomaterial_dbxref_pkey ON biomaterial_dbxref USING btree (biomaterial_dbxref_id)

CREATE INDEX biomaterial_idx1 ON biomaterial USING btree (taxon_id)

CREATE INDEX biomaterial_idx2 ON biomaterial USING btree (biosourceprovider_id)

CREATE INDEX biomaterial_idx3 ON biomaterial USING btree (dbxref_id)

CREATE UNIQUE INDEX biomaterial_pkey ON biomaterial USING btree (biomaterial_id)

CREATE UNIQUE INDEX biomaterial_relationship_c1 ON biomaterial_relationship USING btree (subject_id, object_id, type_id)

CREATE INDEX biomaterial_relationship_idx1 ON biomaterial_relationship USING btree (subject_id)

CREATE INDEX biomaterial_relationship_idx2 ON biomaterial_relationship USING btree (object_id)

CREATE INDEX biomaterial_relationship_idx3 ON biomaterial_relationship USING btree (type_id)

CREATE UNIQUE INDEX biomaterial_relationship_pkey ON biomaterial_relationship USING btree (biomaterial_relationship_id)

CREATE UNIQUE INDEX biomaterial_treatment_c1 ON biomaterial_treatment USING btree (biomaterial_id, treatment_id)

CREATE INDEX biomaterial_treatment_idx1 ON biomaterial_treatment USING btree (biomaterial_id)

CREATE INDEX biomaterial_treatment_idx2 ON biomaterial_treatment USING btree (treatment_id)

CREATE INDEX biomaterial_treatment_idx3 ON biomaterial_treatment USING btree (unittype_id)

CREATE UNIQUE INDEX biomaterial_treatment_pkey ON biomaterial_treatment USING btree (biomaterial_treatment_id)

CREATE UNIQUE INDEX biomaterialprop_c1 ON biomaterialprop USING btree (biomaterial_id, type_id, rank)

CREATE INDEX biomaterialprop_idx1 ON biomaterialprop USING btree (biomaterial_id)

CREATE INDEX biomaterialprop_idx2 ON biomaterialprop USING btree (type_id)

CREATE UNIQUE INDEX biomaterialprop_pkey ON biomaterialprop USING btree (biomaterialprop_id)

CREATE INDEX cache_libraries_expire_idx ON cache_libraries USING btree (expire)

CREATE UNIQUE INDEX cache_libraries_pkey ON cache_libraries USING btree (cid)

CREATE UNIQUE INDEX cell_line_c1 ON cell_line USING btree (uniquename, organism_id)

CREATE UNIQUE INDEX cell_line_cvterm_c1 ON cell_line_cvterm USING btree (cell_line_id, cvterm_id, pub_id, rank)

CREATE UNIQUE INDEX cell_line_cvterm_pkey ON cell_line_cvterm USING btree (cell_line_cvterm_id)

CREATE UNIQUE INDEX cell_line_cvtermprop_c1 ON cell_line_cvtermprop USING btree (cell_line_cvterm_id, type_id, rank)

CREATE UNIQUE INDEX cell_line_cvtermprop_pkey ON cell_line_cvtermprop USING btree (cell_line_cvtermprop_id)

CREATE UNIQUE INDEX cell_line_dbxref_c1 ON cell_line_dbxref USING btree (cell_line_id, dbxref_id)

CREATE UNIQUE INDEX cell_line_dbxref_pkey ON cell_line_dbxref USING btree (cell_line_dbxref_id)

CREATE UNIQUE INDEX cell_line_feature_c1 ON cell_line_feature USING btree (cell_line_id, feature_id, pub_id)

CREATE UNIQUE INDEX cell_line_feature_pkey ON cell_line_feature USING btree (cell_line_feature_id)

CREATE UNIQUE INDEX cell_line_library_c1 ON cell_line_library USING btree (cell_line_id, library_id, pub_id)

CREATE UNIQUE INDEX cell_line_library_pkey ON cell_line_library USING btree (cell_line_library_id)

CREATE UNIQUE INDEX cell_line_pkey ON cell_line USING btree (cell_line_id)

CREATE UNIQUE INDEX cell_line_pub_c1 ON cell_line_pub USING btree (cell_line_id, pub_id)

CREATE UNIQUE INDEX cell_line_pub_pkey ON cell_line_pub USING btree (cell_line_pub_id)

CREATE UNIQUE INDEX cell_line_relationship_c1 ON cell_line_relationship USING btree (subject_id, object_id, type_id)

CREATE UNIQUE INDEX cell_line_relationship_pkey ON cell_line_relationship USING btree (cell_line_relationship_id)

CREATE UNIQUE INDEX cell_line_synonym_c1 ON cell_line_synonym USING btree (synonym_id, cell_line_id, pub_id)

CREATE UNIQUE INDEX cell_line_synonym_pkey ON cell_line_synonym USING btree (cell_line_synonym_id)

CREATE UNIQUE INDEX cell_lineprop_c1 ON cell_lineprop USING btree (cell_line_id, type_id, rank)

CREATE UNIQUE INDEX cell_lineprop_pkey ON cell_lineprop USING btree (cell_lineprop_id)

CREATE UNIQUE INDEX cell_lineprop_pub_c1 ON cell_lineprop_pub USING btree (cell_lineprop_id, pub_id)

CREATE UNIQUE INDEX cell_lineprop_pub_pkey ON cell_lineprop_pub USING btree (cell_lineprop_pub_id)

CREATE UNIQUE INDEX chadoprop_c1 ON chadoprop USING btree (type_id, rank)

CREATE UNIQUE INDEX chadoprop_pkey ON chadoprop USING btree (chadoprop_id)

CREATE UNIQUE INDEX channel_c1 ON channel USING btree (name)

CREATE UNIQUE INDEX channel_pkey ON channel USING btree (channel_id)

CREATE UNIQUE INDEX contact_c1 ON contact USING btree (name)

CREATE UNIQUE INDEX contact_pkey ON contact USING btree (contact_id)

CREATE UNIQUE INDEX contact_relationship_c1 ON contact_relationship USING btree (subject_id, object_id, type_id)

CREATE INDEX contact_relationship_idx1 ON contact_relationship USING btree (type_id)

CREATE INDEX contact_relationship_idx2 ON contact_relationship USING btree (subject_id)

CREATE INDEX contact_relationship_idx3 ON contact_relationship USING btree (object_id)

CREATE UNIQUE INDEX contact_relationship_pkey ON contact_relationship USING btree (contact_relationship_id)

CREATE UNIQUE INDEX contactprop_contactprop_c1_key ON contactprop USING btree (contact_id, type_id, rank)

CREATE INDEX contactprop_contactprop_idx1_idx ON contactprop USING btree (contact_id)

CREATE INDEX contactprop_contactprop_idx2_idx ON contactprop USING btree (type_id)

CREATE UNIQUE INDEX contactprop_pkey ON contactprop USING btree (contactprop_id)

CREATE INDEX control_idx1 ON control USING btree (type_id)

CREATE INDEX control_idx2 ON control USING btree (assay_id)

CREATE INDEX control_idx3 ON control USING btree (tableinfo_id)

CREATE INDEX control_idx4 ON control USING btree (row_id)

CREATE UNIQUE INDEX control_pkey ON control USING btree (control_id)

CREATE UNIQUE INDEX cv_c1 ON cv USING btree (name)

CREATE UNIQUE INDEX cv_pkey ON cv USING btree (cv_id)

CREATE INDEX cv_root_mview_cv_root_mview_indx1_idx ON cv_root_mview USING btree (cvterm_id)

CREATE INDEX cv_root_mview_cv_root_mview_indx2_idx ON cv_root_mview USING btree (cv_id)

CREATE UNIQUE INDEX cvprop_c1 ON cvprop USING btree (cv_id, type_id, rank)

CREATE UNIQUE INDEX cvprop_pkey ON cvprop USING btree (cvprop_id)

CREATE UNIQUE INDEX cvterm_c1 ON cvterm USING btree (name, cv_id, is_obsolete)

CREATE UNIQUE INDEX cvterm_c2 ON cvterm USING btree (dbxref_id)

CREATE UNIQUE INDEX cvterm_dbxref_c1 ON cvterm_dbxref USING btree (cvterm_id, dbxref_id)

CREATE INDEX cvterm_dbxref_idx1 ON cvterm_dbxref USING btree (cvterm_id)

CREATE INDEX cvterm_dbxref_idx2 ON cvterm_dbxref USING btree (dbxref_id)

CREATE UNIQUE INDEX cvterm_dbxref_pkey ON cvterm_dbxref USING btree (cvterm_dbxref_id)

CREATE INDEX cvterm_idx1 ON cvterm USING btree (cv_id)

CREATE INDEX cvterm_idx2 ON cvterm USING btree (name)

CREATE INDEX cvterm_idx3 ON cvterm USING btree (dbxref_id)

CREATE UNIQUE INDEX cvterm_pkey ON cvterm USING btree (cvterm_id)

CREATE UNIQUE INDEX cvterm_relationship_c1 ON cvterm_relationship USING btree (subject_id, object_id, type_id)

CREATE INDEX cvterm_relationship_idx1 ON cvterm_relationship USING btree (type_id)

CREATE INDEX cvterm_relationship_idx2 ON cvterm_relationship USING btree (subject_id)

CREATE INDEX cvterm_relationship_idx3 ON cvterm_relationship USING btree (object_id)

CREATE UNIQUE INDEX cvterm_relationship_pkey ON cvterm_relationship USING btree (cvterm_relationship_id)

CREATE UNIQUE INDEX cvtermpath_c1 ON cvtermpath USING btree (subject_id, object_id, type_id, pathdistance)

CREATE INDEX cvtermpath_idx1 ON cvtermpath USING btree (type_id)

CREATE INDEX cvtermpath_idx2 ON cvtermpath USING btree (subject_id)

CREATE INDEX cvtermpath_idx3 ON cvtermpath USING btree (object_id)

CREATE INDEX cvtermpath_idx4 ON cvtermpath USING btree (cv_id)

CREATE UNIQUE INDEX cvtermpath_pkey ON cvtermpath USING btree (cvtermpath_id)

CREATE UNIQUE INDEX cvtermprop_cvterm_id_type_id_value_rank_key ON cvtermprop USING btree (cvterm_id, type_id, value, rank)

CREATE INDEX cvtermprop_idx1 ON cvtermprop USING btree (cvterm_id)

CREATE INDEX cvtermprop_idx2 ON cvtermprop USING btree (type_id)

CREATE UNIQUE INDEX cvtermprop_pkey ON cvtermprop USING btree (cvtermprop_id)

CREATE UNIQUE INDEX cvtermsynonym_c1 ON cvtermsynonym USING btree (cvterm_id, synonym)

CREATE INDEX cvtermsynonym_idx1 ON cvtermsynonym USING btree (cvterm_id)

CREATE UNIQUE INDEX cvtermsynonym_pkey ON cvtermsynonym USING btree (cvtermsynonym_id)

CREATE UNIQUE INDEX db_c1 ON db USING btree (name)

CREATE UNIQUE INDEX db_pkey ON db USING btree (db_id)

CREATE UNIQUE INDEX dbxref_c1 ON dbxref USING btree (db_id, accession, version)

CREATE INDEX dbxref_idx1 ON dbxref USING btree (db_id)

CREATE INDEX dbxref_idx2 ON dbxref USING btree (accession)

CREATE INDEX dbxref_idx3 ON dbxref USING btree (version)

CREATE UNIQUE INDEX dbxref_pkey ON dbxref USING btree (dbxref_id)

CREATE UNIQUE INDEX dbxrefprop_c1 ON dbxrefprop USING btree (dbxref_id, type_id, rank)

CREATE INDEX dbxrefprop_idx1 ON dbxrefprop USING btree (dbxref_id)

CREATE INDEX dbxrefprop_idx2 ON dbxrefprop USING btree (type_id)

CREATE UNIQUE INDEX dbxrefprop_pkey ON dbxrefprop USING btree (dbxrefprop_id)

CREATE UNIQUE INDEX eimage_pkey ON eimage USING btree (eimage_id)

CREATE UNIQUE INDEX element_c1 ON element USING btree (feature_id, arraydesign_id)

CREATE INDEX element_idx1 ON element USING btree (feature_id)

CREATE INDEX element_idx2 ON element USING btree (arraydesign_id)

CREATE INDEX element_idx3 ON element USING btree (type_id)

CREATE INDEX element_idx4 ON element USING btree (dbxref_id)

CREATE UNIQUE INDEX element_pkey ON element USING btree (element_id)

CREATE UNIQUE INDEX element_relationship_c1 ON element_relationship USING btree (subject_id, object_id, type_id, rank)

CREATE INDEX element_relationship_idx1 ON element_relationship USING btree (subject_id)

CREATE INDEX element_relationship_idx2 ON element_relationship USING btree (type_id)

CREATE INDEX element_relationship_idx3 ON element_relationship USING btree (object_id)

CREATE INDEX element_relationship_idx4 ON element_relationship USING btree (value)

CREATE UNIQUE INDEX element_relationship_pkey ON element_relationship USING btree (element_relationship_id)

CREATE UNIQUE INDEX elementresult_c1 ON elementresult USING btree (element_id, quantification_id)

CREATE INDEX elementresult_idx1 ON elementresult USING btree (element_id)

CREATE INDEX elementresult_idx2 ON elementresult USING btree (quantification_id)

CREATE INDEX elementresult_idx3 ON elementresult USING btree (signal)

CREATE UNIQUE INDEX elementresult_pkey ON elementresult USING btree (elementresult_id)

CREATE UNIQUE INDEX elementresult_relationship_c1 ON elementresult_relationship USING btree (subject_id, object_id, type_id, rank)

CREATE INDEX elementresult_relationship_idx1 ON elementresult_relationship USING btree (subject_id)

CREATE INDEX elementresult_relationship_idx2 ON elementresult_relationship USING btree (type_id)

CREATE INDEX elementresult_relationship_idx3 ON elementresult_relationship USING btree (object_id)

CREATE INDEX elementresult_relationship_idx4 ON elementresult_relationship USING btree (value)

CREATE UNIQUE INDEX elementresult_relationship_pkey ON elementresult_relationship USING btree (elementresult_relationship_id)

CREATE UNIQUE INDEX environment_c1 ON environment USING btree (uniquename)

CREATE UNIQUE INDEX environment_cvterm_c1 ON environment_cvterm USING btree (environment_id, cvterm_id)

CREATE INDEX environment_cvterm_idx1 ON environment_cvterm USING btree (environment_id)

CREATE INDEX environment_cvterm_idx2 ON environment_cvterm USING btree (cvterm_id)

CREATE UNIQUE INDEX environment_cvterm_pkey ON environment_cvterm USING btree (environment_cvterm_id)

CREATE INDEX environment_idx1 ON environment USING btree (uniquename)

CREATE UNIQUE INDEX environment_pkey ON environment USING btree (environment_id)

CREATE UNIQUE INDEX expression_c1 ON expression USING btree (uniquename)

CREATE UNIQUE INDEX expression_cvterm_c1 ON expression_cvterm USING btree (expression_id, cvterm_id, cvterm_type_id)

CREATE INDEX expression_cvterm_idx1 ON expression_cvterm USING btree (expression_id)

CREATE INDEX expression_cvterm_idx2 ON expression_cvterm USING btree (cvterm_id)

CREATE INDEX expression_cvterm_idx3 ON expression_cvterm USING btree (cvterm_type_id)

CREATE UNIQUE INDEX expression_cvterm_pkey ON expression_cvterm USING btree (expression_cvterm_id)

CREATE UNIQUE INDEX expression_cvtermprop_c1 ON expression_cvtermprop USING btree (expression_cvterm_id, type_id, rank)

CREATE INDEX expression_cvtermprop_idx1 ON expression_cvtermprop USING btree (expression_cvterm_id)

CREATE INDEX expression_cvtermprop_idx2 ON expression_cvtermprop USING btree (type_id)

CREATE UNIQUE INDEX expression_cvtermprop_pkey ON expression_cvtermprop USING btree (expression_cvtermprop_id)

CREATE UNIQUE INDEX expression_image_c1 ON expression_image USING btree (expression_id, eimage_id)

CREATE INDEX expression_image_idx1 ON expression_image USING btree (expression_id)

CREATE INDEX expression_image_idx2 ON expression_image USING btree (eimage_id)

CREATE UNIQUE INDEX expression_image_pkey ON expression_image USING btree (expression_image_id)

CREATE UNIQUE INDEX expression_pkey ON expression USING btree (expression_id)

CREATE UNIQUE INDEX expression_pub_c1 ON expression_pub USING btree (expression_id, pub_id)

CREATE INDEX expression_pub_idx1 ON expression_pub USING btree (expression_id)

CREATE INDEX expression_pub_idx2 ON expression_pub USING btree (pub_id)

CREATE UNIQUE INDEX expression_pub_pkey ON expression_pub USING btree (expression_pub_id)

CREATE UNIQUE INDEX expressionprop_c1 ON expressionprop USING btree (expression_id, type_id, rank)

CREATE INDEX expressionprop_idx1 ON expressionprop USING btree (expression_id)

CREATE INDEX expressionprop_idx2 ON expressionprop USING btree (type_id)

CREATE UNIQUE INDEX expressionprop_pkey ON expressionprop USING btree (expressionprop_id)

CREATE UNIQUE INDEX feature_c1 ON feature USING btree (organism_id, uniquename, type_id)

CREATE UNIQUE INDEX feature_cvterm_c1 ON feature_cvterm USING btree (feature_id, cvterm_id, pub_id, rank)

CREATE UNIQUE INDEX feature_cvterm_dbxref_c1 ON feature_cvterm_dbxref USING btree (feature_cvterm_id, dbxref_id)

CREATE INDEX feature_cvterm_dbxref_idx1 ON feature_cvterm_dbxref USING btree (feature_cvterm_id)

CREATE INDEX feature_cvterm_dbxref_idx2 ON feature_cvterm_dbxref USING btree (dbxref_id)

CREATE UNIQUE INDEX feature_cvterm_dbxref_pkey ON feature_cvterm_dbxref USING btree (feature_cvterm_dbxref_id)

CREATE INDEX feature_cvterm_idx1 ON feature_cvterm USING btree (feature_id)

CREATE INDEX feature_cvterm_idx2 ON feature_cvterm USING btree (cvterm_id)

CREATE INDEX feature_cvterm_idx3 ON feature_cvterm USING btree (pub_id)

CREATE UNIQUE INDEX feature_cvterm_pkey ON feature_cvterm USING btree (feature_cvterm_id)

CREATE UNIQUE INDEX feature_cvterm_pub_c1 ON feature_cvterm_pub USING btree (feature_cvterm_id, pub_id)

CREATE INDEX feature_cvterm_pub_idx1 ON feature_cvterm_pub USING btree (feature_cvterm_id)

CREATE INDEX feature_cvterm_pub_idx2 ON feature_cvterm_pub USING btree (pub_id)

CREATE UNIQUE INDEX feature_cvterm_pub_pkey ON feature_cvterm_pub USING btree (feature_cvterm_pub_id)

CREATE UNIQUE INDEX feature_cvtermprop_c1 ON feature_cvtermprop USING btree (feature_cvterm_id, type_id, rank)

CREATE INDEX feature_cvtermprop_idx1 ON feature_cvtermprop USING btree (feature_cvterm_id)

CREATE INDEX feature_cvtermprop_idx2 ON feature_cvtermprop USING btree (type_id)

CREATE UNIQUE INDEX feature_cvtermprop_pkey ON feature_cvtermprop USING btree (feature_cvtermprop_id)

CREATE UNIQUE INDEX feature_dbxref_c1 ON feature_dbxref USING btree (feature_id, dbxref_id)

CREATE INDEX feature_dbxref_idx1 ON feature_dbxref USING btree (feature_id)

CREATE INDEX feature_dbxref_idx2 ON feature_dbxref USING btree (dbxref_id)

CREATE UNIQUE INDEX feature_dbxref_pkey ON feature_dbxref USING btree (feature_dbxref_id)

CREATE UNIQUE INDEX feature_expression_c1 ON feature_expression USING btree (expression_id, feature_id, pub_id)

CREATE INDEX feature_expression_idx1 ON feature_expression USING btree (expression_id)

CREATE INDEX feature_expression_idx2 ON feature_expression USING btree (feature_id)

CREATE INDEX feature_expression_idx3 ON feature_expression USING btree (pub_id)

CREATE UNIQUE INDEX feature_expression_pkey ON feature_expression USING btree (feature_expression_id)

CREATE UNIQUE INDEX feature_expressionprop_c1 ON feature_expressionprop USING btree (feature_expression_id, type_id, rank)

CREATE INDEX feature_expressionprop_idx1 ON feature_expressionprop USING btree (feature_expression_id)

CREATE INDEX feature_expressionprop_idx2 ON feature_expressionprop USING btree (type_id)

CREATE UNIQUE INDEX feature_expressionprop_pkey ON feature_expressionprop USING btree (feature_expressionprop_id)

CREATE UNIQUE INDEX feature_genotype_c1 ON feature_genotype USING btree (feature_id, genotype_id, cvterm_id, chromosome_id, rank, cgroup)

CREATE UNIQUE INDEX feature_genotype_cvterm_pkey ON feature_genotype_cvterm USING btree (feature_genotype_cvterm_id)

CREATE INDEX feature_genotype_idx1 ON feature_genotype USING btree (feature_id)

CREATE INDEX feature_genotype_idx2 ON feature_genotype USING btree (genotype_id)

CREATE UNIQUE INDEX feature_genotype_pkey ON feature_genotype USING btree (feature_genotype_id)

CREATE UNIQUE INDEX feature_genotype_prop_pkey ON feature_genotype_prop USING btree (feature_genotype_prop_id)

CREATE INDEX feature_idx1 ON feature USING btree (dbxref_id)

CREATE INDEX feature_idx2 ON feature USING btree (organism_id)

CREATE INDEX feature_idx3 ON feature USING btree (type_id)

CREATE INDEX feature_idx4 ON feature USING btree (uniquename)

CREATE INDEX feature_idx5 ON feature USING btree (lower((name)::text))

CREATE INDEX feature_name_ind1 ON feature USING btree (name)

CREATE UNIQUE INDEX feature_phenotype_c1 ON feature_phenotype USING btree (feature_id, phenotype_id)

CREATE INDEX feature_phenotype_idx1 ON feature_phenotype USING btree (feature_id)

CREATE INDEX feature_phenotype_idx2 ON feature_phenotype USING btree (phenotype_id)

CREATE UNIQUE INDEX feature_phenotype_pkey ON feature_phenotype USING btree (feature_phenotype_id)

CREATE UNIQUE INDEX feature_pkey ON feature USING btree (feature_id)

CREATE UNIQUE INDEX feature_pub_c1 ON feature_pub USING btree (feature_id, pub_id)

CREATE INDEX feature_pub_idx1 ON feature_pub USING btree (feature_id)

CREATE INDEX feature_pub_idx2 ON feature_pub USING btree (pub_id)

CREATE UNIQUE INDEX feature_pub_pkey ON feature_pub USING btree (feature_pub_id)

CREATE UNIQUE INDEX feature_pubprop_c1 ON feature_pubprop USING btree (feature_pub_id, type_id, rank)

CREATE INDEX feature_pubprop_idx1 ON feature_pubprop USING btree (feature_pub_id)

CREATE UNIQUE INDEX feature_pubprop_pkey ON feature_pubprop USING btree (feature_pubprop_id)

CREATE UNIQUE INDEX feature_relationship_c1 ON feature_relationship USING btree (subject_id, object_id, type_id, rank)

CREATE INDEX feature_relationship_idx1 ON feature_relationship USING btree (subject_id)

CREATE INDEX feature_relationship_idx2 ON feature_relationship USING btree (object_id)

CREATE INDEX feature_relationship_idx3 ON feature_relationship USING btree (type_id)

CREATE UNIQUE INDEX feature_relationship_pkey ON feature_relationship USING btree (feature_relationship_id)

CREATE UNIQUE INDEX feature_relationship_pub_c1 ON feature_relationship_pub USING btree (feature_relationship_id, pub_id)

CREATE INDEX feature_relationship_pub_idx1 ON feature_relationship_pub USING btree (feature_relationship_id)

CREATE INDEX feature_relationship_pub_idx2 ON feature_relationship_pub USING btree (pub_id)

CREATE UNIQUE INDEX feature_relationship_pub_pkey ON feature_relationship_pub USING btree (feature_relationship_pub_id)

CREATE UNIQUE INDEX feature_relationshipprop_c1 ON feature_relationshipprop USING btree (feature_relationship_id, type_id, rank)

CREATE INDEX feature_relationshipprop_idx1 ON feature_relationshipprop USING btree (feature_relationship_id)

CREATE INDEX feature_relationshipprop_idx2 ON feature_relationshipprop USING btree (type_id)

CREATE UNIQUE INDEX feature_relationshipprop_pkey ON feature_relationshipprop USING btree (feature_relationshipprop_id)

CREATE UNIQUE INDEX feature_relationshipprop_pub_c1 ON feature_relationshipprop_pub USING btree (feature_relationshipprop_id, pub_id)

CREATE INDEX feature_relationshipprop_pub_idx1 ON feature_relationshipprop_pub USING btree (feature_relationshipprop_id)

CREATE INDEX feature_relationshipprop_pub_idx2 ON feature_relationshipprop_pub USING btree (pub_id)

CREATE UNIQUE INDEX feature_relationshipprop_pub_pkey ON feature_relationshipprop_pub USING btree (feature_relationshipprop_pub_id)

CREATE UNIQUE INDEX feature_synonym_c1 ON feature_synonym USING btree (synonym_id, feature_id, pub_id)

CREATE INDEX feature_synonym_idx1 ON feature_synonym USING btree (synonym_id)

CREATE INDEX feature_synonym_idx2 ON feature_synonym USING btree (feature_id)

CREATE INDEX feature_synonym_idx3 ON feature_synonym USING btree (pub_id)

CREATE UNIQUE INDEX feature_synonym_pkey ON feature_synonym USING btree (feature_synonym_id)

CREATE UNIQUE INDEX featureloc_c1 ON featureloc USING btree (feature_id, locgroup, rank)

CREATE INDEX featureloc_idx1 ON featureloc USING btree (feature_id)

CREATE INDEX featureloc_idx2 ON featureloc USING btree (srcfeature_id)

CREATE INDEX featureloc_idx3 ON featureloc USING btree (srcfeature_id, fmin, fmax)

CREATE UNIQUE INDEX featureloc_pkey ON featureloc USING btree (featureloc_id)

CREATE UNIQUE INDEX featureloc_pub_c1 ON featureloc_pub USING btree (featureloc_id, pub_id)

CREATE INDEX featureloc_pub_idx1 ON featureloc_pub USING btree (featureloc_id)

CREATE INDEX featureloc_pub_idx2 ON featureloc_pub USING btree (pub_id)

CREATE UNIQUE INDEX featureloc_pub_pkey ON featureloc_pub USING btree (featureloc_pub_id)

CREATE UNIQUE INDEX featuremap_c1 ON featuremap USING btree (name)

CREATE UNIQUE INDEX featuremap_pkey ON featuremap USING btree (featuremap_id)

CREATE INDEX featuremap_pub_idx1 ON featuremap_pub USING btree (featuremap_id)

CREATE INDEX featuremap_pub_idx2 ON featuremap_pub USING btree (pub_id)

CREATE UNIQUE INDEX featuremap_pub_pkey ON featuremap_pub USING btree (featuremap_pub_id)

CREATE INDEX featurepos_idx1 ON featurepos USING btree (featuremap_id)

CREATE INDEX featurepos_idx2 ON featurepos USING btree (feature_id)

CREATE INDEX featurepos_idx3 ON featurepos USING btree (map_feature_id)

CREATE UNIQUE INDEX featurepos_pkey ON featurepos USING btree (featurepos_id)

CREATE UNIQUE INDEX featureprop_c1 ON featureprop USING btree (feature_id, type_id, rank)

CREATE INDEX featureprop_idx1 ON featureprop USING btree (feature_id)

CREATE INDEX featureprop_idx2 ON featureprop USING btree (type_id)

CREATE UNIQUE INDEX featureprop_pkey ON featureprop USING btree (featureprop_id)

CREATE UNIQUE INDEX featureprop_pub_c1 ON featureprop_pub USING btree (featureprop_id, pub_id)

CREATE INDEX featureprop_pub_idx1 ON featureprop_pub USING btree (featureprop_id)

CREATE INDEX featureprop_pub_idx2 ON featureprop_pub USING btree (pub_id)

CREATE UNIQUE INDEX featureprop_pub_pkey ON featureprop_pub USING btree (featureprop_pub_id)

CREATE INDEX featurerange_idx1 ON featurerange USING btree (featuremap_id)

CREATE INDEX featurerange_idx2 ON featurerange USING btree (feature_id)

CREATE INDEX featurerange_idx3 ON featurerange USING btree (leftstartf_id)

CREATE INDEX featurerange_idx4 ON featurerange USING btree (leftendf_id)

CREATE INDEX featurerange_idx5 ON featurerange USING btree (rightstartf_id)

CREATE INDEX featurerange_idx6 ON featurerange USING btree (rightendf_id)

CREATE UNIQUE INDEX featurerange_pkey ON featurerange USING btree (featurerange_id)

CREATE UNIQUE INDEX genotype_c1 ON genotype USING btree (uniquename)

CREATE UNIQUE INDEX genotype_cvterm_pkey ON genotype_cvterm USING btree (genotype_cvterm_id)

CREATE UNIQUE INDEX genotype_dbxref_pkey ON genotype_dbxref USING btree (genotype_dbxref_id)

CREATE INDEX genotype_idx1 ON genotype USING btree (uniquename)

CREATE INDEX genotype_idx2 ON genotype USING btree (name)

CREATE UNIQUE INDEX genotype_pkey ON genotype USING btree (genotype_id)

CREATE UNIQUE INDEX genotype_synonym_pkey ON genotype_synonym USING btree (genotype_synonym_id)

CREATE UNIQUE INDEX genotypeprop_c1 ON genotypeprop USING btree (genotype_id, type_id, rank)

CREATE INDEX genotypeprop_idx1 ON genotypeprop USING btree (genotype_id)

CREATE INDEX genotypeprop_idx2 ON genotypeprop USING btree (type_id)

CREATE UNIQUE INDEX genotypeprop_pkey ON genotypeprop USING btree (genotypeprop_id)

CREATE UNIQUE INDEX library_c1 ON library USING btree (organism_id, uniquename, type_id)

CREATE UNIQUE INDEX library_cvterm_c1 ON library_cvterm USING btree (library_id, cvterm_id, pub_id)

CREATE INDEX library_cvterm_idx1 ON library_cvterm USING btree (library_id)

CREATE INDEX library_cvterm_idx2 ON library_cvterm USING btree (cvterm_id)

CREATE INDEX library_cvterm_idx3 ON library_cvterm USING btree (pub_id)

CREATE UNIQUE INDEX library_cvterm_pkey ON library_cvterm USING btree (library_cvterm_id)

CREATE UNIQUE INDEX library_dbxref_c1 ON library_dbxref USING btree (library_id, dbxref_id)

CREATE INDEX library_dbxref_idx1 ON library_dbxref USING btree (library_id)

CREATE INDEX library_dbxref_idx2 ON library_dbxref USING btree (dbxref_id)

CREATE UNIQUE INDEX library_dbxref_pkey ON library_dbxref USING btree (library_dbxref_id)

CREATE UNIQUE INDEX library_feature_c1 ON library_feature USING btree (library_id, feature_id)

CREATE INDEX library_feature_idx1 ON library_feature USING btree (library_id)

CREATE INDEX library_feature_idx2 ON library_feature USING btree (feature_id)

CREATE UNIQUE INDEX library_feature_pkey ON library_feature USING btree (library_feature_id)

CREATE INDEX library_idx1 ON library USING btree (organism_id)

CREATE INDEX library_idx2 ON library USING btree (type_id)

CREATE INDEX library_idx3 ON library USING btree (uniquename)

CREATE INDEX library_name_ind1 ON library USING btree (name)

CREATE UNIQUE INDEX library_pkey ON library USING btree (library_id)

CREATE UNIQUE INDEX library_pub_c1 ON library_pub USING btree (library_id, pub_id)

CREATE INDEX library_pub_idx1 ON library_pub USING btree (library_id)

CREATE INDEX library_pub_idx2 ON library_pub USING btree (pub_id)

CREATE UNIQUE INDEX library_pub_pkey ON library_pub USING btree (library_pub_id)

CREATE UNIQUE INDEX library_synonym_c1 ON library_synonym USING btree (synonym_id, library_id, pub_id)

CREATE INDEX library_synonym_idx1 ON library_synonym USING btree (synonym_id)

CREATE INDEX library_synonym_idx2 ON library_synonym USING btree (library_id)

CREATE INDEX library_synonym_idx3 ON library_synonym USING btree (pub_id)

CREATE UNIQUE INDEX library_synonym_pkey ON library_synonym USING btree (library_synonym_id)

CREATE UNIQUE INDEX libraryprop_c1 ON libraryprop USING btree (library_id, type_id, rank)

CREATE INDEX libraryprop_idx1 ON libraryprop USING btree (library_id)

CREATE INDEX libraryprop_idx2 ON libraryprop USING btree (type_id)

CREATE UNIQUE INDEX libraryprop_pkey ON libraryprop USING btree (libraryprop_id)

CREATE UNIQUE INDEX libraryprop_pub_c1 ON libraryprop_pub USING btree (libraryprop_id, pub_id)

CREATE INDEX libraryprop_pub_idx1 ON libraryprop_pub USING btree (libraryprop_id)

CREATE INDEX libraryprop_pub_idx2 ON libraryprop_pub USING btree (pub_id)

CREATE UNIQUE INDEX libraryprop_pub_pkey ON libraryprop_pub USING btree (libraryprop_pub_id)

CREATE INDEX magedocumentation_idx1 ON magedocumentation USING btree (mageml_id)

CREATE INDEX magedocumentation_idx2 ON magedocumentation USING btree (tableinfo_id)

CREATE INDEX magedocumentation_idx3 ON magedocumentation USING btree (row_id)

CREATE UNIQUE INDEX magedocumentation_pkey ON magedocumentation USING btree (magedocumentation_id)

CREATE UNIQUE INDEX mageml_pkey ON mageml USING btree (mageml_id)

CREATE UNIQUE INDEX materialized_view_name_key ON materialized_view USING btree (name)

CREATE UNIQUE INDEX nd_experiment_contact_pkey ON nd_experiment_contact USING btree (nd_experiment_contact_id)

CREATE UNIQUE INDEX nd_experiment_dbxref_pkey ON nd_experiment_dbxref USING btree (nd_experiment_dbxref_id)

CREATE UNIQUE INDEX nd_experiment_genotype_c1 ON nd_experiment_genotype USING btree (nd_experiment_id, genotype_id)

CREATE UNIQUE INDEX nd_experiment_genotype_pkey ON nd_experiment_genotype USING btree (nd_experiment_genotype_id)

CREATE UNIQUE INDEX nd_experiment_phenotype_c1 ON nd_experiment_phenotype USING btree (nd_experiment_id, phenotype_id)

CREATE UNIQUE INDEX nd_experiment_phenotype_pkey ON nd_experiment_phenotype USING btree (nd_experiment_phenotype_id)

CREATE UNIQUE INDEX nd_experiment_pkey ON nd_experiment USING btree (nd_experiment_id)

CREATE UNIQUE INDEX nd_experiment_project_pkey ON nd_experiment_project USING btree (nd_experiment_project_id)

CREATE UNIQUE INDEX nd_experiment_protocol_pkey ON nd_experiment_protocol USING btree (nd_experiment_protocol_id)

CREATE UNIQUE INDEX nd_experiment_pub_c1 ON nd_experiment_pub USING btree (nd_experiment_id, pub_id)

CREATE INDEX nd_experiment_pub_idx1 ON nd_experiment_pub USING btree (nd_experiment_id)

CREATE INDEX nd_experiment_pub_idx2 ON nd_experiment_pub USING btree (pub_id)

CREATE UNIQUE INDEX nd_experiment_pub_pkey ON nd_experiment_pub USING btree (nd_experiment_pub_id)

CREATE UNIQUE INDEX nd_experiment_stock_dbxref_pkey ON nd_experiment_stock_dbxref USING btree (nd_experiment_stock_dbxref_id)

CREATE UNIQUE INDEX nd_experiment_stock_pkey ON nd_experiment_stock USING btree (nd_experiment_stock_id)

CREATE UNIQUE INDEX nd_experiment_stockprop_c1 ON nd_experiment_stockprop USING btree (nd_experiment_stock_id, type_id, rank)

CREATE UNIQUE INDEX nd_experiment_stockprop_pkey ON nd_experiment_stockprop USING btree (nd_experiment_stockprop_id)

CREATE UNIQUE INDEX nd_experimentprop_c1 ON nd_experimentprop USING btree (nd_experiment_id, type_id, rank)

CREATE UNIQUE INDEX nd_experimentprop_pkey ON nd_experimentprop USING btree (nd_experimentprop_id)

CREATE UNIQUE INDEX nd_geolocation_pkey ON nd_geolocation USING btree (nd_geolocation_id)

CREATE UNIQUE INDEX nd_geolocationprop_c1 ON nd_geolocationprop USING btree (nd_geolocation_id, type_id, rank)

CREATE UNIQUE INDEX nd_geolocationprop_pkey ON nd_geolocationprop USING btree (nd_geolocationprop_id)

CREATE UNIQUE INDEX nd_protocol_name_key ON nd_protocol USING btree (name)

CREATE UNIQUE INDEX nd_protocol_pkey ON nd_protocol USING btree (nd_protocol_id)

CREATE UNIQUE INDEX nd_protocol_reagent_pkey ON nd_protocol_reagent USING btree (nd_protocol_reagent_id)

CREATE UNIQUE INDEX nd_protocolprop_c1 ON nd_protocolprop USING btree (nd_protocol_id, type_id, rank)

CREATE UNIQUE INDEX nd_protocolprop_pkey ON nd_protocolprop USING btree (nd_protocolprop_id)

CREATE UNIQUE INDEX nd_reagent_pkey ON nd_reagent USING btree (nd_reagent_id)

CREATE UNIQUE INDEX nd_reagent_relationship_pkey ON nd_reagent_relationship USING btree (nd_reagent_relationship_id)

CREATE UNIQUE INDEX nd_reagentprop_c1 ON nd_reagentprop USING btree (nd_reagent_id, type_id, rank)

CREATE UNIQUE INDEX nd_reagentprop_pkey ON nd_reagentprop USING btree (nd_reagentprop_id)

CREATE INDEX oauth_common_consumer_key_hash_idx ON oauth_common_consumer USING btree (key_hash)

CREATE UNIQUE INDEX oauth_common_consumer_pkey ON oauth_common_consumer USING btree (csid)

CREATE UNIQUE INDEX oauth_common_context_context_key ON oauth_common_context USING btree (name)

CREATE UNIQUE INDEX oauth_common_context_pkey ON oauth_common_context USING btree (cid)

CREATE UNIQUE INDEX oauth_common_nonce_pkey ON oauth_common_nonce USING btree (nonce)

CREATE INDEX oauth_common_nonce_timekey_idx ON oauth_common_nonce USING btree ("timestamp", token_key)

CREATE UNIQUE INDEX oauth_common_provider_consumer_csid_key ON oauth_common_provider_consumer USING btree (csid)

CREATE UNIQUE INDEX oauth_common_provider_consumer_pkey ON oauth_common_provider_consumer USING btree (consumer_key)

CREATE INDEX oauth_common_provider_consumer_uid_idx ON oauth_common_provider_consumer USING btree (uid)

CREATE UNIQUE INDEX oauth_common_provider_token_pkey ON oauth_common_provider_token USING btree (token_key)

CREATE UNIQUE INDEX oauth_common_provider_token_tid_key ON oauth_common_provider_token USING btree (tid)

CREATE INDEX oauth_common_token_key_hash_idx ON oauth_common_token USING btree (key_hash)

CREATE UNIQUE INDEX oauth_common_token_pkey ON oauth_common_token USING btree (tid)

CREATE UNIQUE INDEX organism_c1 ON organism USING btree (genus, species)

CREATE UNIQUE INDEX organism_dbxref_c1 ON organism_dbxref USING btree (organism_id, dbxref_id)

CREATE INDEX organism_dbxref_idx1 ON organism_dbxref USING btree (organism_id)

CREATE INDEX organism_dbxref_idx2 ON organism_dbxref USING btree (dbxref_id)

CREATE UNIQUE INDEX organism_dbxref_pkey ON organism_dbxref USING btree (organism_dbxref_id)

CREATE INDEX organism_feature_count_organism_feature_count_idx1_idx ON organism_feature_count USING btree (organism_id)

CREATE INDEX organism_feature_count_organism_feature_count_idx2_idx ON organism_feature_count USING btree (cvterm_id)

CREATE INDEX organism_feature_count_organism_feature_count_idx3_idx ON organism_feature_count USING btree (feature_type)

CREATE UNIQUE INDEX organism_pkey ON organism USING btree (organism_id)

CREATE UNIQUE INDEX organismprop_c1 ON organismprop USING btree (organism_id, type_id, rank)

CREATE INDEX organismprop_idx1 ON organismprop USING btree (organism_id)

CREATE INDEX organismprop_idx2 ON organismprop USING btree (type_id)

CREATE UNIQUE INDEX organismprop_pkey ON organismprop USING btree (organismprop_id)

CREATE UNIQUE INDEX phendesc_c1 ON phendesc USING btree (genotype_id, environment_id, type_id, pub_id)

CREATE INDEX phendesc_idx1 ON phendesc USING btree (genotype_id)

CREATE INDEX phendesc_idx2 ON phendesc USING btree (environment_id)

CREATE INDEX phendesc_idx3 ON phendesc USING btree (pub_id)

CREATE UNIQUE INDEX phendesc_pkey ON phendesc USING btree (phendesc_id)

CREATE UNIQUE INDEX phenotype_c1 ON phenotype USING btree (uniquename)

CREATE UNIQUE INDEX phenotype_comparison_c1 ON phenotype_comparison USING btree (genotype1_id, environment1_id, genotype2_id, environment2_id, phenotype1_id, pub_id)

CREATE UNIQUE INDEX phenotype_comparison_cvterm_c1 ON phenotype_comparison_cvterm USING btree (phenotype_comparison_id, cvterm_id)

CREATE INDEX phenotype_comparison_cvterm_idx1 ON phenotype_comparison_cvterm USING btree (phenotype_comparison_id)

CREATE INDEX phenotype_comparison_cvterm_idx2 ON phenotype_comparison_cvterm USING btree (cvterm_id)

CREATE UNIQUE INDEX phenotype_comparison_cvterm_pkey ON phenotype_comparison_cvterm USING btree (phenotype_comparison_cvterm_id)

CREATE INDEX phenotype_comparison_idx1 ON phenotype_comparison USING btree (genotype1_id)

CREATE INDEX phenotype_comparison_idx2 ON phenotype_comparison USING btree (genotype2_id)

CREATE INDEX phenotype_comparison_idx4 ON phenotype_comparison USING btree (pub_id)

CREATE UNIQUE INDEX phenotype_comparison_pkey ON phenotype_comparison USING btree (phenotype_comparison_id)

CREATE UNIQUE INDEX phenotype_cvterm_c1 ON phenotype_cvterm USING btree (phenotype_id, cvterm_id, rank)

CREATE INDEX phenotype_cvterm_idx1 ON phenotype_cvterm USING btree (phenotype_id)

CREATE INDEX phenotype_cvterm_idx2 ON phenotype_cvterm USING btree (cvterm_id)

CREATE UNIQUE INDEX phenotype_cvterm_pkey ON phenotype_cvterm USING btree (phenotype_cvterm_id)

CREATE INDEX phenotype_idx1 ON phenotype USING btree (cvalue_id)

CREATE INDEX phenotype_idx2 ON phenotype USING btree (observable_id)

CREATE INDEX phenotype_idx3 ON phenotype USING btree (attr_id)

CREATE UNIQUE INDEX phenotype_pkey ON phenotype USING btree (phenotype_id)

CREATE UNIQUE INDEX phenstatement_c1 ON phenstatement USING btree (genotype_id, phenotype_id, environment_id, type_id, pub_id)

CREATE INDEX phenstatement_idx1 ON phenstatement USING btree (genotype_id)

CREATE INDEX phenstatement_idx2 ON phenstatement USING btree (phenotype_id)

CREATE UNIQUE INDEX phenstatement_pkey ON phenstatement USING btree (phenstatement_id)

CREATE INDEX phylonode_dbxref_idx1 ON phylonode_dbxref USING btree (phylonode_id)

CREATE INDEX phylonode_dbxref_idx2 ON phylonode_dbxref USING btree (dbxref_id)

CREATE UNIQUE INDEX phylonode_dbxref_phylonode_id_dbxref_id_key ON phylonode_dbxref USING btree (phylonode_id, dbxref_id)

CREATE UNIQUE INDEX phylonode_dbxref_pkey ON phylonode_dbxref USING btree (phylonode_dbxref_id)

CREATE INDEX phylonode_organism_idx1 ON phylonode_organism USING btree (phylonode_id)

CREATE INDEX phylonode_organism_idx2 ON phylonode_organism USING btree (organism_id)

CREATE UNIQUE INDEX phylonode_organism_phylonode_id_key ON phylonode_organism USING btree (phylonode_id)

CREATE UNIQUE INDEX phylonode_organism_pkey ON phylonode_organism USING btree (phylonode_organism_id)

CREATE UNIQUE INDEX phylonode_phylotree_id_left_idx_key ON phylonode USING btree (phylotree_id, left_idx)

CREATE UNIQUE INDEX phylonode_phylotree_id_right_idx_key ON phylonode USING btree (phylotree_id, right_idx)

CREATE UNIQUE INDEX phylonode_pkey ON phylonode USING btree (phylonode_id)

CREATE INDEX phylonode_pub_idx1 ON phylonode_pub USING btree (phylonode_id)

CREATE INDEX phylonode_pub_idx2 ON phylonode_pub USING btree (pub_id)

CREATE UNIQUE INDEX phylonode_pub_phylonode_id_pub_id_key ON phylonode_pub USING btree (phylonode_id, pub_id)

CREATE UNIQUE INDEX phylonode_pub_pkey ON phylonode_pub USING btree (phylonode_pub_id)

CREATE INDEX phylonode_relationship_idx1 ON phylonode_relationship USING btree (subject_id)

CREATE INDEX phylonode_relationship_idx2 ON phylonode_relationship USING btree (object_id)

CREATE INDEX phylonode_relationship_idx3 ON phylonode_relationship USING btree (type_id)

CREATE UNIQUE INDEX phylonode_relationship_pkey ON phylonode_relationship USING btree (phylonode_relationship_id)

CREATE UNIQUE INDEX phylonode_relationship_subject_id_object_id_type_id_key ON phylonode_relationship USING btree (subject_id, object_id, type_id)

CREATE INDEX phylonodeprop_idx1 ON phylonodeprop USING btree (phylonode_id)

CREATE INDEX phylonodeprop_idx2 ON phylonodeprop USING btree (type_id)

CREATE UNIQUE INDEX phylonodeprop_phylonode_id_type_id_value_rank_key ON phylonodeprop USING btree (phylonode_id, type_id, value, rank)

CREATE UNIQUE INDEX phylonodeprop_pkey ON phylonodeprop USING btree (phylonodeprop_id)

CREATE INDEX phylotree_idx1 ON phylotree USING btree (phylotree_id)

CREATE UNIQUE INDEX phylotree_pkey ON phylotree USING btree (phylotree_id)

CREATE INDEX phylotree_pub_idx1 ON phylotree_pub USING btree (phylotree_id)

CREATE INDEX phylotree_pub_idx2 ON phylotree_pub USING btree (pub_id)

CREATE UNIQUE INDEX phylotree_pub_phylotree_id_pub_id_key ON phylotree_pub USING btree (phylotree_id, pub_id)

CREATE UNIQUE INDEX phylotree_pub_pkey ON phylotree_pub USING btree (phylotree_pub_id)

CREATE UNIQUE INDEX project_c1 ON project USING btree (name)

CREATE UNIQUE INDEX project_contact_c1 ON project_contact USING btree (project_id, contact_id)

CREATE INDEX project_contact_idx1 ON project_contact USING btree (project_id)

CREATE INDEX project_contact_idx2 ON project_contact USING btree (contact_id)

CREATE UNIQUE INDEX project_contact_pkey ON project_contact USING btree (project_contact_id)

CREATE UNIQUE INDEX project_pkey ON project USING btree (project_id)

CREATE UNIQUE INDEX project_pub_c1 ON project_pub USING btree (project_id, pub_id)

CREATE INDEX project_pub_idx1 ON project_pub USING btree (project_id)

CREATE INDEX project_pub_idx2 ON project_pub USING btree (pub_id)

CREATE UNIQUE INDEX project_pub_pkey ON project_pub USING btree (project_pub_id)

CREATE UNIQUE INDEX project_relationship_c1 ON project_relationship USING btree (subject_project_id, object_project_id, type_id)

CREATE UNIQUE INDEX project_relationship_pkey ON project_relationship USING btree (project_relationship_id)

CREATE UNIQUE INDEX projectprop_c1 ON projectprop USING btree (project_id, type_id, rank)

CREATE UNIQUE INDEX projectprop_pkey ON projectprop USING btree (projectprop_id)

CREATE UNIQUE INDEX protocol_c1 ON protocol USING btree (name)

CREATE INDEX protocol_idx1 ON protocol USING btree (type_id)

CREATE INDEX protocol_idx2 ON protocol USING btree (pub_id)

CREATE INDEX protocol_idx3 ON protocol USING btree (dbxref_id)

CREATE UNIQUE INDEX protocol_pkey ON protocol USING btree (protocol_id)

CREATE INDEX protocolparam_idx1 ON protocolparam USING btree (protocol_id)

CREATE INDEX protocolparam_idx2 ON protocolparam USING btree (datatype_id)

CREATE INDEX protocolparam_idx3 ON protocolparam USING btree (unittype_id)

CREATE UNIQUE INDEX protocolparam_pkey ON protocolparam USING btree (protocolparam_id)

CREATE UNIQUE INDEX pub_c1 ON pub USING btree (uniquename)

CREATE UNIQUE INDEX pub_dbxref_c1 ON pub_dbxref USING btree (pub_id, dbxref_id)

CREATE INDEX pub_dbxref_idx1 ON pub_dbxref USING btree (pub_id)

CREATE INDEX pub_dbxref_idx2 ON pub_dbxref USING btree (dbxref_id)

CREATE UNIQUE INDEX pub_dbxref_pkey ON pub_dbxref USING btree (pub_dbxref_id)

CREATE INDEX pub_idx1 ON pub USING btree (type_id)

CREATE UNIQUE INDEX pub_pkey ON pub USING btree (pub_id)

CREATE UNIQUE INDEX pub_relationship_c1 ON pub_relationship USING btree (subject_id, object_id, type_id)

CREATE INDEX pub_relationship_idx1 ON pub_relationship USING btree (subject_id)

CREATE INDEX pub_relationship_idx2 ON pub_relationship USING btree (object_id)

CREATE INDEX pub_relationship_idx3 ON pub_relationship USING btree (type_id)

CREATE UNIQUE INDEX pub_relationship_pkey ON pub_relationship USING btree (pub_relationship_id)

CREATE UNIQUE INDEX pubauthor_c1 ON pubauthor USING btree (pub_id, rank)

CREATE UNIQUE INDEX pubauthor_contact_pkey ON pubauthor_contact USING btree (pubauthor_contact_id)

CREATE UNIQUE INDEX pubauthor_contact_pubauthor_contact_c1_key ON pubauthor_contact USING btree (contact_id, pubauthor_id)

CREATE INDEX pubauthor_idx2 ON pubauthor USING btree (pub_id)

CREATE UNIQUE INDEX pubauthor_pkey ON pubauthor USING btree (pubauthor_id)

CREATE UNIQUE INDEX pubprop_c1 ON pubprop USING btree (pub_id, type_id, rank)

CREATE INDEX pubprop_idx1 ON pubprop USING btree (pub_id)

CREATE INDEX pubprop_idx2 ON pubprop USING btree (type_id)

CREATE UNIQUE INDEX pubprop_pkey ON pubprop USING btree (pubprop_id)

CREATE UNIQUE INDEX quantification_c1 ON quantification USING btree (name, analysis_id)

CREATE INDEX quantification_idx1 ON quantification USING btree (acquisition_id)

CREATE INDEX quantification_idx2 ON quantification USING btree (operator_id)

CREATE INDEX quantification_idx3 ON quantification USING btree (protocol_id)

CREATE INDEX quantification_idx4 ON quantification USING btree (analysis_id)

CREATE UNIQUE INDEX quantification_pkey ON quantification USING btree (quantification_id)

CREATE UNIQUE INDEX quantification_relationship_c1 ON quantification_relationship USING btree (subject_id, object_id, type_id)

CREATE INDEX quantification_relationship_idx1 ON quantification_relationship USING btree (subject_id)

CREATE INDEX quantification_relationship_idx2 ON quantification_relationship USING btree (type_id)

CREATE INDEX quantification_relationship_idx3 ON quantification_relationship USING btree (object_id)

CREATE UNIQUE INDEX quantification_relationship_pkey ON quantification_relationship USING btree (quantification_relationship_id)

CREATE UNIQUE INDEX quantificationprop_c1 ON quantificationprop USING btree (quantification_id, type_id, rank)

CREATE INDEX quantificationprop_idx1 ON quantificationprop USING btree (quantification_id)

CREATE INDEX quantificationprop_idx2 ON quantificationprop USING btree (type_id)

CREATE UNIQUE INDEX quantificationprop_pkey ON quantificationprop USING btree (quantificationprop_id)

CREATE UNIQUE INDEX services_endpoint_name_key ON services_endpoint USING btree (name)

CREATE UNIQUE INDEX services_endpoint_pkey ON services_endpoint USING btree (eid)

CREATE UNIQUE INDEX stock_c1 ON stock USING btree (organism_id, uniquename, type_id)

CREATE UNIQUE INDEX stock_cvterm_c1 ON stock_cvterm USING btree (stock_id, cvterm_id, pub_id, rank)

CREATE INDEX stock_cvterm_idx1 ON stock_cvterm USING btree (stock_id)

CREATE INDEX stock_cvterm_idx2 ON stock_cvterm USING btree (cvterm_id)

CREATE INDEX stock_cvterm_idx3 ON stock_cvterm USING btree (pub_id)

CREATE UNIQUE INDEX stock_cvterm_pkey ON stock_cvterm USING btree (stock_cvterm_id)

CREATE UNIQUE INDEX stock_cvtermprop_c1 ON stock_cvtermprop USING btree (stock_cvterm_id, type_id, rank)

CREATE INDEX stock_cvtermprop_idx1 ON stock_cvtermprop USING btree (stock_cvterm_id)

CREATE INDEX stock_cvtermprop_idx2 ON stock_cvtermprop USING btree (type_id)

CREATE UNIQUE INDEX stock_cvtermprop_pkey ON stock_cvtermprop USING btree (stock_cvtermprop_id)

CREATE UNIQUE INDEX stock_dbxref_c1 ON stock_dbxref USING btree (stock_id, dbxref_id)

CREATE INDEX stock_dbxref_idx1 ON stock_dbxref USING btree (stock_id)

CREATE INDEX stock_dbxref_idx2 ON stock_dbxref USING btree (dbxref_id)

CREATE UNIQUE INDEX stock_dbxref_pkey ON stock_dbxref USING btree (stock_dbxref_id)

CREATE UNIQUE INDEX stock_dbxrefprop_c1 ON stock_dbxrefprop USING btree (stock_dbxref_id, type_id, rank)

CREATE INDEX stock_dbxrefprop_idx1 ON stock_dbxrefprop USING btree (stock_dbxref_id)

CREATE INDEX stock_dbxrefprop_idx2 ON stock_dbxrefprop USING btree (type_id)

CREATE UNIQUE INDEX stock_dbxrefprop_pkey ON stock_dbxrefprop USING btree (stock_dbxrefprop_id)

CREATE UNIQUE INDEX stock_genotype_c1 ON stock_genotype USING btree (stock_id, genotype_id)

CREATE UNIQUE INDEX stock_genotype_cvterm_pkey ON stock_genotype_cvterm USING btree (stock_genotype_cvterm_id)

CREATE INDEX stock_genotype_idx1 ON stock_genotype USING btree (stock_id)

CREATE INDEX stock_genotype_idx2 ON stock_genotype USING btree (genotype_id)

CREATE UNIQUE INDEX stock_genotype_pkey ON stock_genotype USING btree (stock_genotype_id)

CREATE UNIQUE INDEX stock_genotype_prop_pkey ON stock_genotype_prop USING btree (stock_genotype_prop_id)

CREATE INDEX stock_idx1 ON stock USING btree (dbxref_id)

CREATE INDEX stock_idx2 ON stock USING btree (organism_id)

CREATE INDEX stock_idx3 ON stock USING btree (type_id)

CREATE INDEX stock_idx4 ON stock USING btree (uniquename)

CREATE INDEX stock_name_ind1 ON stock USING btree (name)

CREATE UNIQUE INDEX stock_pkey ON stock USING btree (stock_id)

CREATE UNIQUE INDEX stock_pub_c1 ON stock_pub USING btree (stock_id, pub_id)

CREATE INDEX stock_pub_idx1 ON stock_pub USING btree (stock_id)

CREATE INDEX stock_pub_idx2 ON stock_pub USING btree (pub_id)

CREATE UNIQUE INDEX stock_pub_pkey ON stock_pub USING btree (stock_pub_id)

CREATE UNIQUE INDEX stock_relationship_c1 ON stock_relationship USING btree (subject_id, object_id, type_id, rank)

CREATE UNIQUE INDEX stock_relationship_cvterm_pkey ON stock_relationship_cvterm USING btree (stock_relationship_cvterm_id)

CREATE INDEX stock_relationship_idx1 ON stock_relationship USING btree (subject_id)

CREATE INDEX stock_relationship_idx2 ON stock_relationship USING btree (object_id)

CREATE INDEX stock_relationship_idx3 ON stock_relationship USING btree (type_id)

CREATE UNIQUE INDEX stock_relationship_pkey ON stock_relationship USING btree (stock_relationship_id)

CREATE UNIQUE INDEX stock_relationship_pub_c1 ON stock_relationship_pub USING btree (stock_relationship_id, pub_id)

CREATE INDEX stock_relationship_pub_idx1 ON stock_relationship_pub USING btree (stock_relationship_id)

CREATE INDEX stock_relationship_pub_idx2 ON stock_relationship_pub USING btree (pub_id)

CREATE UNIQUE INDEX stock_relationship_pub_pkey ON stock_relationship_pub USING btree (stock_relationship_pub_id)

CREATE UNIQUE INDEX stock_synonym_pkey ON stock_synonym USING btree (stock_synonym_id)

CREATE UNIQUE INDEX stockcollection_c1 ON stockcollection USING btree (uniquename, type_id)

CREATE INDEX stockcollection_idx1 ON stockcollection USING btree (contact_id)

CREATE INDEX stockcollection_idx2 ON stockcollection USING btree (type_id)

CREATE INDEX stockcollection_idx3 ON stockcollection USING btree (uniquename)

CREATE INDEX stockcollection_name_ind1 ON stockcollection USING btree (name)

CREATE UNIQUE INDEX stockcollection_pkey ON stockcollection USING btree (stockcollection_id)

CREATE UNIQUE INDEX stockcollection_stock_c1 ON stockcollection_stock USING btree (stockcollection_id, stock_id)

CREATE INDEX stockcollection_stock_idx1 ON stockcollection_stock USING btree (stockcollection_id)

CREATE INDEX stockcollection_stock_idx2 ON stockcollection_stock USING btree (stock_id)

CREATE UNIQUE INDEX stockcollection_stock_pkey ON stockcollection_stock USING btree (stockcollection_stock_id)

CREATE UNIQUE INDEX stockcollectionprop_c1 ON stockcollectionprop USING btree (stockcollection_id, type_id, rank)

CREATE INDEX stockcollectionprop_idx1 ON stockcollectionprop USING btree (stockcollection_id)

CREATE INDEX stockcollectionprop_idx2 ON stockcollectionprop USING btree (type_id)

CREATE UNIQUE INDEX stockcollectionprop_pkey ON stockcollectionprop USING btree (stockcollectionprop_id)

CREATE UNIQUE INDEX stockprop_c1 ON stockprop USING btree (stock_id, type_id, rank)

CREATE INDEX stockprop_idx1 ON stockprop USING btree (stock_id)

CREATE INDEX stockprop_idx2 ON stockprop USING btree (type_id)

CREATE UNIQUE INDEX stockprop_pkey ON stockprop USING btree (stockprop_id)

CREATE UNIQUE INDEX stockprop_pub_c1 ON stockprop_pub USING btree (stockprop_id, pub_id)

CREATE INDEX stockprop_pub_idx1 ON stockprop_pub USING btree (stockprop_id)

CREATE INDEX stockprop_pub_idx2 ON stockprop_pub USING btree (pub_id)

CREATE UNIQUE INDEX stockprop_pub_pkey ON stockprop_pub USING btree (stockprop_pub_id)

CREATE UNIQUE INDEX study_assay_c1 ON study_assay USING btree (study_id, assay_id)

CREATE INDEX study_assay_idx1 ON study_assay USING btree (study_id)

CREATE INDEX study_assay_idx2 ON study_assay USING btree (assay_id)

CREATE UNIQUE INDEX study_assay_pkey ON study_assay USING btree (study_assay_id)

CREATE UNIQUE INDEX study_c1 ON study USING btree (name)

CREATE INDEX study_idx1 ON study USING btree (contact_id)

CREATE INDEX study_idx2 ON study USING btree (pub_id)

CREATE INDEX study_idx3 ON study USING btree (dbxref_id)

CREATE UNIQUE INDEX study_pkey ON study USING btree (study_id)

CREATE INDEX studydesign_idx1 ON studydesign USING btree (study_id)

CREATE UNIQUE INDEX studydesign_pkey ON studydesign USING btree (studydesign_id)

CREATE UNIQUE INDEX studydesignprop_c1 ON studydesignprop USING btree (studydesign_id, type_id, rank)

CREATE INDEX studydesignprop_idx1 ON studydesignprop USING btree (studydesign_id)

CREATE INDEX studydesignprop_idx2 ON studydesignprop USING btree (type_id)

CREATE UNIQUE INDEX studydesignprop_pkey ON studydesignprop USING btree (studydesignprop_id)

CREATE INDEX studyfactor_idx1 ON studyfactor USING btree (studydesign_id)

CREATE INDEX studyfactor_idx2 ON studyfactor USING btree (type_id)

CREATE UNIQUE INDEX studyfactor_pkey ON studyfactor USING btree (studyfactor_id)

CREATE INDEX studyfactorvalue_idx1 ON studyfactorvalue USING btree (studyfactor_id)

CREATE INDEX studyfactorvalue_idx2 ON studyfactorvalue USING btree (assay_id)

CREATE UNIQUE INDEX studyfactorvalue_pkey ON studyfactorvalue USING btree (studyfactorvalue_id)

CREATE INDEX studyprop_feature_idx1 ON studyprop_feature USING btree (studyprop_id)

CREATE INDEX studyprop_feature_idx2 ON studyprop_feature USING btree (feature_id)

CREATE UNIQUE INDEX studyprop_feature_pkey ON studyprop_feature USING btree (studyprop_feature_id)

CREATE UNIQUE INDEX studyprop_feature_studyprop_id_feature_id_key ON studyprop_feature USING btree (studyprop_id, feature_id)

CREATE INDEX studyprop_idx1 ON studyprop USING btree (study_id)

CREATE INDEX studyprop_idx2 ON studyprop USING btree (type_id)

CREATE UNIQUE INDEX studyprop_pkey ON studyprop USING btree (studyprop_id)

CREATE UNIQUE INDEX studyprop_study_id_type_id_rank_key ON studyprop USING btree (study_id, type_id, rank)

CREATE UNIQUE INDEX synonym_c1 ON synonym USING btree (name, type_id)

CREATE INDEX synonym_idx1 ON synonym USING btree (type_id)

CREATE INDEX synonym_idx2 ON synonym USING btree (lower((synonym_sgml)::text))

CREATE UNIQUE INDEX synonym_pkey ON synonym USING btree (synonym_id)

CREATE UNIQUE INDEX tableinfo_c1 ON tableinfo USING btree (name)

CREATE UNIQUE INDEX tableinfo_pkey ON tableinfo USING btree (tableinfo_id)

CREATE INDEX treatment_idx1 ON treatment USING btree (biomaterial_id)

CREATE INDEX treatment_idx2 ON treatment USING btree (type_id)

CREATE INDEX treatment_idx3 ON treatment USING btree (protocol_id)

CREATE UNIQUE INDEX treatment_pkey ON treatment USING btree (treatment_id)

CREATE INDEX tripal_gff_temp_idx0 ON tripal_gff_temp USING btree (feature_id)

CREATE INDEX tripal_gff_temp_idx1 ON tripal_gff_temp USING btree (organism_id)

CREATE INDEX tripal_gff_temp_idx2 ON tripal_gff_temp USING btree (uniquename)

CREATE UNIQUE INDEX tripal_gff_temp_uq0 ON tripal_gff_temp USING btree (feature_id)

CREATE UNIQUE INDEX tripal_gff_temp_uq1 ON tripal_gff_temp USING btree (uniquename, organism_id, type_name)

CREATE INDEX tripal_obo_temp_idx0 ON tripal_obo_temp USING btree (id)

CREATE INDEX tripal_obo_temp_idx1 ON tripal_obo_temp USING btree (type)

CREATE UNIQUE INDEX tripal_obo_temp_uq0 ON tripal_obo_temp USING btree (id)

select * from stock_relationship sp;

select * from stock s;

-- CS65790 parent lines
INSERT INTO STOCK_RELATIONSHIP 
(subject_id, object_id, type_id, rank, background_accession_id)
VALUES (3, 11, 44389, 1, 12);

INSERT INTO STOCK_RELATIONSHIP 
(subject_id, object_id, type_id, rank, background_accession_id)
VALUES (3, 10, 44389, 0, 12);

select sp.stock_relationship_id, sb.name, c.name relationship_type, ob.name, sbg.uniquename background_accession, stv_c.name relationship_annotation, sp.rank from stock_relationship sp
join 
cvterm c on c.cvterm_id = sp.type_id
join 
stock sb
on sb.stock_id = sp.subject_id 
join stock ob
on ob.stock_id = sp.object_id
join stock sbg
on sbg.stock_id = sp.background_accession_id
left join stock_relationship_cvterm stv
on 
sp.stock_relationship_id = stv.stock_relationship_id
left join cvterm stv_c
on stv_c.cvterm_id = stv.cvterm_id
where sb.name = 'CS65790'
order by sp. rank;


select * from cvterm where cvterm_id = 44392;


INSERT INTO CV 
 (name, definition)
VALUES ('pedigree_generative_method', 'pedigree_generative_method');

select * from dbxref where accession = 'pedigree_generative_method';

INSERT
	INTO dbxref (
	db_id,
	accession,
	description)
VALUES
	(
	73,
	'pedigree_generative_method',
	'pedigree_generative_method');
	
	
	INSERT INTO 
	CVTERM 
	(cv_id, dbxref_id, name, definition)
	VALUES (55, 792453, 'pedigree_generative_method', 'pedigree_generative_method');
	
	select * from cvterm where "name" = 'pedigree_generative_method';
	
	select * from stock_relationship sp;
	
	INSERT INTO stock_relationship_cvterm
	(stock_relationship_id, cvterm_id)
	VALUES (1,44392);
	
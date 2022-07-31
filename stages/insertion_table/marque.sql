--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: marque; Type: TABLE DATA; Schema: public; Owner: doux
--

INSERT INTO marque VALUES (45, 'OPA7', 'OPA7', 6, false, false, false, 114);
INSERT INTO marque VALUES (61, 'LIFE', 'LIFE', 1, false, false, false, 109);
INSERT INTO marque VALUES (47, 'ENC6', 'ENC6', 1, false, false, false, 109);
INSERT INTO marque VALUES (62, 'OPA8', 'OPA8', 6, false, false, false, 103);
INSERT INTO marque VALUES (63, 'OPA9', 'OPA9', 6, false, false, false, 103);
INSERT INTO marque VALUES (65, 'PCP1', 'PCP1', 1, false, true, false, 109);
INSERT INTO marque VALUES (64, 'OTPF', 'OTPF', 8, true, true, false, 105);
INSERT INTO marque VALUES (44, 'OVIV', 'OVIV', 5, false, true, false, 104);
INSERT INTO marque VALUES (67, 'TEST2', 'TEST2', 1, false, false, false, 109);
INSERT INTO marque VALUES (19, 'BSC6', 'BSC6', 1, false, false, true, 109);
INSERT INTO marque VALUES (68, 'TEST3', 'TEST3', 1, false, false, false, 109);
INSERT INTO marque VALUES (69, 'TEST4', 'TEST4', 1, false, false, false, 109);
INSERT INTO marque VALUES (14, 'OGES', 'OGES', 6, false, false, false, 132);
INSERT INTO marque VALUES (18, 'CEC6', NULL, 5, false, false, false, 104);
INSERT INTO marque VALUES (32, 'CSC6', NULL, 1, false, false, false, 109);
INSERT INTO marque VALUES (34, 'CFC6', NULL, 5, false, false, false, 104);
INSERT INTO marque VALUES (1, 'OVIE', 'OVIE', 5, false, true, false, 104);
INSERT INTO marque VALUES (2, 'OGE2', 'OGE2', 11, true, true, false, 112);
INSERT INTO marque VALUES (3, 'DSC4', 'DSC4', 1, false, false, false, 109);
INSERT INTO marque VALUES (4, 'DSC5', 'DSC5', 1, false, false, true, 109);
INSERT INTO marque VALUES (5, 'OSA3', 'OSA3', 5, false, true, false, 104);
INSERT INTO marque VALUES (6, 'OGEC', 'OGEC', 6, false, false, false, 103);
INSERT INTO marque VALUES (7, 'GEV1', 'GEV1', 1, false, true, false, 109);
INSERT INTO marque VALUES (8, 'FP29', 'FP29', 5, false, true, false, 104);
INSERT INTO marque VALUES (10, 'OSA6', 'OSA6', 5, false, true, false, 104);
INSERT INTO marque VALUES (12, 'PPB1', 'PPB1', 5, false, true, false, 104);
INSERT INTO marque VALUES (13, 'FDI3', 'FDI3', 6, false, true, false, 103);
INSERT INTO marque VALUES (15, 'COUP', 'COUP', 8, true, true, false, 105);
INSERT INTO marque VALUES (16, 'FCP3', 'FCP3', 1, false, true, false, 109);
INSERT INTO marque VALUES (17, 'PAC2', 'PAC2', 10, true, true, false, 108);
INSERT INTO marque VALUES (20, 'SBFC', 'SBFC', 5, false, false, true, 104);
INSERT INTO marque VALUES (21, 'FCP2', 'FCP2', 1, false, true, false, 109);
INSERT INTO marque VALUES (22, 'COU8', 'COU8', 1, false, true, false, 109);
INSERT INTO marque VALUES (23, 'USC6', 'USC6', 1, false, false, true, 109);
INSERT INTO marque VALUES (24, 'ESC4', 'ESC4', 1, false, false, true, 109);
INSERT INTO marque VALUES (25, 'PVAB', 'PVAB', 1, false, false, false, 109);
INSERT INTO marque VALUES (26, 'FCPR', 'FCPR', 1, false, true, false, 109);
INSERT INTO marque VALUES (27, 'SSCE', 'SSCE', 1, false, false, true, 109);
INSERT INTO marque VALUES (28, 'OSA2', 'OSA2', 5, false, true, false, 104);
INSERT INTO marque VALUES (29, 'TPC1', 'TPC1', 5, false, true, false, 104);
INSERT INTO marque VALUES (30, 'ESC6', 'ESC6', 1, false, false, true, 109);
INSERT INTO marque VALUES (31, 'FCPP', 'FCPP', 1, false, true, false, 109);
INSERT INTO marque VALUES (33, 'ESSK', 'ESSK', 1, false, false, true, 109);
INSERT INTO marque VALUES (35, 'OGE3', 'OGE3', 11, true, true, false, 112);
INSERT INTO marque VALUES (43, 'COUA', 'COUA', 8, true, true, false, 105);
INSERT INTO marque VALUES (70, 'COU2', 'COU2', 1, false, true, false, 109);
INSERT INTO marque VALUES (71, 'OGEA', 'OGEA', 11, true, true, false, 112);
INSERT INTO marque VALUES (11, 'COU1', 'COU1', 1, false, true, false, 109);
INSERT INTO marque VALUES (9, 'OVI3', 'OVI3', 11, true, true, false, 112);


--
-- Name: marque_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doux
--

SELECT pg_catalog.setval('marque_id_seq', 71, true);


--
-- PostgreSQL database dump complete
--


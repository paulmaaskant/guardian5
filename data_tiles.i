
; object tile tables
objectTiles:
.hex 81 82 91 92 ; 00 plain ground
.hex 68 69 78 79 ; 01 mech legs d1
.hex 6A 6B 7A 7B ; 02 mech legs d2
.hex 4A 4B 5A 5B ; 03 mech legs d3
.hex 48 49 58 59 ; 04 mech legs d4
.hex 46 47 56 57 ; 05 mech legs d5
.hex 66 67 76 77 ; 06 mech legs d6
.hex A6 A6 B6 B7 ; 07 plain ground alternative
.hex A1 A2 B1 B2 ; 08 road
.hex A3 A4 B3 B4 ; 09 road
.hex A1 A4 B3 B2 ; 10 road
.hex 42 43 52 53 ; 11 ground fan (decorative)
.hex 6E 6F 7E 7F ; 12 burning debris
.hex C7 70 B9 BA ; 13 building base, with fan
.hex 4C 4D BE BF ; 14 shadow d1
.hex AE 4F BE BF ; 15 shadow d2
.hex AE AF BE 5F ; 16 shadow d3
.hex AE AF 5C 5D ; 17 shadow d4
.hex AE AF 5E BF ; 18 shadow d5
.hex 4E AF BE BF ; 19 shadow d6

metaTileBlock00:
	.hex 62 89 99 89 99 BC 01 9C 01 AE 01 80 01 64 8C 01
	.hex 80 01 06 85 84 83 80 83 85 84 87 87 01 01 01 97
	.hex 83 97 00 06 06 80 01 06 87 06 97 85 62 62 62 62
	.hex 87 84 62 B9 F1 65 D5 C3 BB EA FD DA D4 D6 DF BB
	.hex CB C3 00 65 DA E1 9B D4 65 F4 B9 D6 D4 FD DA C4
	.hex 65 01 B9 FD EC FC D6 D4 D6 D5 CC D6 A9 DA DA D6
	.hex DD 85 A0 01 97 80 01 83 02 00 B3 B1 01 B5 B3 65

metaTileBlock01:
	.hex 63 9A 8A 8A 9A 00 BD 00 9D 00 AF 00 90 65 00 8D
	.hex 00 90 07 89 86 00 00 00 96 86 93 93 94 90 94 95
	.hex 00 95 01 07 07 00 90 07 93 07 95 96 65 65 65 65
	.hex 93 86 9A BA C2 D4 D6 DF 00 EB BA DB D5 D4 DA 00
	.hex DD DD 00 F0 FB C2 00 E0 65 C5 BA D4 F6 FA CC F5
	.hex 65 B8 FA BA ED DD 65 D5 65 D6 DD DA DA CB AD D4
	.hex DA 96 00 90 95 00 A5 00 94 01 B2 B2 B0 00 B4 65


metaTileBlock02:
	.hex 72 04 04 04 04 B8 03 AD 03 BE 03 93 92 74 98 03
	.hex 90 03 04 73 94 90 93 93 94 95 8A 9A 03 03 03 9A
	.hex 90 8A 02 86 96 90 92 96 9A 86 72 72 8A 72 9A 94
	.hex 72 95 72 96 DD 74 E5 FB 93 B2 A1 DA E4 E6 DF 90
	.hex FB CB 00 74 BA E6 AB D2 F0 E5 04 D1 D2 04 FA E4
	.hex F2 03 04 04 A5 B8 D1 E4 D1 D0 DC DA A9 DA DA D1
	.hex DD 94 B0 03 9A A5 03 5A 04 A3 02 A3 03 90 A1 74

metaTileBlock03:
	.hex 73 05 05 05 05 02 BB 02 AD 02 BF 91 84 75 02 9B
	.hex 02 80 05 89 99 02 02 02 99 89 85 83 80 84 84 83
	.hex 91 73 03 87 87 91 80 97 83 97 75 75 73 89 83 99
	.hex 85 73 87 87 AA E4 E6 FD 02 A0 A2 DB E5 D2 AA 02
	.hex FD DF 00 AC BB AA 02 D3 F1 E6 05 D2 D3 05 FC D0
	.hex F3 80 05 05 B3 B9 F2 D0 E2 D1 DD DA DA CB AD E4
	.hex DA 99 02 A0 83 02 B5 03 A0 A4 03 A4 80 02 A2 75

level1:
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 48	 47	 45	 41	 3B	 60	 5A	 5D	 5C	 5A	 57	 5F	 59	 50	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 35	 36	 3C	 3D	 49	 3B	 3E	 40	 44	 4D	 55	 4E	 5C	 5A	 5D	 5C	 5A	 5E	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 43	 34	 41	 3B	 3E	 40	 44	 53	 3F	 11	 12	 10	 51	 52	 54	 4E	 5C	 5A	 4F	 5F	 59	 50	 35	 36	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 48	 4C	 45	 37	 39	 53	 3F	 11	 12	 10	 11	 12	 65	 66	 12	 6D	 51	 52	 55	 4E	 5C	 5A	 4F	 5B	 5A	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 35	 36	 3C	 3D	 49	 3B	 3E	 46	 6C	 12	 62	 63	 12	 65	 66	 12	 6D	 11	 12	 10	 11	 12	 10	 51	 52	 55	 4E	 3E	 5A	 57	 5F	 59	 57	 56	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 48	 50	 00	 48	 47	 45	 41	 3B	 3E	 40	 44	 53	 3F	 1D	 23	 16	 6C	 12	 62	 63	 12	 10	 11	 12	 10	 11	 12	 10	 11	 12	 10	 51	 52	 54	 4E	 5C	 5A	 5D	 3E	 00	 00	 00	 00	 00
.hex 00	 00	 3C	 3D	 49	 4F	 4B	 49	 3B	 3E	 40	 39	 53	 3F	 11	 12	 10	 1C	 02	 18	 1A	 24	 16	 6C	 12	 62	 63	 12	 10	 11	 12	 10	 11	 12	 65	 66	 12	 6D	 51	 52	 55	 4E	 3E	 00	 00	 00	 00	 00
.hex 35	 36	 3B	 3E	 40	 4E	 3E	 40	 44	 53	 3F	 6C	 12	 62	 63	 12	 10	 11	 12	 10	 1C	 02	 61	 30	 24	 16	 6C	 12	 62	 63	 12	 65	 66	 12	 6D	 11	 12	 10	 11	 12	 10	 51	 4A	 2F	 2C	 00	 00	 00
.hex 34	 37	 39	 53	 3F	 51	 4A	 3F	 1D	 23	 16	 11	 12	 10	 6C	 12	 62	 66	 12	 62	 63	 12	 14	 2C	 32	 17	 11	 12	 10	 6C	 12	 6D	 11	 12	 10	 11	 12	 10	 11	 12	 10	 11	 12	 10	 1C	 02	 2F	 2C
.hex 33	 38	 6C	 12	 62	 63	 12	 10	 1C	 02	 18	 1A	 24	 16	 11	 12	 10	 1D	 23	 16	 6C	 12	 62	 1C	 02	 18	 1B	 12	 10	 1D	 29	 31	 30	 24	 16	 6C	 12	 10	 11	 12	 10	 11	 12	 6D	 11	 12	 10	 1E
.hex 00	 2B	 30	 24	 16	 6C	 12	 62	 63	 12	 10	 1C	 02	 18	 1A	 27	 19	 1F	 03	 61	 30	 24	 16	 11	 12	 10	 1D	 29	 31	 2A	 00	 2D	 2E	 01	 15	 11	 12	 10	 6C	 12	 6D	 11	 12	 10	 1D	 29	 31	 2A
.hex D	 D	 D	 00	 2B	 30	 24	 16	 6C	 12	 62	 63	 12	 10	 1C	 04	 15	 1D	 29	 19	 2E	 01	 15	 1D	 29	 31	 2A	 D	 D	 D	 32	 17	 11	 12	 10	 11	 12	 10	 11	 12	 10	 1D	 29	 31	 2A	 00	 D	 D
.hex 00	 D	 D	 D	 00	 D	 00	 2B	 30	 24	 16	 6C	 12	 62	 63	 12	 14	 1F	 01	 15	 66	 12	 6D	 1C	 02	 2F	 2E	 03	 2F	 2C	 D	 2B	 30	 24	 16	 11	 12	 10	 1D	 29	 31	 2A	 00	 00	 D	 00	 00	 D
.hex D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 2B	 30	 27	 31	 28	 12	 62	 66	 12	 6D	 11	 12	 10	 11	 12	 10	 11	 12	 10	 1C	 02	 2F	 2C	 D	 2B	 30	 27	 31	 2A	 00	 00	 D	 00	 00	 00	 D	 00	 D
.hex 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 00	 D	 00	 00	 30	 24	 16	 11	 12	 10	 11	 12	 10	 11	 12	 10	 11	 12	 10	 11	 12	 10	 1E	 D	 00	 D	 00	 D	 00	 00	 D	 00	 D	 D	 00	 00	 00	 D
.hex D	 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 D	 D	 00	 D	 00	 2B	 30	 24	 16	 11	 12	 10	 11	 12	 10	 11	 12	 10	 1D	 29	 31	 2A	 00	 D	 00	 D	 00	 D	 00	 00	 00	 D	 00	 D	 00	 00	 D
.hex 00	 D	 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 D	 D	 00	 D	 D	 D	 00	 2B	 30	 24	 16	 11	 12	 10	 1D	 29	 31	 2A	 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 D	 00	 00	 00	 00	 00	 00	 D
.hex D	 00	 D	 00	 D	 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 2B	 30	 27	 31	 2A	 00	 D	 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 00	 D	 00	 00	 00	 D	 D	 D	 D
.hex 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 D	 D	 D	 D	 D	 D	 D	 D





objectMap:
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 F0	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 D0	 E0	 E0	 E1	 F1	 F1	 F2	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 B0	 C0	 C0	 C1	 D1	 D1	 D2	 E2	 E2	 E3	 F3	 F3	 F4	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 90	 A0	 A0	 A1	 B1	 B1	 B2	 C2	 C2	 C3	 D3	 D3	 D4	 E4	 E4	 E5	 F5	 F5	 F6	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 70	 80	 80	 81	 91	 91	 92	 A2	 A2	 A3	 B3	 B3	 B4	 C4	 C4	 C5	 D5	 D5	 D6	 E6	 E6	 E7	 F7	 F7	 F8	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 50	 60	 60	 61	 71	 71	 72	 82	 82	 83	 93	 93	 94	 A4	 A4	 A5	 B5	 B5	 B6	 C6	 C6	 C7	 D7	 D7	 D8	 E8	 E8	 E9	 F9	 F9	 FA	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 30	 40	 40	 41	 51	 51	 52	 62	 62	 63	 73	 73	 74	 84	 84	 85	 95	 95	 96	 A6	 A6	 A7	 B7	 B7	 B8	 C8	 C8	 C9	 D9	 D9	 DA	 EA	 EA	 EB	 FB	 FB	 FC	 00	 00	 00	 00	 00
.hex 00	 00	 00	 10	 20	 20	 21	 31	 31	 32	 42	 42	 43	 53	 53	 54	 64	 64	 65	 75	 75	 76	 86	 86	 87	 97	 97	 98	 A8	 A8	 A9	 B9	 B9	 BA	 CA	 CA	 CB	 DB	 DB	 DC	 EC	 EC	 ED	 FD	 FD	 FE	 00	 00
.hex 00	 00	 00	 01	 11	 11	 12	 22	 22	 23	 33	 33	 34	 44	 44	 45	 55	 55	 56	 66	 66	 67	 77	 77	 78	 88	 88	 89	 99	 99	 9A	 AA	 AA	 AB	 BB	 BB	 BC	 CC	 CC	 CD	 DD	 DD	 DE	 EE	 EE	 EF	 FF	 FF
.hex 00	 00	 00	 F2	 02	 02	 03	 13	 13	 14	 24	 24	 25	 35	 35	 36	 46	 46	 47	 57	 57	 58	 68	 68	 69	 79	 79	 7A	 8A	 8A	 8B	 9B	 9B	 9C	 AC	 AC	 AD	 BD	 BD	 BE	 CE	 CE	 CF	 DF	 DF	 E0	 00	 00
.hex 00	 00	 00	 00	 00	 00	 F4	 04	 04	 05	 15	 15	 16	 26	 26	 27	 37	 37	 38	 48	 48	 49	 59	 59	 5A	 6A	 6A	 6B	 7B	 7B	 7C	 8C	 8C	 8D	 9D	 9D	 9E	 AE	 AE	 AF	 BF	 BF	 C0	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 F6	 06	 06	 07	 17	 17	 18	 28	 28	 29	 39	 39	 3A	 4A	 4A	 4B	 5B	 5B	 5C	 6C	 6C	 6D	 7D	 7D	 7E	 8E	 8E	 8F	 9F	 9F	 A0	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 F8	 08	 08	 09	 19	 19	 1A	 2A	 2A	 2B	 3B	 3B	 3C	 4C	 4C	 4D	 5D	 5D	 5E	 6E	 6E	 6F	 7F	 7F	 80	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 FA	 A	 A	 B	 1B	 1B	 1C	 2C	 2C	 2D	 3D	 3D	 3E	 4E	 4E	 4F	 5F	 5F	 60	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 FC	 C	 C	 D	 1D	 1D	 1E	 2E	 2E	 2F	 3F	 3F	 40	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 FE	 E	 E	 F	 1F	 1F	 20	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00

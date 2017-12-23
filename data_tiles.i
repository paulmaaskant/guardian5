
; object tile tables
objectTiles:
.hex 91 92 81 82

.hex 89 9A 81 82
.hex 99 8A 81 82
.hex 99 9A 81 82
.hex 89 8A 81 82

.hex FD B2 81 82
.hex FD BA 81 82
.hex FD FA 81 82
.hex B9 BA 81 82
.hex B3 FA 81 82
.hex B9 FA 81 82

.hex A9 42 A9 AA

.hex 6E 6F 7E 7F


; 1 for plain grid pos
; 3 tiles for water edges
; 6 tiles for background corners
; 3 for roads
; 4 for structures
; x for animated

; 24 for objects

; metaTileTable
; 00 transparent
; 01 building roof 1 r
; 02 building roof 0 l
; 03 building base 1 r
; 04 building base 0 l
; 05 building
; 06 building
; 07 building
; 08 building
; 09 building
; 0A building
; 0B fan
; 0C fan
; 0D fan
; 0E building
; 0F building
; 10 plains 0
; 11 plains 1
; 12 plains 2
; 13 plains 0 blocked r+lu+ld
; 14 plains 0 blocked r
; 15 plains 0 blocked lu
; 16 plains 0 blocked ld
; 17 plains 0 blocked ld+lu
; 18 plains 0 blocked lu+r (canal)
; 19 plains 0 blocked ld+r (canal)
; 1A plains 1 blocked r+lu+ld
; 1B plains 1 blocked l
; 1C plains 1 blocked ru
; 1D plains 1 blocked rd
; 1E plains 1 blocked rd+ru
; 1F plains 1 blocked ru+l (canal)
; 20 plains 1 blocked rd+l (canal)
; 21 plains 2 blocked
; 22 plains 2 blocked u corner ^
; 23 plains 2 blocked d corner ^
; 24 plains 2 blocked d lu > rd
; 25 plains 2 blocked u lu > rd
; 26 plains 2 blocked u ru > ld
; 27 plains 2 blocked d corner v
; 28 plains 2 blocked u corner v
; 29 plains 2 blocked d ru > ld TODO
; 2A plains 1 full block chip lu
; 2B plains 0 full block chip ru
; 2C plains 1 full block chip ld
; 2D plains 0 full block chip rd
; 2E plains 1 blocked ru+l (pond)
; 2F plains 0 blocked lu+r (pond)


metaTileBlock00:
	.hex 63 88 07 A8 07 BC 07 9C 07 AE 07 80 07 65 8C 07
	.hex 80 07 00 85 84 83 80 83 85 84 87 87 07 07 07 97
	.hex 83 97 00 91 91 80 07 91 87 91 97 85 63 63 63 63
	.hex 87 84 63 B9 F1 65 D5 C3 BB EA FD DA D4 D6 DF BB
	.hex CB C3 00 65 DA E1 9B D4 65 F4 B9 D6 D4 FD DA C4
	.hex 65 07 00 00 EC FC D6 D4 D6 D5 CC D6 A9 DA DA D6
	.hex DD 85 A0 07 97 80 07 83 07 00 B3 B1 07 B5 B3 65

metaTileBlock01:
	.hex 64 06 8B 06 AB 06 BD 06 9D 06 AF 06 90 66 06 8D
	.hex 06 90 01 89 86 06 06 06 96 86 93 93 94 90 94 95
	.hex 06 95 01 92 92 06 90 92 93 92 95 96 66 66 66 66
	.hex 93 86 9A BA C2 D4 D6 DF 06 EB BA DB D5 D4 DA 06
	.hex DD DD 00 F0 FB C2 06 E0 66 C5 BA D4 F6 FA CC F5
	.hex 66 B8 01 01 ED DD 66 D5 66 D6 DD DA DA CB AD D4
	.hex DA 96 06 90 95 06 A5 06 94 01 B2 B2 B0 06 B4 66


metaTileBlock02:
	.hex 73 98 05 B8 05 B8 05 AD 05 BE 05 93 92 75 98 05
	.hex 90 05 02 73 94 90 93 93 94 95 05 05 05 05 05 05
	.hex 90 8A 02 86 96 90 92 96 9A 86 73 73 05 73 05 94
	.hex 73 95 73 96 DD 75 E5 FB 93 05 A1 DA E4 E6 DF 90
	.hex FB CB 00 75 05 E6 AB D2 F0 E5 02 D1 D2 02 05 E4
	.hex F2 05 02 02 A5 B8 D1 E4 D1 D0 DC DA A9 DA DA D1
	.hex DD 94 B0 05 9A A5 05 93 92 A3 02 A3 05 90 A1 75

metaTileBlock03:
	.hex 74 04 9B 04 BB 04 BB 04 AD 04 BF 91 84 76 04 9B
	.hex 04 80 03 04 04 04 04 04 04 04 85 83 80 84 84 83
	.hex 91 74 03 87 87 91 80 97 83 97 74 74 74 04 83 04
	.hex 85 74 87 87 AA E4 E6 04 91 A0 A2 DB E5 D2 AA 04
	.hex 04 DF 00 AC BB AA 04 D3 F1 E6 03 D2 D3 03 FC D0
	.hex F3 80 03 03 04 04 F2 D0 E2 D1 DD DA DA CB AD E4
	.hex DA 99 04 A0 83 04 B5 91 84 A4 03 A4 80 04 A2 76

level1:
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 48	 47	 45	 41	 3B	 60	 5A	 5D	 5C	 5A	 57	 5F	 59	 50	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 35	 36	 3C	 3D	 49	 3B	 3E	 40	 44	 12	 55	 4E	 5C	 5A	 5D	 5C	 5A	 5E	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 43	 34	 41	 3B	 3E	 40	 44	 12	 3F	 11	 12	 10	 51	 12	 54	 4E	 5C	 5A	 4F	 5F	 59	 50	 35	 36	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 48	 4C	 45	 37	 39	 12	 3F	 11	 12	 10	 11	 12	 65	 66	 12	 6D	 51	 12	 55	 4E	 5C	 5A	 4F	 5B	 5A	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 35	 36	 3C	 3D	 49	 3B	 3E	 46	 6C	 12	 62	 63	 12	 65	 66	 12	 6D	 11	 12	 10	 11	 12	 10	 51	 12	 55	 4E	 3E	 5A	 57	 5F	 59	 57	 56	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 48	 50	 00	 48	 47	 45	 41	 3B	 3E	 40	 44	 12	 3F	 1D	 23	 B	 26	 12	 62	 63	 12	 10	 11	 12	 10	 11	 12	 10	 11	 12	 10	 51	 12	 54	 4E	 5C	 5A	 5D	 3E	 00	 00	 00	 00	 00
.hex 00	 00	 3C	 3D	 49	 4F	 4B	 49	 3B	 3E	 40	 39	 12	 3F	 11	 12	 10	 1C	 12	 18	 1A	 24	 B	 26	 12	 62	 63	 12	 10	 11	 12	 10	 11	 12	 65	 66	 12	 6D	 51	 12	 55	 4E	 3E	 00	 00	 00	 00	 00
.hex 35	 36	 3B	 3E	 40	 4E	 3E	 40	 44	 12	 3F	 6C	 12	 01	 02	 12	 01	 02	 12	 10	 1C	 12	 61	 30	 24	 16	 6C	 12	 62	 63	 12	 65	 66	 12	 6D	 11	 12	 10	 11	 12	 10	 51	 12	 2F	 2C	 00	 00	 00
.hex 34	 37	 39	 12	 3F	 51	 12	 3F	 1D	 23	 16	 11	 12	 03	 04	 12	 03	 04	 12	 62	 63	 12	 14	 2C	 32	 67	 26	 12	 10	 6C	 12	 25	 26	 12	 10	 11	 12	 10	 11	 12	 10	 11	 12	 10	 1C	 12	 2F	 2C
.hex 33	 38	 26	 12	 62	 63	 12	 10	 1C	 12	 09	 08	 24	 B	 26	 12	 25	 C	 23	 B	 26	 12	 62	 1C	 12	 18	 1B	 12	 25	 C	 29	 31	 30	 24	 16	 6C	 12	 10	 11	 12	 10	 11	 12	 6D	 11	 12	 25	 68
.hex 00	 2B	 30	 24	 B	 26	 12	 62	 63	 12	 03	 06	 12	 18	 1A	 27	 19	 1F	 12	 61	 30	 24	 16	 11	 12	 25	 C	 29	 31	 2A	 00	 2D	 2E	 12	 15	 11	 12	 10	 6C	 12	 6D	 11	 12	 25	 C	 29	 31	 2A
.hex D	 D	 D	 00	 2B	 30	 24	 B	 26	 12	 62	 63	 12	 10	 1C	 12	 20	 C	 29	 19	 2E	 12	 15	 1D	 29	 31	 2A	 D	 D	 D	 32	 67	 26	 12	 10	 11	 12	 10	 11	 12	 25	 C	 29	 31	 2A	 00	 D	 D
.hex 00	 D	 D	 D	 00	 D	 00	 2B	 30	 24	 B	 26	 12	 25	 26	 12	 14	 1F	 12	 15	 66	 12	 6D	 1C	 12	 2F	 2E	 12	 2F	 2C	 D	 2B	 30	 24	 B	 26	 12	 25	 C	 29	 31	 2A	 00	 00	 D	 00	 00	 D
.hex D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 2B	 30	 27	 31	 28	 12	 62	 66	 12	 6D	 11	 12	 01	 02	 12	 10	 11	 12	 10	 1C	 12	 2F	 2C	 D	 2B	 30	 27	 31	 2A	 00	 00	 D	 00	 00	 00	 D	 00	 D
.hex 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 00	 D	 00	 00	 30	 24	 B	 26	 12	 10	 11	 12	 E	 F	 12	 10	 11	 12	 10	 11	 12	 25	 68	 D	 00	 D	 00	 D	 00	 00	 D	 00	 D	 D	 00	 00	 00	 D
.hex D	 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 D	 D	 00	 D	 00	 2B	 30	 24	 B	 26	 12	 03	 04	 12	 10	 11	 12	 25	 C	 29	 31	 2A	 00	 D	 00	 D	 00	 D	 00	 00	 00	 D	 00	 D	 00	 00	 D
.hex 00	 D	 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 D	 D	 00	 D	 D	 D	 00	 2B	 30	 24	 B	 26	 12	 25	 C	 29	 31	 2A	 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 D	 00	 00	 00	 00	 00	 00	 D
.hex D	 00	 D	 00	 D	 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 2B	 30	 27	 31	 2A	 00	 D	 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 00	 D	 00	 00	 00	 D	 D	 D	 D
.hex 00	 D	 00	 D	 D	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 00	 D	 D	 D	 D	 D	 D	 D	 D	 D


objectMap:
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 E0	 E0	 F0	 F1	 F1	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 C0	 C0	 D0	 D1	 D1	 E1	 E2	 E2	 F2	 F3	 F3	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 A0	 A0	 B0	 B1	 B1	 C1	 C2	 C2	 D2	 D3	 D3	 E3	 E4	 E4	 F4	 F5	 F5	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 80	 80	 90	 91	 91	 A1	 A2	 A2	 B2	 B3	 B3	 C3	 C4	 C4	 D4	 D5	 D5	 E5	 E6	 E6	 F6	 F7	 F7	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 60	 60	 70	 71	 71	 81	 82	 82	 92	 93	 93	 A3	 A4	 A4	 B4	 B5	 B5	 C5	 C6	 C6	 D6	 D7	 D7	 E7	 E8	 E8	 F8	 F9	 F9	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 40	 40	 50	 51	 51	 61	 62	 62	 72	 73	 73	 83	 84	 84	 94	 95	 95	 A5	 A6	 A6	 B6	 B7	 B7	 C7	 C8	 C8	 D8	 D9	 D9	 E9	 EA	 EA	 FA	 FB	 FB	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 20	 20	 30	 31	 31	 41	 42	 42	 52	 53	 53	 63	 64	 64	 74	 75	 75	 85	 86	 86	 96	 97	 97	 A7	 A8	 A8	 B8	 B9	 B9	 C9	 CA	 CA	 DA	 DB	 DB	 EB	 EC	 EC	 FC	 FD	 FD	 00	 00	 00
.hex 00	 00	 00	 10	 11	 11	 21	 22	 22	 32	 33	 33	 43	 44	 44	 54	 55	 55	 65	 66	 66	 76	 77	 77	 87	 88	 88	 98	 99	 99	 A9	 AA	 AA	 BA	 BB	 BB	 CB	 CC	 CC	 DC	 DD	 DD	 ED	 EE	 EE	 FE	 FF	 FF
.hex 00	 F1	 F1	 01	 02	 02	 12	 13	 13	 23	 24	 24	 34	 35	 35	 45	 46	 46	 56	 57	 57	 67	 68	 68	 78	 79	 79	 89	 8A	 8A	 9A	 9B	 9B	 AB	 AC	 AC	 BC	 BD	 BD	 CD	 CE	 CE	 DE	 DF	 DF	 EF	 F0	 F0
.hex 00	 00	 00	 00	 F3	 F3	 03	 04	 04	 14	 15	 15	 25	 26	 26	 36	 37	 37	 47	 48	 48	 58	 59	 59	 69	 6A	 6A	 7A	 7B	 7B	 8B	 8C	 8C	 9C	 9D	 9D	 AD	 AE	 AE	 BE	 BF	 BF	 CF	 D0	 D0	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 F5	 F5	 05	 06	 06	 16	 17	 17	 27	 28	 28	 38	 39	 39	 49	 4A	 4A	 5A	 5B	 5B	 6B	 6C	 6C	 7C	 7D	 7D	 8D	 8E	 8E	 9E	 9F	 9F	 AF	 B0	 B0	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 F7	 F7	 07	 08	 08	 18	 19	 19	 29	 2A	 2A	 3A	 3B	 3B	 4B	 4C	 4C	 5C	 5D	 5D	 6D	 6E	 6E	 7E	 7F	 7F	 8F	 90	 90	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 F9	 F9	 09	 A	 A	 1A	 1B	 1B	 2B	 2C	 2C	 3C	 3D	 3D	 4D	 4E	 4E	 5E	 5F	 5F	 6F	 70	 70	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 FB	 FB	 B	 C	 C	 1C	 1D	 1D	 2D	 2E	 2E	 3E	 3F	 3F	 4F	 50	 50	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 FD	 FD	 D	 E	 E	 1E	 1F	 1F	 2F	 30	 30	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 FF	 FF	 F	 10	 10	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00

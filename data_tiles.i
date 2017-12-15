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
	.hex 63 88 D2 A8 AA BC AA 9C D2 AE 9A 91 53 53 8C C2
	.hex 80 82 91 85 84 83 80 83 85 84 87 87 82 82 82 97
	.hex 87 97 89 91 91 99 89 91 99 91 97 85 63 63 63 63
	.hex 87 84 63 B9 F1 0F D5 C3 BB EA FD DA D4 D6 DF BB
	.hex CB C3 00 0F DA E1 9B D4 0F F4 B9 D6 D4 FD DA C4
	.hex 0F 82 B9 FD EC FC D6 D4 D6 D5 CC D6 A9 DA DA D6
	.hex DD B1 A0 A2 91 80 A4 B3 91 91 B3 B1 82 B5 B3 65

metaTileBlock01:
	.hex 64 D1 8B A9 AB A9 BD D1 9D F1 AF 92 54 54 C1 8D
	.hex 81 90 92 89 86 81 81 81 96 86 93 93 94 90 94 95
	.hex 93 95 8A 92 92 8A 9A 92 9A 92 95 96 64 64 64 64
	.hex 93 86 9A BA C2 D4 D6 DF 81 EB BA DB D5 D4 DA 81
	.hex DD DD 00 F0 FB C2 81 E0 0F C5 BA D4 F6 FA CC F5
	.hex 0F B8 FA BA ED DD 0F D5 0F D6 DD DA DA CB AD D4
	.hex DA B2 A1 90 92 A3 A5 B4 92 92 B2 B2 B0 81 B4 66


metaTileBlock02:
	.hex 73 98 42 B8 BA B8 BA AD AA BE AA 43 81 43 98 42
	.hex 90 92 81 73 94 90 93 93 94 95 8A 9A 92 92 92 9A
	.hex 8A 8A 81 86 96 81 81 96 81 86 73 73 8A 73 9A 94
	.hex 73 95 73 96 DD 0F E5 FB 93 B2 A1 DA E4 E6 DF 90
	.hex FB CB 00 0F BA E6 AB D2 F0 E5 81 D1 D2 91 FA E4
	.hex F2 92 81 81 A5 B8 D1 E4 D1 D0 DC DA A9 DA DA D1
	.hex DD 82 B0 B2 A1 A5 B4 81 A1 A3 81 A3 92 90 A1 75

metaTileBlock03:
	.hex 74 A9 9B B9 BB B9 BB A9 AD A9 BF 44 82 44 A9 9B
	.hex 91 80 82 89 99 91 91 91 99 89 85 83 80 84 84 83
	.hex 85 74 82 87 87 82 82 97 82 97 74 74 74 89 83 99
	.hex 85 74 87 87 AA E4 E6 FD 91 A0 A2 DB E5 D2 AA 91
	.hex FD DF 00 AC BB AA 91 D3 F1 E6 82 D2 D3 92 FC D0
	.hex F3 80 82 82 B3 B9 F2 D0 E2 D1 DD DA DA CB AD E4
	.hex DA 81 B1 A0 A4 B3 B5 82 A2 A4 82 A4 80 91 A2 76

level1:
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 48	 47	 45	 41	 3B	 60	 5A	 5D	 5C	 5A	 57	 5F	 59	 50	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 35	 36	 3C	 3D	 49	 3B	 3E	 40	 44	 4D	 55	 4E	 5C	 5A	 5D	 5C	 5A	 5E	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 43	 34	 41	 3B	 3E	 40	 44	 53	 3F	 11	 12	 10	 51	 52	 54	 4E	 5C	 5A	 4F	 5F	 59	 50	 35	 36	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00	 48	 4C	 45	 37	 39	 3A	 3F	 11	 12	 10	 11	 69	 65	 66	 67	 6D	 51	 52	 55	 4E	 5C	 5A	 4F	 5B	 5A	 00	 00	 00	 00	 00	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 00	 00	 00	 00	 00	 35	 36	 3C	 3D	 49	 3B	 3E	 46	 6C	 61	 62	 63	 64	 65	 66	 67	 6D	 11	 12	 10	 11	 12	 10	 51	 52	 55	 4E	 3E	 5A	 57	 5F	 59	 57	 56	 00	 00	 00	 00	 00
.hex 00	 00	 00	 00	 48	 50	 00	 48	 47	 45	 41	 3B	 3E	 40	 44	 53	 3F	 1D	 23	 16	 6C	 61	 62	 63	 68	 10	 11	 12	 10	 11	 12	 10	 11	 12	 10	 51	 52	 54	 4E	 5C	 5A	 5D	 3E	 00	 00	 00	 00	 00
.hex 00	 00	 3C	 3D	 49	 4F	 4B	 49	 3B	 3E	 40	 39	 3A	 3F	 11	 12	 10	 1C	 25	 18	 1A	 24	 16	 6C	 61	 62	 63	 68	 10	 11	 12	 10	 11	 69	 65	 66	 67	 6D	 51	 52	 55	 4E	 3E	 00	 00	 00	 00	 00
.hex 35	 36	 3B	 3E	 40	 4E	 3E	 40	 44	 53	 3F	 6C	 61	 01	 02	 68	 01	 02	 68	 10	 1C	 25	 18	 30	 24	 16	 6C	 61	 62	 63	 64	 65	 66	 67	 6D	 11	 12	 10	 11	 64	 10	 51	 4A	 2F	 2C	 00	 00	 00
.hex 34	 37	 39	 3A	 3F	 51	 4A	 3F	 1D	 23	 16	 11	 12	 03	 04	 61	 03	 04	 61	 62	 63	 12	 14	 2C	 32	 17	 11	 12	 10	 6C	 6B	 10	 11	 12	 10	 11	 64	 65	 66	 6A	 62	 63	 64	 10	 1C	 25	 2F	 2C
.hex 33	 38	 6C	 61	 62	 63	 68	 10	 1C	 25	 09	 08	 24	 16	 11	 12	 10	 1D	 23	 16	 6C	 61	 62	 1C	 25	 18	 1B	 69	 65	 1D	 29	 31	 30	 24	 16	 6C	 6A	 62	 63	 64	 65	 66	 6A	 6D	 11	 12	 10	 1E
.hex 00	 2B	 30	 24	 16	 6C	 61	 62	 63	 68	 03	 06	 25	 18	 20	 27	 19	 1F	 22	 18	 30	 24	 16	 11	 6B	 65	 1D	 29	 31	 2A	 6F	 2D	 2E	 26	 15	 11	 12	 10	 6C	 6A	 6D	 11	 12	 10	 1D	 29	 31	 2A
.hex 6F	 00	 6F	 00	 2B	 30	 24	 16	 6C	 61	 62	 63	 68	 10	 1C	 28	 15	 1D	 29	 19	 2E	 26	 15	 1D	 29	 31	 2A	 00	 6F	 00	 32	 17	 11	 12	 10	 11	 12	 10	 11	 12	 10	 1D	 29	 31	 2A	 00	 6F	 6F
.hex 00	 6F	 00	 6F	 00	 6F	 00	 2B	 30	 24	 16	 6C	 61	 62	 63	 68	 14	 1F	 26	 15	 66	 67	 6D	 1C	 25	 2F	 2E	 22	 2F	 2C	 6F	 2B	 30	 24	 16	 11	 12	 10	 1D	 29	 31	 2A	 00	 00	 6F	 00	 00	 6F
.hex 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 2B	 30	 27	 31	 1B	 61	 62	 66	 67	 6D	 11	 B	 01	 02	 B	 10	 11	 B	 10	 1C	 25	 2F	 2C	 00	 2B	 30	 27	 31	 2A	 00	 00	 00	 00	 00	 00	 00	 00	 6F
.hex 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 00	 30	 24	 16	 11	 12	 10	 11	 D	 E	 F	 D	 10	 11	 D	 10	 11	 12	 10	 1E	 00	 00	 00	 00	 00	 00	 00	 6F	 00	 6F	 00	 00	 00	 00	 6F
.hex 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 2B	 30	 24	 16	 11	 C	 03	 04	 C	 10	 11	 C	 10	 1D	 29	 31	 2A	 00	 6F	 6F	 00	 00	 00	 00	 00	 00	 6F	 00	 6F	 00	 00	 6F
.hex 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 2B	 30	 24	 16	 11	 12	 10	 1D	 29	 31	 2A	 00	 00	 00	 00	 00	 00	 00	 6F	 00	 6F	 6F	 00	 00	 00	 00	 00	 00	 6F
.hex 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 2B	 30	 27	 31	 2A	 00	 6F	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 00	 00	 00	 00	 00	 00	 00	 6F	 6F	 6F	 6F
.hex 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 00	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F	 6F

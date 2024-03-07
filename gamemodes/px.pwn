//==============================================================================
/*
						ProjectX Roleplay
						-----------------
						Skripter: Vuk
						----------------------
*/
//==============================================================================
#include <a_samp>
#include <zcmd>
#include <YSI\y_ini>
#include <sscanf2>
#include <streamer>
#include <foreach>
#include <dialogs>
//==============================================================================
#define GAME_MODE_TEXT "PX:RP v1.0"
#define TAG "PX:RP"
#define IME "ProjectX"
#define FORUM "www.nema.com"
#define TS3 "54.36.85.146:9977"
#define RCON_PASSWORD "rcon_password VuK"
//==============================================================================
#define SCM SendClientMessage
#define SCMTA SendClientMessageToAll
//==============================================================================
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
//==============================================================================
#undef MAX_PLAYERS
#define MAX_PLAYERS 150
//==============================================================================
#define plava "{06A8FF}"
#define crvena "{FF0000}"
#define zelena "{00FF00}"
#define zuta "{FFFF00}"
#define bijela "{FFFFFF}"
#define aktivnost "{BB66AA}"
#define crna "{000000}"
#define roza "{FF0080}"
#define siva "{626262}"
#define smeda "{814141}"
#define server_boja 0x06A8FFFF
//==============================================================================
#define DIALOG_LOGIN 1
#define DIALOG_REGISTER 2
#define DIALOG_GODINE 3
#define DIALOG_DRZAVA 4
#define DIALOG_MAIL 5
#define DIALOG_PROVJERA 6
#define DIALOG_PODESAVANJA 7
#define DIALOG_SPOL 8
#define DIALOG_BIZNIS 9
#define DIALOG_BIZNIS2 10
#define DIALOG_BIZNIS3 11
#define DIALOG_BIZNIS4 12
#define DIALOG_BIZNIS5 13
#define DIALOG_BIZNIS6 14
#define DIALOG_BIZNIS7 15
#define DIALOG_HELP 16
#define DIALOG_HELP2 17
#define DIALOG_MUTE_LISTA 18
#define DIALOG_JAIL_LISTA 19
#define DIALOG_TELEPORT 20
#define DIALOG_PITANJA 21
#define DIALOG_PITANJA1 22
#define DIALOG_GPS 23
#define DIALOG_STAFF_LISTA 24
#define DIALOG_BANKA 25
#define DIALOG_BANKA2 26
#define DIALOG_BANKA3 27
#define DIALOG_BANKA4 28
#define DIALOG_BANKA5 29
#define DIALOG_BANKA6 30
#define DIALOG_POSAO 31
#define DIALOG_PROMOTION 32
#define DIALOG_POSLOVI 33
#define DIALOG_PLACA 34
#define DIALOG_KUCA 35
#define DIALOG_KUCA2 36
#define DIALOG_KUCA3 37
#define DIALOG_KUCA4 38
#define DIALOG_KUCA5 39
#define DIALOG_KUCA6 40
#define DIALOG_KUCA7 41
#define DIALOG_KUCA8 42
#define DIALOG_KUCA9 43
#define DIALOG_KUCA10 44
#define DIALOG_KUCA11 45
#define DIALOG_SHOP 46
#define DIALOG_PLACANJE 47
#define DIALOG_SEX_SHOP 48
#define DIALOG_AMMUNATION 49
#define DIALOG_BINCO 50
#define DIALOG_BAR 51
#define DIALOG_PIZZA 52
#define DIALOG_VKUPOVINA 53
#define DIALOG_VKUPOVINA1 54
#define DIALOG_GEPEK 55
#define DIALOG_GEPEK1 56
#define DIALOG_GEPEK2 57
#define DIALOG_GEPEK3 58
#define DIALOG_GEPEK4 59
#define DIALOG_GEPEK5 60
#define DIALOG_GEPEK6 61
#define DIALOG_GEPEK7 62
#define DIALOG_SELLCARTO 63
#define DIALOG_VSELL 64
#define DIALOG_INFOR 65
#define DIALOG_UBACI 66
#define DIALOG_LIDERI 67
#define DIALOG_SEF 68
#define DIALOG_SEF1 69
#define DIALOG_SEF2 70
#define DIALOG_SEF3 71
#define DIALOG_SEF4 72
#define DIALOG_SEF5 73
#define DIALOG_SEF6 74
#define DIALOG_SEF7 75
#define DIALOG_PITANJA2 76
#define DIALOG_AFK_LISTA 77
#define DIALOG_SELLBIZNISTO 78
#define DIALOG_SELLKUCATO 79
#define DIALOG_SELLZLATOTO 80
#define DIALOG_SELLDROGATO 81
#define DIALOG_SELLMATSTO 82
#define DIALOG_STATS 83
#define DIALOG_PRETRESANJE 84
#define DIALOG_POLICIJA_OPREMA 85
#define DIALOG_AUTOSKOLA 86
#define DIALOG_AVOZILO 87
#define DIALOG_CNAPRAVIORUZJE 88
#define DIALOG_RENT 89
#define DIALOG_RENT1 90
#define DIALOG_RENT2 91
#define DIALOG_RENT3 92
#define DIALOG_RENT4 93
#define DIALOG_RENT5 94
#define DIALOG_RENT6 95
#define DIALOG_RENT7 96
#define DIALOG_RENT8 97
#define DIALOG_RENTCIJENA 98
#define DIALOG_INFO 99
#define DIALOG_SETTINGS 100
#define DIALOG_UCITAVANJETIME 101
#define DIALOG_TRENING 102
#define DIALOG_STAN 103
#define DIALOG_STAN2 104
#define DIALOG_STAN3 105
#define DIALOG_STAN4 106
#define DIALOG_STAN5 107
#define DIALOG_STAN6 108
#define DIALOG_STAN7 109
#define DIALOG_STAN8 110
#define DIALOG_STAN9 111
#define DIALOG_STAN10 112
#define DIALOG_STAN11 113
#define DIALOG_SELLSTANTO 114
//==============================================================================
#define KAMIONDZIJA_MAP_ICON 0
//==============================================================================
#define RUDAR_SLOT 0
#define ZAVARIVAC_SLOT 1
#define ZAVARIVAC1_SLOT 2
#define LISICE_SLOT 3
#define MOBITEL_SLOT 4
#define MARAMA_SLOT 5
//==============================================================================
//news
//register
new Text:reg[15];
new PlayerText:regp[6][MAX_PLAYERS];
//dupliexp
new bool:dupliexp;
//duty
new bool:AdminDuty[MAX_PLAYERS];
new bool:GameMasterDuty[MAX_PLAYERS];
//spectate
new	specID[MAX_PLAYERS];
new	specType[MAX_PLAYERS];
//count
new	bool:countaktiviran = false;
new	countvrijeme;
new	CountTimer;
//admin vozilo
new avozilo[MAX_PLAYERS];
//respawn
new respawn;
new bool:spawned[MAX_PLAYERS];
//banka
new BankaPickup[6];
new Text3D:BankaText[5];
new Text:BankomatTD[8];
//posao
new Opremljen[MAX_PLAYERS];
new bool:Radi[MAX_PLAYERS];
new PosaoID[MAX_PLAYERS];
//vozila
new Locked[MAX_VEHICLES]; //0-otkljucano, 1-zakljucano, 2-uvjetno
//kamiondzija
new Kamion[9];
new Prikolica[9];
new KamiondzijaCP[MAX_PLAYERS];
new KamiondzijaPrikolica[MAX_PLAYERS];
new bool:utovar;
new Float:RandomKamiondzija[][] =
{
    {2116.6125,929.9206,10.8203},
	{2639.5757,1096.7429,10.8203},
	{285.2648,1412.3536,10.4012},
	{-1451.1747,2627.2571,55.8359},
	{-2043.3115,282.2294,34.7393},
	{-2025.8109,143.2763,28.8359},
	{-2104.2344,-172.4177,35.3203}
};
new bool:trailerlocate[MAX_PLAYERS];
//farmer
#define FARMER_OBJEKT 872
new Float:FarmerObjekti[][] =
{
	{-322.66479, -1423.59521, 13.60865,   0.00000, 0.00000, 0.00000},
	{-303.92157, -1422.65015, 13.71375,   0.00000, 0.00000, 0.00000},
	{-282.56192, -1421.55688, 10.72427,   0.00000, 0.00000, 0.00000},
	{-258.66608, -1419.28174, 7.68621,   0.00000, 0.00000, 0.00000},
	{-239.19389, -1417.46094, 6.21670,   0.00000, 0.00000, 0.00000},
	{-212.22878, -1413.10400, 4.33867,   0.00000, 0.00000, 0.00000},
	{-180.58444, -1409.56494, 2.29703,   0.00000, 0.00000, 0.00000},
	{-180.47908, -1393.10449, 3.01838,   0.00000, 0.00000, 0.00000},
	{-180.47908, -1393.10449, 3.01838,   0.00000, 0.00000, 0.00000},
	{-213.31445, -1390.94934, 5.26543,   0.00000, 0.00000, 0.72135},
	{-235.61421, -1390.34424, 8.34025,   0.00000, 0.00000, 0.72135},
	{-258.03488, -1390.03564, 9.01981,   0.00000, 0.00000, 0.72135},
	{-280.16559, -1389.47876, 9.55008,   0.00000, 0.00000, 0.72135},
	{-303.58356, -1390.70740, 10.69431,   0.00000, 0.00000, 0.72135},
	{-319.17062, -1390.84973, 11.38237,   0.00000, 0.00000, 0.72135},
	{-317.54037, -1365.40857, 8.83749,   0.00000, 0.00000, 0.72135},
	{-305.20694, -1365.97400, 7.81729,   0.00000, 0.00000, 0.72135},
	{-283.82898, -1365.62585, 8.32739,   0.00000, 0.00000, 0.72135},
	{-258.10764, -1365.65771, 8.73343,   0.00000, 0.00000, 0.72135},
	{-235.32823, -1367.23535, 8.22333,   0.00000, 0.00000, 0.72135},
	{-211.05351, -1366.15527, 5.29113,   0.00000, 0.00000, 0.72135},
	{-179.40845, -1365.43225, 3.07625,   0.00000, 0.00000, 0.72135},
	{-179.61235, -1340.39771, 2.76406,   0.00000, 0.00000, 0.72135},
	{-207.19156, -1341.37390, 9.02175,   0.00000, 0.00000, 0.72135},
	{-239.12131, -1342.57922, 6.61291,   0.00000, 0.00000, 0.72135},
	{-260.75558, -1342.92737, 6.61291,   0.00000, 0.00000, 0.72135},
	{-285.32465, -1345.45398, 6.50780,   0.00000, 0.00000, 0.72135},
	{-304.13266, -1346.93469, 7.66449,   0.00000, 0.00000, 0.72135},
	{-316.98715, -1346.96545, 7.66449,   0.00000, 0.00000, 0.72135},
	{-318.31396, -1328.64160, 7.66449,   0.00000, 0.00000, 0.72135},
	{-304.19290, -1328.83545, 6.97094,   0.00000, 0.00000, 0.72135},
	{-286.42514, -1327.85706, 6.97830,   0.00000, 0.00000, 0.72135},
	{-261.79138, -1326.12366, 7.59559,   0.00000, 0.00000, 0.72135},
	{-239.54662, -1324.74963, 8.42416,   0.00000, 0.00000, 0.72135},
	{-208.09167, -1322.95386, 7.89006,   0.00000, 0.00000, 0.72135},
	{-182.01494, -1320.88892, 5.99351,   0.00000, 0.00000, 0.72135}
};
new FarmerVozilo[12];
new FarmerPrikolica[7];
new FarmerCP[MAX_PLAYERS];
new FarmerPlayer[MAX_PLAYERS][sizeof(FarmerObjekti)];
new FarmerState[MAX_PLAYERS];
//gradevinar
new GradevinarVozilo[6];
new GradevinarCP[MAX_PLAYERS];
new bool:gradevinarutovar[3];
new gradevinarobject[MAX_PLAYERS];
new gradevinarobjects[MAX_PLAYERS][3];
//rudar
new RudarCP[MAX_PLAYERS];
new RudarTimer[MAX_PLAYERS];
new Kopanje[MAX_PLAYERS];
//zavarivac
new ZavarivacPickup[4];
new Text3D:ZavarivacText[4];
new ZavarivacCP[MAX_PLAYERS];
new ZavarivacTimer[MAX_PLAYERS];
new Zavarivac[MAX_PLAYERS];
//placa
new PlacaTimer[MAX_PLAYERS];
//ig tdovi
new Text:IgTextDraws[26];
//online | rekord
new Online;
//banka i zlato
new PlayerText:BankaTD[MAX_PLAYERS];
new PlayerText:ZlatoTD[MAX_PLAYERS];
//brzinomjer
new Text:brzinomjer[8];
new PlayerText:brzinomjerp[6][MAX_PLAYERS];
new updateg[MAX_PLAYERS];
new modelvozila[MAX_PLAYERS];
new Gorivo[MAX_VEHICLES];
new gorivotimer[MAX_VEHICLES];
//vehicle ownership
new katalogid[MAX_PLAYERS];
new ktype[MAX_PLAYERS];
new Ponudio[MAX_PLAYERS];
new Slot[MAX_PLAYERS];
new Cijena[MAX_PLAYERS];
new vsell[MAX_PLAYERS];
new Text:katalog[15];
new PlayerText:katalogp[4][MAX_PLAYERS];
//connectedspawn
new bool:connectedspawn[MAX_PLAYERS];
//organizacije
new bool:PozvanUOrg[MAX_PLAYERS];
new IdOrgPozvan[MAX_PLAYERS];
//the red brigades
new TRB[8];
//the escobar cartel
new TEC[8];
//yakuza
new yakuza[12];
//lcn
new lcn[8];
//gsf
new gsf[8];
//ballas
new ballas[8];
//vagos
new vagos[10];
//artez
new artez[8];
//droga
new bool:koristidrogu[MAX_PLAYERS];
//biznis
new PonudioB[MAX_PLAYERS];
new CijenaB[MAX_PLAYERS];
//kuca
new PonudioK[MAX_PLAYERS];
new CijenaK[MAX_PLAYERS];
//zlato
new PonudioZ[MAX_PLAYERS];
new CijenaZ[MAX_PLAYERS];
new KolZ[MAX_PLAYERS];
//droga
new PonudioD[MAX_PLAYERS];
new CijenaD[MAX_PLAYERS];
new KolD[MAX_PLAYERS];
//mats
new PonudioM[MAX_PLAYERS];
new CijenaM[MAX_PLAYERS];
new KolM[MAX_PLAYERS];
//policija
new policija[21];
new pdvrata, bool:pdvratastate;
new rampa,  bool:rampastate;
new ZatvorTimer[MAX_PLAYERS];
new PolicajacKojiGaVuce[MAX_PLAYERS];
new VuceTimer[MAX_PLAYERS];
new bool:ImaLisice[MAX_PLAYERS];
new bool:PolicijaDuty[MAX_PLAYERS];
new WLTimer[MAX_PLAYERS];
new PlayerText:WlPanel[MAX_PLAYERS][5];
new bool:Tazed[MAX_PLAYERS];
new bool:Tazer[MAX_PLAYERS];
//autoskola
new polaganje[MAX_PLAYERS];
new PolaganjeVrsta[MAX_PLAYERS];
new PolaganjeVehicle[MAX_PLAYERS];
//mobitel
new Razgovara[MAX_PLAYERS];
new Zove[MAX_PLAYERS];
new MobitelCijenaRazgovora[MAX_PLAYERS];
new CallTimer[MAX_PLAYERS];
//crno trziste
new crnotrzistekapija;
new bool:crnotrzistekapijastate;
//marama
new bool:Marama[MAX_PLAYERS];
//banka pljacka
new sef, bool:sefstate;
new dinamitobject[MAX_PLAYERS];
new bankavrata, bool:bankavratastate;
new masina[4], iskre[4], bool:iskrestate[4], bool:novacpljacka[4];
new bankaresettimer;
new pljacka[MAX_PLAYERS], pljackatimer[MAX_PLAYERS];
//uze
new bool:Vezan[MAX_PLAYERS];
new IgracKojiGaVuce[MAX_PLAYERS];
new IgracVuceTimer[MAX_PLAYERS];
//weaponskills
new oldWeapons[MAX_PLAYERS][13];
new oldAmmo[MAX_PLAYERS][13];
new Trenira[MAX_PLAYERS];
new streljanaobject[MAX_PLAYERS];
new TreniraState[MAX_PLAYERS];
new bool:skill[MAX_PLAYERS];
//event system
new EventID;
new bool:EventPokrenut;
new EventObjekti[10];
new bool:InEvent[MAX_PLAYERS];
new EventKaunt[MAX_PLAYERS];
new eventcounttimer[MAX_PLAYERS];
new Float:eksplozije[][] =
{
    {5.4745,1499.4170,12.7500},
	{5.5638,1506.2715,12.7560},
	{5.6915,1512.6047,12.7560},
	{5.8227,1519.1085,12.7500},
	{5.9491,1525.3724,12.7500},
	{6.0634,1531.0350,12.7500},
	{6.1743,1536.5326,12.7500},
	{6.3084,1543.1825,12.7500},
	{6.4741,1551.3927,12.7560},
	{6.6099,1558.1276,12.7500},
	{10.5318,1559.0905,12.7500},
	{10.6469,1553.7943,12.7560},
	{10.4808,1546.6072,12.7500},
	{10.2946,1538.5511,12.7500},
	{10.1777,1530.4060,12.7500},
	{10.4917,1522.4076,12.7500},
	{10.2704,1512.8326,12.7560},
	{10.0789,1504.5461,12.7560},
	{16.4832,1498.8369,12.7500},
	{17.0501,1506.7502,12.7560},
	{17.0351,1515.5870,12.7560},
	{17.0221,1523.1862,12.7560},
	{17.0085,1531.1865,12.7500},
	{17.5072,1540.8646,12.7500},
	{17.4931,1549.1440,12.7500},
	{17.4821,1555.6147,12.7500},
	{22.2210,1558.9041,12.7560},
	{22.0795,1553.8733,12.7500},
	{21.9342,1546.9280,12.7500},
	{21.5918,1537.8655,12.7500},
	{21.7840,1528.5557,12.7500},
	{21.4376,1518.1511,12.7560},
	{21.6286,1508.8984,12.7560},
	{21.7885,1501.1515,12.7500},
	{25.4904,1498.7175,12.7500},
	{25.2917,1503.6852,12.7500},
	{25.0216,1510.4374,12.7560},
	{24.7224,1517.9170,12.7560},
	{25.1086,1526.9066,12.7560},
	{24.7748,1535.2516,12.7500},
	{24.4767,1542.7034,12.7500},
	{24.7540,1550.0299,12.7500},
	{25.0080,1556.5399,12.7560}
};
new eksplozijerandom;
new eksplozijetimer;
new bool:eksplozijestate;
new bool:eksplozijepokrenut;
//royal boys
new royalboys[9];
//stan
new PonudioS[MAX_PLAYERS];
new CijenaS[MAX_PLAYERS];
//==============================================================================
ERROR(playerid,message[])
{
	new str[150];
	format(str,sizeof(str),""plava"["TAG" ERROR] "bijela"%s",message);
	SCM(playerid,-1,str);
	return 1;
}

USAGE(playerid,message[])
{
    new str[150];
	format(str,sizeof(str),""bijela"["TAG"] "zuta"Koristi: %s",message);
	SCM(playerid,-1,str);
	return 1;
}

INFO(playerid,message[])
{
    new str[150];
	format(str,sizeof(str),""zuta"INFO: "bijela"%s",message);
	SCM(playerid,-1,str);
	return 1;
}

JOB(playerid,message[])
{
    new str[150];
	format(str,sizeof(str),""roza"[POSAO] "bijela"%s",message);
	SCM(playerid,-1,str);
	return 1;
}

AUTOSKOLA(playerid,message[])
{
    new str[150];
	format(str,sizeof(str),""zelena"[AUTOSKOLA] "bijela"%s",message);
	SCM(playerid,-1,str);
	return 1;
}

Kickaj(playerid,razlog[])
{
	new str[150];
	format(str,sizeof(str),""plava"["TAG"] "crvena"%s",razlog);
	SCM(playerid,-1,str);
	SetTimerEx("kick",1000,false,"d",playerid);
	return 1;
}

ClearChat(playerid,lines=50)
{
	for(new i=0;i<lines;i++)
	{
		SCM(playerid,-1," ");
	}
	return 1;
}
//==============================================================================
//log reg system
#define PATH "/Korisnici/%s.ini"
#define MIN_GOD 10
#define MAX_GOD 70

new bool:Ulogovan[MAX_PLAYERS];
new pwfail[MAX_PLAYERS];
//max slotova za vozila svakog igraca
#define MAX_SLOTS 3

enum pInfo  //statistika
{
	pPass,
	pMoney,
	pAdmin,
	bool:pRegistriran,
	pGodine,
	pDrzava, //0-hrvatska, 1-srbija, 2-bih, 3-ostalo
	pSpol, //1-musko, 2-zensko
	pMail[50],
    pLevel,
	pSkin,
	pBizzID,
	pUbizzu,
	pGameMaster,
	bool:pMuted,
	bool:pZatvoren,
	pVrijeme,
	bool:pBankovniRacun,
	pBankMoney,
	bool:pImaKredit,
 	pKolicinaKredita,
 	pRataKredita,
 	pRegGod,
	pRegMje,
	pRegDan,
	pRegSat,
	pRegMin,
	pRegSec,
	pPosao,
	pStaz,
	pPlaca,
	pSpawnType,
	pZlato,
	pTime,
	pEXP,
	pSatiOnline,
	pDroga,
	pMats,
	pKucaID,
	pUkuci,
	pCigarete,
	pUpaljac,
	pVozilo[MAX_SLOTS],
	pWeapon0,
	pAmmo0,
	pWeapon1,
	pAmmo1,
	pWeapon2,
	pAmmo2,
	pWeapon3,
	pAmmo3,
	pWeapon4,
	pAmmo4,
	pWeapon5,
	pAmmo5,
	pWeapon6,
	pAmmo6,
	pWeapon7,
	pAmmo7,
	pWeapon8,
	pAmmo8,
	pWeapon9,
	pAmmo9,
	pWeapon10,
	pAmmo10,
	pWeapon11,
	pAmmo11,
	pWeapon12,
	pAmmo12,
	pOrgID,
	pRank,
	pUorg,
	pPrijavio[MAX_PLAYER_NAME],
 	pZlocin[64],
 	pWL,
 	bool:pOruzjeDozvola,
 	bool:pVozackaDozvola,
 	bool:pMotorDozvola,
 	bool:pKamionDozvola,
 	bool:pBrodDozvola,
 	bool:pLetjeliceDozvola,
 	pLastIp[24],
 	bool:pMobitel,
 	bool:pMobitelUkljucen,
 	pMobilniKredit,
 	pSjemeDroge,
	pMarama,
	pDinamit,
	pVip,
    pVipTime,
    pUcitavanje,
    bool:pChatbubble,
	bool:pVipChat,
	bool:pGameMasterChat,
	bool:pAdminChat,
	bool:pGotoSlabijih,
	bool:pGetSlabijih,
	bool:pKomandeSlabijih,
	bool:pMapTeleport,
	pUze,
	pWeaponSkill[11],
	pStanID,
	pUstanu
}
new PlayerInfo[MAX_PLAYERS][pInfo];

enum regInfo
{
	pLozinka,
	pGodine,
	pDrzava,
	pSpol,
	pMail,
	pNumb
}
new RegistracijaInfo[MAX_PLAYERS][regInfo];

forward LoadUser_data(playerid,name[],value[]); //statistika
public LoadUser_data(playerid,name[],value[])
{
	INI_Int("Password",PlayerInfo[playerid][pPass]);
	INI_Int("Money",PlayerInfo[playerid][pMoney]);
	INI_Int("Admin",PlayerInfo[playerid][pAdmin]);
    INI_Bool("Registriran",PlayerInfo[playerid][pRegistriran]);
    INI_Int("Godine",PlayerInfo[playerid][pGodine]);
    INI_Int("Drzava",PlayerInfo[playerid][pDrzava]);
    INI_Int("Spol",PlayerInfo[playerid][pSpol]);
    INI_String("Mail",PlayerInfo[playerid][pMail],50);
    INI_Int("Level",PlayerInfo[playerid][pLevel]);
    INI_Int("Skin",PlayerInfo[playerid][pSkin]);
    INI_Int("BizzID",PlayerInfo[playerid][pBizzID]);
    INI_Int("Ubizzu",PlayerInfo[playerid][pUbizzu]);
    INI_Int("GameMaster",PlayerInfo[playerid][pGameMaster]);
    INI_Bool("Muted",PlayerInfo[playerid][pMuted]);
    INI_Bool("Zatvoren",PlayerInfo[playerid][pZatvoren]);
    INI_Int("Vrijeme",PlayerInfo[playerid][pVrijeme]);
    INI_Bool("BankovniRacun",PlayerInfo[playerid][pBankovniRacun]);
    INI_Int("BankMoney",PlayerInfo[playerid][pBankMoney]);
    INI_Bool("ImaKredit",PlayerInfo[playerid][pImaKredit]);
	INI_Int("KolicinaKredita",PlayerInfo[playerid][pKolicinaKredita]);
	INI_Int("RataKredita",PlayerInfo[playerid][pRataKredita]);
	INI_Int("RegGod",PlayerInfo[playerid][pRegGod]);
    INI_Int("RegMje",PlayerInfo[playerid][pRegMje]);
    INI_Int("RegDan",PlayerInfo[playerid][pRegDan]);
    INI_Int("RegSat",PlayerInfo[playerid][pRegSat]);
    INI_Int("RegMin",PlayerInfo[playerid][pRegMin]);
    INI_Int("RegSec",PlayerInfo[playerid][pRegSec]);
    INI_Int("Posao",PlayerInfo[playerid][pPosao]);
	INI_Int("Staz",PlayerInfo[playerid][pStaz]);
 	INI_Int("Placa",PlayerInfo[playerid][pPlaca]);
 	INI_Int("SpawnType",PlayerInfo[playerid][pSpawnType]);
 	INI_Int("Zlato",PlayerInfo[playerid][pZlato]);
 	INI_Int("Time",PlayerInfo[playerid][pTime]);
 	INI_Int("EXP",PlayerInfo[playerid][pEXP]);
 	INI_Int("SatiOnline",PlayerInfo[playerid][pSatiOnline]);
 	INI_Int("Droga",PlayerInfo[playerid][pDroga]);
 	INI_Int("Mats",PlayerInfo[playerid][pMats]);
 	INI_Int("KucaID",PlayerInfo[playerid][pKucaID]);
 	INI_Int("Ukuci",PlayerInfo[playerid][pUkuci]);
 	INI_Int("Cigarete",PlayerInfo[playerid][pCigarete]);
    INI_Int("Upaljac",PlayerInfo[playerid][pUpaljac]);
    for(new i=0;i<MAX_SLOTS;i++)
	{
		new str[50];
		format(str,sizeof(str),"Vozilo%d",i);
		INI_Int(str,PlayerInfo[playerid][pVozilo][i]);
	}
	INI_Int("Weapon0",PlayerInfo[playerid][pWeapon0]);
    INI_Int("Ammo0",PlayerInfo[playerid][pAmmo0]);
    INI_Int("Weapon1",PlayerInfo[playerid][pWeapon1]);
    INI_Int("Ammo1",PlayerInfo[playerid][pAmmo1]);
    INI_Int("Weapon2",PlayerInfo[playerid][pWeapon2]);
    INI_Int("Ammo2",PlayerInfo[playerid][pAmmo2]);
    INI_Int("Weapon3",PlayerInfo[playerid][pWeapon3]);
    INI_Int("Ammo3",PlayerInfo[playerid][pAmmo3]);
    INI_Int("Weapon4",PlayerInfo[playerid][pWeapon4]);
    INI_Int("Ammo4",PlayerInfo[playerid][pAmmo4]);
    INI_Int("Weapon5",PlayerInfo[playerid][pWeapon5]);
    INI_Int("Ammo5",PlayerInfo[playerid][pAmmo5]);
    INI_Int("Weapon6",PlayerInfo[playerid][pWeapon6]);
    INI_Int("Ammo6",PlayerInfo[playerid][pAmmo6]);
    INI_Int("Weapon7",PlayerInfo[playerid][pWeapon7]);
    INI_Int("Ammo7",PlayerInfo[playerid][pAmmo7]);
    INI_Int("Weapon8",PlayerInfo[playerid][pWeapon8]);
    INI_Int("Ammo8",PlayerInfo[playerid][pAmmo8]);
    INI_Int("Weapon9",PlayerInfo[playerid][pWeapon9]);
    INI_Int("Ammo9",PlayerInfo[playerid][pAmmo9]);
    INI_Int("Weapon10",PlayerInfo[playerid][pWeapon10]);
    INI_Int("Ammo10",PlayerInfo[playerid][pAmmo10]);
    INI_Int("Weapon11",PlayerInfo[playerid][pWeapon11]);
    INI_Int("Ammo11",PlayerInfo[playerid][pAmmo11]);
    INI_Int("Weapon12",PlayerInfo[playerid][pWeapon12]);
    INI_Int("Ammo12",PlayerInfo[playerid][pAmmo12]);
    INI_Int("OrgID",PlayerInfo[playerid][pOrgID]);
    INI_Int("Rank",PlayerInfo[playerid][pRank]);
    INI_Int("Uorg",PlayerInfo[playerid][pUorg]);
    INI_String("Prijavio",PlayerInfo[playerid][pPrijavio],MAX_PLAYER_NAME);
    INI_String("Zlocin",PlayerInfo[playerid][pZlocin],64);
    INI_Int("WL",PlayerInfo[playerid][pWL]);
    INI_Bool("OruzjeDozvola",PlayerInfo[playerid][pOruzjeDozvola]);
    INI_Bool("VozackaDozvola",PlayerInfo[playerid][pVozackaDozvola]);
    INI_Bool("MotorDozvola",PlayerInfo[playerid][pMotorDozvola]);
    INI_Bool("KamionDozvola",PlayerInfo[playerid][pKamionDozvola]);
    INI_Bool("BrodDozvola",PlayerInfo[playerid][pBrodDozvola]);
    INI_Bool("LetjeliceDozvola",PlayerInfo[playerid][pLetjeliceDozvola]);
    INI_String("LastIp",PlayerInfo[playerid][pLastIp],24);
    INI_Bool("Mobitel",PlayerInfo[playerid][pMobitel]);
    INI_Bool("MobitelUkljucen",PlayerInfo[playerid][pMobitelUkljucen]);
    INI_Int("MobilniKredit",PlayerInfo[playerid][pMobilniKredit]);
    INI_Int("SjemeDroge",PlayerInfo[playerid][pSjemeDroge]);
    INI_Int("Marama",PlayerInfo[playerid][pMarama]);
    INI_Int("Dinamit",PlayerInfo[playerid][pDinamit]);
    INI_Int("Vip",PlayerInfo[playerid][pVip]);
    INI_Int("VipTime",PlayerInfo[playerid][pVipTime]);
    INI_Int("Ucitavanje",PlayerInfo[playerid][pUcitavanje]);
    INI_Bool("Chatbubble",PlayerInfo[playerid][pChatbubble]);
    INI_Bool("VipChat",PlayerInfo[playerid][pVipChat]);
    INI_Bool("GameMasterChat",PlayerInfo[playerid][pGameMasterChat]);
    INI_Bool("AdminChat",PlayerInfo[playerid][pAdminChat]);
    INI_Bool("GotoSlabijih",PlayerInfo[playerid][pGotoSlabijih]);
    INI_Bool("GetSlabijih",PlayerInfo[playerid][pGetSlabijih]);
    INI_Bool("KomandeSlabijih",PlayerInfo[playerid][pKomandeSlabijih]);
    INI_Bool("MapTeleport",PlayerInfo[playerid][pMapTeleport]);
    INI_Int("Uze",PlayerInfo[playerid][pUze]);
    INI_Int("WeaponSkill0",PlayerInfo[playerid][pWeaponSkill][0]);
    INI_Int("WeaponSkill1",PlayerInfo[playerid][pWeaponSkill][1]);
    INI_Int("WeaponSkill2",PlayerInfo[playerid][pWeaponSkill][2]);
    INI_Int("WeaponSkill3",PlayerInfo[playerid][pWeaponSkill][3]);
    INI_Int("WeaponSkill4",PlayerInfo[playerid][pWeaponSkill][4]);
    INI_Int("WeaponSkill5",PlayerInfo[playerid][pWeaponSkill][5]);
    INI_Int("WeaponSkill6",PlayerInfo[playerid][pWeaponSkill][6]);
    INI_Int("WeaponSkill7",PlayerInfo[playerid][pWeaponSkill][7]);
    INI_Int("WeaponSkill8",PlayerInfo[playerid][pWeaponSkill][8]);
    INI_Int("WeaponSkill9",PlayerInfo[playerid][pWeaponSkill][9]);
    INI_Int("WeaponSkill10",PlayerInfo[playerid][pWeaponSkill][10]);
    INI_Int("StanID",PlayerInfo[playerid][pStanID]);
    INI_Int("Ustanu",PlayerInfo[playerid][pUstanu]);
	return 1;
}

GetName(playerid) { new name[MAX_PLAYER_NAME]; GetPlayerName(playerid,name,sizeof(name)); return name; }

UserPath(playerid)
{
	new str[120];
	format(str,sizeof(str),PATH,GetName(playerid));
	return str;
}

udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

SacuvajIgraca(playerid) //statistika
{
	new INI:File = INI_Open(UserPath(playerid));
	INI_SetTag(File,"data");
	INI_WriteInt(File,"Money",GetPlayerMoney(playerid));
    INI_WriteInt(File,"Admin",PlayerInfo[playerid][pAdmin]);
    INI_WriteBool(File,"Registriran",PlayerInfo[playerid][pRegistriran]);
    INI_WriteInt(File,"Godine",PlayerInfo[playerid][pGodine]);
    INI_WriteInt(File,"Drzava",PlayerInfo[playerid][pDrzava]);
    INI_WriteInt(File,"Spol",PlayerInfo[playerid][pSpol]);
    INI_WriteString(File,"Mail",PlayerInfo[playerid][pMail]);
    INI_WriteInt(File,"Level",PlayerInfo[playerid][pLevel]);
    INI_WriteInt(File,"Skin",PlayerInfo[playerid][pSkin]);
    INI_WriteInt(File,"BizzID",PlayerInfo[playerid][pBizzID]);
    INI_WriteInt(File,"Ubizzu",PlayerInfo[playerid][pUbizzu]);
    INI_WriteInt(File,"GameMaster",PlayerInfo[playerid][pGameMaster]);
    INI_WriteBool(File,"Muted",PlayerInfo[playerid][pMuted]);
    INI_WriteBool(File,"Zatvoren",PlayerInfo[playerid][pZatvoren]);
    INI_WriteInt(File,"Vrijeme",PlayerInfo[playerid][pVrijeme]);
    INI_WriteBool(File,"BankovniRacun",PlayerInfo[playerid][pBankovniRacun]);
    INI_WriteInt(File,"BankMoney",PlayerInfo[playerid][pBankMoney]);
    INI_WriteBool(File,"ImaKredit",PlayerInfo[playerid][pImaKredit]);
    INI_WriteInt(File,"KolicinaKredita",PlayerInfo[playerid][pKolicinaKredita]);
    INI_WriteInt(File,"RataKredita",PlayerInfo[playerid][pRataKredita]);
    INI_WriteInt(File,"RegGod",PlayerInfo[playerid][pRegGod]);
    INI_WriteInt(File,"RegMje",PlayerInfo[playerid][pRegMje]);
    INI_WriteInt(File,"RegDan",PlayerInfo[playerid][pRegDan]);
    INI_WriteInt(File,"RegSat",PlayerInfo[playerid][pRegSat]);
    INI_WriteInt(File,"RegMin",PlayerInfo[playerid][pRegMin]);
    INI_WriteInt(File,"RegSec",PlayerInfo[playerid][pRegSec]);
    INI_WriteInt(File,"Posao",PlayerInfo[playerid][pPosao]);
    INI_WriteInt(File,"Staz",PlayerInfo[playerid][pStaz]);
    INI_WriteInt(File,"Placa",PlayerInfo[playerid][pPlaca]);
    INI_WriteInt(File,"SpawnType",PlayerInfo[playerid][pSpawnType]);
    INI_WriteInt(File,"Zlato",PlayerInfo[playerid][pZlato]);
    INI_WriteInt(File,"Time",PlayerInfo[playerid][pTime]);
    INI_WriteInt(File,"EXP",PlayerInfo[playerid][pEXP]);
    INI_WriteInt(File,"SatiOnline",PlayerInfo[playerid][pSatiOnline]);
    INI_WriteInt(File,"Droga",PlayerInfo[playerid][pDroga]);
    INI_WriteInt(File,"Mats",PlayerInfo[playerid][pMats]);
    INI_WriteInt(File,"KucaID",PlayerInfo[playerid][pKucaID]);
    INI_WriteInt(File,"Ukuci",PlayerInfo[playerid][pUkuci]);
    INI_WriteInt(File,"Cigarete",PlayerInfo[playerid][pCigarete]);
    INI_WriteInt(File,"Upaljac",PlayerInfo[playerid][pUpaljac]);
    for(new i=0;i<MAX_SLOTS;i++)
	{
		new str[50];
		format(str,sizeof(str),"Vozilo%d",i);
		INI_WriteInt(File,str,PlayerInfo[playerid][pVozilo][i]);
	}
 	GetPlayerWeaponData(playerid, 0, PlayerInfo[playerid][pWeapon0], PlayerInfo[playerid][pAmmo0]);
    GetPlayerWeaponData(playerid, 1, PlayerInfo[playerid][pWeapon1], PlayerInfo[playerid][pAmmo1]);
    GetPlayerWeaponData(playerid, 2, PlayerInfo[playerid][pWeapon2], PlayerInfo[playerid][pAmmo2]);
    GetPlayerWeaponData(playerid, 3, PlayerInfo[playerid][pWeapon3], PlayerInfo[playerid][pAmmo3]);
    GetPlayerWeaponData(playerid, 4, PlayerInfo[playerid][pWeapon4], PlayerInfo[playerid][pAmmo4]);
    GetPlayerWeaponData(playerid, 5, PlayerInfo[playerid][pWeapon5], PlayerInfo[playerid][pAmmo5]);
    GetPlayerWeaponData(playerid, 6, PlayerInfo[playerid][pWeapon6], PlayerInfo[playerid][pAmmo6]);
    GetPlayerWeaponData(playerid, 7, PlayerInfo[playerid][pWeapon7], PlayerInfo[playerid][pAmmo7]);
    GetPlayerWeaponData(playerid, 8, PlayerInfo[playerid][pWeapon8], PlayerInfo[playerid][pAmmo8]);
    GetPlayerWeaponData(playerid, 9, PlayerInfo[playerid][pWeapon9], PlayerInfo[playerid][pAmmo9]);
    GetPlayerWeaponData(playerid, 10, PlayerInfo[playerid][pWeapon10], PlayerInfo[playerid][pAmmo10]);
    GetPlayerWeaponData(playerid, 11, PlayerInfo[playerid][pWeapon11], PlayerInfo[playerid][pAmmo11]);
    GetPlayerWeaponData(playerid, 12, PlayerInfo[playerid][pWeapon12], PlayerInfo[playerid][pAmmo12]);
    INI_WriteInt(File,"Weapon0",PlayerInfo[playerid][pWeapon0]);
    INI_WriteInt(File,"Ammo0",PlayerInfo[playerid][pAmmo0]);
    INI_WriteInt(File,"Weapon1",PlayerInfo[playerid][pWeapon1]);
    INI_WriteInt(File,"Ammo1",PlayerInfo[playerid][pAmmo1]);
    INI_WriteInt(File,"Weapon2",PlayerInfo[playerid][pWeapon2]);
    INI_WriteInt(File,"Ammo2",PlayerInfo[playerid][pAmmo2]);
    INI_WriteInt(File,"Weapon3",PlayerInfo[playerid][pWeapon3]);
    INI_WriteInt(File,"Ammo3",PlayerInfo[playerid][pAmmo3]);
    INI_WriteInt(File,"Weapon4",PlayerInfo[playerid][pWeapon4]);
    INI_WriteInt(File,"Ammo4",PlayerInfo[playerid][pAmmo4]);
    INI_WriteInt(File,"Weapon5",PlayerInfo[playerid][pWeapon5]);
    INI_WriteInt(File,"Ammo5",PlayerInfo[playerid][pAmmo5]);
    INI_WriteInt(File,"Weapon6",PlayerInfo[playerid][pWeapon6]);
    INI_WriteInt(File,"Ammo6",PlayerInfo[playerid][pAmmo6]);
    INI_WriteInt(File,"Weapon7",PlayerInfo[playerid][pWeapon7]);
    INI_WriteInt(File,"Ammo7",PlayerInfo[playerid][pAmmo7]);
    INI_WriteInt(File,"Weapon8",PlayerInfo[playerid][pWeapon8]);
    INI_WriteInt(File,"Ammo8",PlayerInfo[playerid][pAmmo8]);
    INI_WriteInt(File,"Weapon9",PlayerInfo[playerid][pWeapon9]);
    INI_WriteInt(File,"Ammo9",PlayerInfo[playerid][pAmmo9]);
    INI_WriteInt(File,"Weapon10",PlayerInfo[playerid][pWeapon10]);
    INI_WriteInt(File,"Ammo10",PlayerInfo[playerid][pAmmo10]);
    INI_WriteInt(File,"Weapon11",PlayerInfo[playerid][pWeapon11]);
    INI_WriteInt(File,"Ammo11",PlayerInfo[playerid][pAmmo11]);
    INI_WriteInt(File,"Weapon12",PlayerInfo[playerid][pWeapon12]);
    INI_WriteInt(File,"Ammo12",PlayerInfo[playerid][pAmmo12]);
    INI_WriteInt(File,"OrgID",PlayerInfo[playerid][pOrgID]);
    INI_WriteInt(File,"Rank",PlayerInfo[playerid][pRank]);
    INI_WriteInt(File,"Uorg",PlayerInfo[playerid][pUorg]);
    INI_WriteString(File,"Prijavio",PlayerInfo[playerid][pPrijavio]);
    INI_WriteString(File,"Zlocin",PlayerInfo[playerid][pZlocin]);
    INI_WriteInt(File,"WL",PlayerInfo[playerid][pWL]);
    INI_WriteBool(File,"OruzjeDozvola",PlayerInfo[playerid][pOruzjeDozvola]);
    INI_WriteBool(File,"VozackaDozvola",PlayerInfo[playerid][pVozackaDozvola]);
    INI_WriteBool(File,"MotorDozvola",PlayerInfo[playerid][pMotorDozvola]);
    INI_WriteBool(File,"KamionDozvola",PlayerInfo[playerid][pKamionDozvola]);
    INI_WriteBool(File,"BrodDozvola",PlayerInfo[playerid][pBrodDozvola]);
    INI_WriteBool(File,"LetjeliceDozvola",PlayerInfo[playerid][pLetjeliceDozvola]);
    INI_WriteString(File,"LastIp",PlayerInfo[playerid][pLastIp]);
    INI_WriteBool(File,"Mobitel",PlayerInfo[playerid][pMobitel]);
    INI_WriteBool(File,"MobitelUkljucen",PlayerInfo[playerid][pMobitelUkljucen]);
    INI_WriteInt(File,"MobilniKredit",PlayerInfo[playerid][pMobilniKredit]);
    INI_WriteInt(File,"SjemeDroge",PlayerInfo[playerid][pSjemeDroge]);
    INI_WriteInt(File,"Marama",PlayerInfo[playerid][pMarama]);
    INI_WriteInt(File,"Dinamit",PlayerInfo[playerid][pDinamit]);
    INI_WriteInt(File,"Vip",PlayerInfo[playerid][pVip]);
    INI_WriteInt(File,"VipTime",PlayerInfo[playerid][pVipTime]);
    INI_WriteInt(File,"Ucitavanje",PlayerInfo[playerid][pUcitavanje]);
    INI_WriteBool(File,"Chatbubble",PlayerInfo[playerid][pChatbubble]);
    INI_WriteBool(File,"VipChat",PlayerInfo[playerid][pVipChat]);
    INI_WriteBool(File,"GameMasterChat",PlayerInfo[playerid][pGameMasterChat]);
    INI_WriteBool(File,"AdminChat",PlayerInfo[playerid][pAdminChat]);
    INI_WriteBool(File,"GotoSlabijih",PlayerInfo[playerid][pGotoSlabijih]);
    INI_WriteBool(File,"GetSlabijih",PlayerInfo[playerid][pGetSlabijih]);
    INI_WriteBool(File,"KomandeSlabijih",PlayerInfo[playerid][pKomandeSlabijih]);
    INI_WriteBool(File,"MapTeleport",PlayerInfo[playerid][pMapTeleport]);
    INI_WriteInt(File,"Uze",PlayerInfo[playerid][pUze]);
    INI_WriteInt(File,"WeaponSkill0",PlayerInfo[playerid][pWeaponSkill][0]);
    INI_WriteInt(File,"WeaponSkill1",PlayerInfo[playerid][pWeaponSkill][1]);
    INI_WriteInt(File,"WeaponSkill2",PlayerInfo[playerid][pWeaponSkill][2]);
    INI_WriteInt(File,"WeaponSkill3",PlayerInfo[playerid][pWeaponSkill][3]);
    INI_WriteInt(File,"WeaponSkill4",PlayerInfo[playerid][pWeaponSkill][4]);
    INI_WriteInt(File,"WeaponSkill5",PlayerInfo[playerid][pWeaponSkill][5]);
    INI_WriteInt(File,"WeaponSkill6",PlayerInfo[playerid][pWeaponSkill][6]);
    INI_WriteInt(File,"WeaponSkill7",PlayerInfo[playerid][pWeaponSkill][7]);
    INI_WriteInt(File,"WeaponSkill8",PlayerInfo[playerid][pWeaponSkill][8]);
    INI_WriteInt(File,"WeaponSkill9",PlayerInfo[playerid][pWeaponSkill][9]);
    INI_WriteInt(File,"WeaponSkill10",PlayerInfo[playerid][pWeaponSkill][10]);
    INI_WriteInt(File,"StanID",PlayerInfo[playerid][pStanID]);
    INI_WriteInt(File,"Ustanu",PlayerInfo[playerid][pUstanu]);
	INI_Close(File);
	return 1;
}

ProvjeraRegistracije(playerid)
{
    if(RegistracijaInfo[playerid][pLozinka] == 1 && RegistracijaInfo[playerid][pGodine] == 1 &&
	RegistracijaInfo[playerid][pDrzava] == 1 && RegistracijaInfo[playerid][pSpol] == 1 &&
	RegistracijaInfo[playerid][pMail] == 1) return true;
	return false;
}

SetupRegistration(playerid)
{
    for(new i=0;i<sizeof(reg);i++) { TextDrawShowForPlayer(playerid,reg[i]); }
	for(new i=0;i<sizeof(regp);i++) { PlayerTextDrawShow(playerid,regp[i][playerid]); }
	RegistracijaInfo[playerid][pLozinka] = 0;
	RegistracijaInfo[playerid][pGodine] = 0;
	RegistracijaInfo[playerid][pDrzava] = 0;
	RegistracijaInfo[playerid][pSpol] = 0;
	RegistracijaInfo[playerid][pMail] = 0;
	RegistracijaInfo[playerid][pNumb] = 0;
	ClearChat(playerid);
	SelectTextDraw(playerid, 0x7F7F7FFF);
	/*SetPlayerCameraPos(playerid, 101.4395, -2111.5193, 36.7996);
	SetPlayerCameraLookAt(playerid, 101.6731, -2110.5420, 36.6797);

    SetPlayerCameraPos(playerid, 162.6619, -1841.9792, 16.9019);
	SetPlayerCameraLookAt(playerid, 163.2137, -1841.1390, 16.8970);*/
	
	InterpolateCameraPos(playerid,101.4395, -2111.5193, 36.7996, 162.6619, -1841.9792, 16.9019, 30000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, 101.6731, -2110.5420, 36.6797, 163.2137, -1841.1390, 16.8970, 30000, CAMERA_MOVE);
	return 1;
}
//==============================================================================
//postavke servera
#define SPATH "/Server/Server.ini"

enum sInfo
{
	bool:sRegistracija, 
	bool:sLogin,
    sRekord,
    bool:sBiznisPlace,
    bool:sSalon,
    bool:sSajam,
    sRentCijena,
    bool:sZauzimanjeZona,
    bool:sZonaPlace
}
new ServerInfo[sInfo];

SacuvajServer()
{
	new INI:File = INI_Open(SPATH);
	INI_SetTag(File,"data");
	INI_WriteBool(File,"Registracija",ServerInfo[sRegistracija]);
    INI_WriteBool(File,"Login",ServerInfo[sLogin]);
    INI_WriteInt(File,"Rekord",ServerInfo[sRekord]);
    INI_WriteBool(File,"BiznisPlace",ServerInfo[sBiznisPlace]);
    INI_WriteBool(File,"Salon",ServerInfo[sSalon]);
    INI_WriteBool(File,"Sajam",ServerInfo[sSajam]);
    INI_WriteInt(File,"RentCijena",ServerInfo[sRentCijena]);
    INI_WriteBool(File,"ZauzimanjeZona",ServerInfo[sZauzimanjeZona]);
    INI_WriteBool(File,"ZonaPlace",ServerInfo[sZonaPlace]);
	INI_Close(File);
	return 1;
}

forward LoadsInfo(name[],value[]);
public LoadsInfo(name[],value[])
{
	INI_Bool("Registracija",ServerInfo[sRegistracija]);
    INI_Bool("Login",ServerInfo[sLogin]);
    INI_Int("Rekord",ServerInfo[sRekord]);
    INI_Bool("BiznisPlace",ServerInfo[sBiznisPlace]);
    INI_Bool("Salon",ServerInfo[sSalon]);
    INI_Bool("Sajam",ServerInfo[sSajam]);
    INI_Int("RentCijena",ServerInfo[sRentCijena]);
    INI_Bool("ZauzimanjeZona",ServerInfo[sZauzimanjeZona]);
    INI_Bool("ZonaPlace",ServerInfo[sZonaPlace]);
	return 1;
}

LoadServer()
{
    if(fexist(SPATH)) { INI_ParseFile(SPATH, "LoadsInfo"); }
	else
	{
 		ServerInfo[sRegistracija] = true;
 		ServerInfo[sLogin] = true;
 		ServerInfo[sRekord] = 0;
 		ServerInfo[sBiznisPlace] = true;
 		ServerInfo[sSalon] = true;
 		ServerInfo[sSajam] = true;
 		ServerInfo[sRentCijena] = 1000;
 		ServerInfo[sZauzimanjeZona] = true;
 		ServerInfo[sZonaPlace] = true;
 		SacuvajServer();
	}
	print("Podesavanja servera ucitana");
}
//==============================================================================
//biznis system
#define BPATH "/Biznisi/%d.ini"
#define MAX_BIZZ 1000

enum bInfo
{
	bool:bOwned,
	bOwnerName[MAX_PLAYER_NAME],
	bLevel,
	bName[MAX_PLAYER_NAME],
	bPrice,
	Float:bUlazX,
	Float:bUlazY,
	Float:bUlazZ,
	Float:bIzlazX,
	Float:bIzlazY,
	Float:bIzlazZ,
	bUnutraPic,
	bIzvanPic,
	bVrsta,
	bVW,
	bInterior,
	bMoney,
	bool:bLocked
}
new BiznisInfo[MAX_BIZZ][bInfo];
new Text3D:bText[MAX_BIZZ];
new bool:bplaca;

forward LoadBiznis(id,name[],value[]);
public LoadBiznis(id,name[],value[])
{
	INI_Bool("Owned",BiznisInfo[id][bOwned]);
	INI_String("OwnerName",BiznisInfo[id][bOwnerName],MAX_PLAYER_NAME);
	INI_Int("Level",BiznisInfo[id][bLevel]);
	INI_String("Name",BiznisInfo[id][bName],MAX_PLAYER_NAME);
	INI_Int("Price",BiznisInfo[id][bPrice]);
	INI_Float("UlazX",BiznisInfo[id][bUlazX]);
	INI_Float("UlazY",BiznisInfo[id][bUlazY]);
	INI_Float("UlazZ",BiznisInfo[id][bUlazZ]);
	INI_Float("IzlazX",BiznisInfo[id][bIzlazX]);
	INI_Float("IzlazY",BiznisInfo[id][bIzlazY]);
	INI_Float("IzlazZ",BiznisInfo[id][bIzlazZ]);
	INI_Int("UnutraPic",BiznisInfo[id][bUnutraPic]);
	INI_Int("IzvanPic",BiznisInfo[id][bIzvanPic]);
	INI_Int("Vrsta",BiznisInfo[id][bVrsta]);
	INI_Int("VW",BiznisInfo[id][bVW]);
	INI_Int("Interior",BiznisInfo[id][bInterior]);
	INI_Int("Money",BiznisInfo[id][bMoney]);
	INI_Bool("Locked",BiznisInfo[id][bLocked]);
	return 1;
}

SacuvajBiznis(id)
{
	new str[50];
	format(str,sizeof(str),BPATH,id);
	new INI:File = INI_Open(str);
	INI_SetTag(File,"data");
	INI_WriteBool(File,"Owned",BiznisInfo[id][bOwned]);
	INI_WriteString(File,"OwnerName",BiznisInfo[id][bOwnerName]);
	INI_WriteInt(File,"Level",BiznisInfo[id][bLevel]);
	INI_WriteString(File,"Name",BiznisInfo[id][bName]);
	INI_WriteInt(File,"Price",BiznisInfo[id][bPrice]);
	INI_WriteFloat(File,"UlazX",BiznisInfo[id][bUlazX]);
	INI_WriteFloat(File,"UlazY",BiznisInfo[id][bUlazY]);
	INI_WriteFloat(File,"UlazZ",BiznisInfo[id][bUlazZ]);
	INI_WriteFloat(File,"IzlazX",BiznisInfo[id][bIzlazX]);
	INI_WriteFloat(File,"IzlazY",BiznisInfo[id][bIzlazY]);
	INI_WriteFloat(File,"IzlazZ",BiznisInfo[id][bIzlazZ]);
	INI_WriteInt(File,"UnutraPic",BiznisInfo[id][bUnutraPic]);
	INI_WriteInt(File,"IzvanPic",BiznisInfo[id][bIzvanPic]);
	INI_WriteInt(File,"Vrsta",BiznisInfo[id][bVrsta]);
	INI_WriteInt(File,"VW",BiznisInfo[id][bVW]);
	INI_WriteInt(File,"Interior",BiznisInfo[id][bInterior]);
	INI_WriteInt(File,"Money",BiznisInfo[id][bMoney]);
	INI_WriteBool(File,"Locked",BiznisInfo[id][bLocked]);
	INI_Close(File);
	return 1;
}

VrstaBiznisa(id)
{
	new str[24];
	if(BiznisInfo[id][bVrsta] == 0) str = "24/7 Shop";
	else if(BiznisInfo[id][bVrsta] == 1) str = "Motel";
	else if(BiznisInfo[id][bVrsta] == 2) str = "Sex shop";
	else if(BiznisInfo[id][bVrsta] == 3) str = "Ammunation";
	else if(BiznisInfo[id][bVrsta] == 4) str = "Kladionica";
	else if(BiznisInfo[id][bVrsta] == 5) str = "Binco";
	else if(BiznisInfo[id][bVrsta] == 6) str = "Bar";
	else if(BiznisInfo[id][bVrsta] == 7) str = "Zero shop";
	else if(BiznisInfo[id][bVrsta] == 8) str = "Disco";
	else if(BiznisInfo[id][bVrsta] == 9) str = "Picerija";
	else if(BiznisInfo[id][bVrsta] == 10) str = "Posta";
	return str;
}

BiznisLP(id)
{
	if(!BiznisInfo[id][bOwned])
	{
	    new str[200];
	    format(str,sizeof(str),""plava"Biznis na prodaju!\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\n"bijela"Vrsta: %s\n"plava"Da kupite biznis upisite "bijela"'/kupibiznis'",BiznisInfo[id][bName],BiznisInfo[id][bLevel],BiznisInfo[id][bPrice],VrstaBiznisa(id));
        Update3DTextLabelText(bText[id], -1, str);
	}
	else if(BiznisInfo[id][bOwned])
	{
	    new str[200];
	    format(str,sizeof(str),""bijela"Vlasnik: "plava"%s\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\n"bijela"Vrsta: %s",BiznisInfo[id][bOwnerName],BiznisInfo[id][bName],BiznisInfo[id][bLevel],BiznisInfo[id][bPrice],VrstaBiznisa(id));
		Update3DTextLabelText(bText[id], -1, str);
	}
	return 1;
}
LoadBizz()
{
	static x;
	for(new i=0;i<MAX_BIZZ;i++)
	{
	    new str1[20];
	    format(str1,sizeof(str1),BPATH,i);
 		INI_ParseFile(str1,"LoadBiznis",.bExtra = true,.extra = i);
	    if(fexist(str1))
	    {
			if(!BiznisInfo[i][bOwned])
			{
			    new str[200];
			    format(str,sizeof(str),""plava"Biznis na prodaju!\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\n"bijela"Vrsta: %s\n"plava"Da kupite biznis upisite "bijela"'/kupibiznis'",BiznisInfo[i][bName],BiznisInfo[i][bLevel],BiznisInfo[i][bPrice],VrstaBiznisa(i));
				bText[i] = Create3DTextLabel(str, -1, BiznisInfo[i][bUlazX], BiznisInfo[i][bUlazY], BiznisInfo[i][bUlazZ], 20.0, 0, 0);
			}
			else if(BiznisInfo[i][bOwned])
			{
			    new str[200];
			    format(str,sizeof(str),""bijela"Vlasnik: "plava"%s\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\n"bijela"Vrsta: %s",BiznisInfo[i][bOwnerName],BiznisInfo[i][bName],BiznisInfo[i][bLevel],BiznisInfo[i][bPrice],VrstaBiznisa(i));
				bText[i] = Create3DTextLabel(str, -1, BiznisInfo[i][bUlazX], BiznisInfo[i][bUlazY], BiznisInfo[i][bUlazZ], 20.0, 0, 0);
			}
			BiznisInfo[i][bVW] = i;
	  		BiznisInfo[i][bUnutraPic] = CreateDynamicPickup(1239, 1, BiznisInfo[i][bIzlazX], BiznisInfo[i][bIzlazY], BiznisInfo[i][bIzlazZ], BiznisInfo[i][bVW]);
			BiznisInfo[i][bIzvanPic] = CreateDynamicPickup(1272, 1, BiznisInfo[i][bUlazX], BiznisInfo[i][bUlazY], BiznisInfo[i][bUlazZ], 0);
			x++;
		}
	}
	printf("Ucitano %d biznisa!",x);
	return 1;
}

GetBiznis(playerid)
{
	for(new i=0;i<MAX_BIZZ;i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid,2.0,BiznisInfo[i][bUlazX], BiznisInfo[i][bUlazY], BiznisInfo[i][bUlazZ])) return i;
	}
	return -1;
}

RemoveUnderLine(name[MAX_PLAYER_NAME])
{
	  for(new i; i < MAX_PLAYER_NAME; i++)
	  {
	    	if(name[i] == '_') name[i] = ' ';
	  }
	  return name;
}

SacuvajSveBiznise()
{
    for(new i=0;i<MAX_BIZZ;i++)
	{
	    new str1[20];
	    format(str1,sizeof(str1),BPATH,i);
	    if(fexist(str1))
	    {
	        SacuvajBiznis(i);
		}
	}
	return 1;
}

#define SHOP 0
#define MOTEL 1
#define SEX_SHOP 2
#define AMMUNATION 3
#define KLADIONICA 4
#define BINCO 5
#define BAR 6
#define ZERO 7
#define DISCO 8
#define PIZZA 9
#define POSTA 10

BiznisNovac(id, money)
{
	if(money < 0 || money > 99999999) return 1;
	BiznisInfo[id][bMoney] += money;
    SacuvajBiznis(id);
	return 1;
}
//==============================================================================
//teleport system
#define TPATH "/Teleporti/%d.ini"
#define MAX_TELEPORTS 30
enum tInfo
{
	tName[MAX_PLAYER_NAME],
	Float:tX,
	Float:tY,
	Float:tZ,
	Float:tAZ,
	tInt,
	tVW
}
new TeleportInfo[MAX_TELEPORTS][tInfo];

forward LoadTeleport(id,name[],value[]);
public LoadTeleport(id,name[],value[])
{
	INI_String("Name",TeleportInfo[id][tName],MAX_PLAYER_NAME);
	INI_Float("X",TeleportInfo[id][tX]);
	INI_Float("Y",TeleportInfo[id][tY]);
	INI_Float("Z",TeleportInfo[id][tZ]);
	INI_Float("AZ",TeleportInfo[id][tAZ]);
	INI_Int("Interior",TeleportInfo[id][tInt]);
	INI_Int("VW",TeleportInfo[id][tVW]);
	return 1;
}

stock SacuvajTeleport(id)
{
	new str[50];
	format(str,sizeof(str),TPATH,id);
	new INI:File = INI_Open(str);
	INI_SetTag(File,"data");
	INI_WriteString(File,"Name",TeleportInfo[id][tName]);
	INI_WriteFloat(File,"X",TeleportInfo[id][tX]);
	INI_WriteFloat(File,"Y",TeleportInfo[id][tY]);
	INI_WriteFloat(File,"Z",TeleportInfo[id][tZ]);
	INI_WriteFloat(File,"AZ",TeleportInfo[id][tAZ]);
	INI_WriteInt(File,"Interior",TeleportInfo[id][tInt]);
	INI_WriteInt(File,"VW",TeleportInfo[id][tVW]);
	INI_Close(File);
	return 1;
}
//==============================================================================
//pitanja system
#define MAX_PITANJA 20

enum aaInfo
{
	bool:aUse,
	aPostavio[24],
	aPitanje[50],
	aPostavioID
}
new AskInfo[MAX_PITANJA][aaInfo];

new Pitanja[MAX_PLAYERS];
//==============================================================================
//gps system
#define GPATH "/Gps/%d.ini"
#define MAX_GPS 30

enum gInfo
{
	tName[MAX_PLAYER_NAME],
	Float:tX,
	Float:tY,
	Float:tZ
}
new GpsInfo[MAX_GPS][gInfo];
new bool:GPSON[MAX_PLAYERS];

forward LoadGps(id,name[],value[]);
public LoadGps(id,name[],value[])
{
	INI_String("Name",GpsInfo[id][tName],MAX_PLAYER_NAME);
	INI_Float("X",GpsInfo[id][tX]);
	INI_Float("Y",GpsInfo[id][tY]);
	INI_Float("Z",GpsInfo[id][tZ]);
	return 1;
}

stock SacuvajGps(id)
{
	new str[50];
	format(str,sizeof(str),GPATH,id);
	new INI:File = INI_Open(str);
	INI_SetTag(File,"data");
	INI_WriteString(File,"Name",GpsInfo[id][tName]);
	INI_WriteFloat(File,"X",GpsInfo[id][tX]);
	INI_WriteFloat(File,"Y",GpsInfo[id][tY]);
	INI_WriteFloat(File,"Z",GpsInfo[id][tZ]);
	INI_Close(File);
	return 1;
}
//==============================================================================
//bankomat system
#define BANKOMAT_OBJEKT 2942
#define BANKOMATPATH "Bankomati/%d.ini"
#define MAX_BANKOMATA 50
enum bankomatInfo
{
    bool:bUse,
    Float:bX,
    Float:bY,
    Float:bZ,
    Float:bXX,
    Float:bYY,
    Float:bZZ,
    bInt,
    bVW,
    bObjekt,
    Text3D:bBankomatLabel
}
new BankomatInfo[MAX_BANKOMATA][bankomatInfo];
new EditujeBankomat[MAX_PLAYERS];

forward LoadBankomat(id,  name[], value[]);
public LoadBankomat(id, name[], value[])
{
	INI_Bool("Postavljen",BankomatInfo[id][bUse]);
	INI_Float("X",BankomatInfo[id][bX]);
    INI_Float("Y",BankomatInfo[id][bY]);
    INI_Float("Z",BankomatInfo[id][bZ]);
    INI_Float("XX",BankomatInfo[id][bXX]);
    INI_Float("YY",BankomatInfo[id][bYY]);
    INI_Float("ZZ",BankomatInfo[id][bZZ]);
    INI_Int("Int",BankomatInfo[id][bInt]);
    INI_Int("VW",BankomatInfo[id][bVW]);
	return 1;
}

SacuvajBankomat(id)
{
	new str[80];
    format(str, sizeof(str), BANKOMATPATH, id);
	new INI:File = INI_Open(str);
	INI_WriteBool(File,"Postavljen",BankomatInfo[id][bUse]);
    INI_WriteFloat(File,"X",BankomatInfo[id][bX]);
    INI_WriteFloat(File,"Y",BankomatInfo[id][bY]);
    INI_WriteFloat(File,"Z",BankomatInfo[id][bZ]);
    INI_WriteFloat(File,"XX",BankomatInfo[id][bXX]);
    INI_WriteFloat(File,"YY",BankomatInfo[id][bYY]);
    INI_WriteFloat(File,"ZZ",BankomatInfo[id][bZZ]);
    INI_WriteInt(File,"Int",BankomatInfo[id][bInt]);
    INI_WriteInt(File,"VW",BankomatInfo[id][bVW]);
	INI_Close(File);
	return 1;
}

KreirajBankomat(id)
{
	if(BankomatInfo[id][bUse])
	{
 		new str[150];
 		format(str, sizeof(str), ""zelena"[BANKOMAT]\n\n"bijela"Da podignete novac upisite '"zelena"/bankomat"bijela"'");
		BankomatInfo[id][bBankomatLabel] = Create3DTextLabel(str ,0x33CCFFAA, BankomatInfo[id][bX], BankomatInfo[id][bY], BankomatInfo[id][bZ],25.0,BankomatInfo[id][bVW],0);
		BankomatInfo[id][bObjekt] = CreateDynamicObject(BANKOMAT_OBJEKT, BankomatInfo[id][bX], BankomatInfo[id][bY], BankomatInfo[id][bZ], BankomatInfo[id][bXX], BankomatInfo[id][bYY], BankomatInfo[id][bZZ], BankomatInfo[id][bVW], BankomatInfo[id][bInt], -1, 200.0);
	}
	return 1;
}

LoadBankomate()
{
	static x;
	for(new i = 0; i < sizeof(BankomatInfo); i++)
    {
        new str[50];
        format(str, sizeof(str), BANKOMATPATH, i);
        if(fexist(str))
        {
 			INI_ParseFile(str, "LoadBankomat", .bExtra = true, .extra = i);
			KreirajBankomat(i);
			x++;
		}
	}
	printf("Ucitano %d bankomata!",x);
	return 1;
}

GetBankomatID(playerid)
{
	for(new i=0; i<MAX_BANKOMATA; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, BankomatInfo[i][bX], BankomatInfo[i][bY], BankomatInfo[i][bZ])) return i;
	}
	return -1;
}

SacuvajSveBankomate()
{
    for(new i = 0; i < sizeof(BankomatInfo); i++)
    {
        new str[50];
        format(str, sizeof(str), BANKOMATPATH, i);
        if(fexist(str))
        {
			SacuvajBankomat(i);
		}
	}
}
//==============================================================================
//posao system
#define MAX_JOBS 5

#define KAMIONDZIJA 0
#define FARMER 1
#define GRADEVINAR 2
#define RUDAR 3
#define ZAVARIVAC 4

enum jInfo
{
	jName[24],
	Float:jX,
	Float:jY,
	Float:jZ,
	Float:jOpX,
	Float:jOpY,
	Float:jOpZ,
	jLevel,
	jPlaca,
	jSkin,
	jPickup,
	jUgovor
}

new JobInfo[MAX_JOBS][jInfo] =
{
	{"Kamiondzija",2431.4617,-2122.2654,13.5469,2427.4802,-2123.6934,13.5469,1,10000,182,1210,5},
	{"Farmer",-382.9745,-1427.6287,26.3185,-382.9776,-1424.8745,26.3192,2,12000,34,1210,10},
	{"Gradevinar",1275.5698,-1351.7029,13.2309,1272.4816,-1361.9263,13.2309,4,11000,27,1210,8},
	{"Rudar",587.9897,870.7243,-44.1975,579.9888,870.3409,-43.7350,7,500,260,1210,10},
	{"Zavarivac",1286.3022,-1378.6188,13.2329,1288.8845,-1378.2621,13.2329,10,4500,8,1210,12}
};
new JobPickup[MAX_JOBS];
new Text3D:JobLabel[MAX_JOBS];

new JobOpremaPickup[MAX_JOBS];
new Text3D:JobOpremaLabel[MAX_JOBS];

KreirajPoslove()
{
	static x;
	for(new i=0;i<MAX_JOBS;i++)
	{
	    new str[150];
	    format(str,sizeof(str),""roza"[ "bijela"%s "roza"]\n"bijela"Da se zaposlite pritisnite '"roza"N"bijela"'!",JobInfo[i][jName]);
		JobPickup[i] = CreateDynamicPickup(JobInfo[i][jPickup], 1, JobInfo[i][jX],JobInfo[i][jY],JobInfo[i][jZ], 0);
    	JobLabel[i] = Create3DTextLabel(str, -1, JobInfo[i][jX],JobInfo[i][jY],JobInfo[i][jZ] , 20.0, 0, 0);

		format(str,sizeof(str),""roza"[ "bijela"%s "roza"]\n"bijela"Da uzmete opremu upisite '"roza"/oprema"bijela"'!",JobInfo[i][jName]);
        JobOpremaPickup[i] = CreateDynamicPickup(1275, 1, JobInfo[i][jOpX],JobInfo[i][jOpY],JobInfo[i][jOpZ], 0);
    	JobOpremaLabel[i] = Create3DTextLabel(str, -1, JobInfo[i][jOpX],JobInfo[i][jOpY],JobInfo[i][jOpZ] , 20.0, 0, 0);
		x++;
	}
	printf("Kreirano %d poslova!",x);
	return 1;
}
//==============================================================================
//kuca system
#define KPATH "/Kuce/%d.ini"
#define MAX_KUCA 1000

enum kInfo
{
	bool:kOwned,
	kOwnerName[MAX_PLAYER_NAME],
	kLevel,
	kName[MAX_PLAYER_NAME],
	kPrice,
	Float:kUlazX,
	Float:kUlazY,
	Float:kUlazZ,
	Float:kIzlazX,
	Float:kIzlazY,
	Float:kIzlazZ,
	kUnutraPic,
	kIzvanPic,
	kVrsta,
	kVW,
	kInterior,
	kMoney,
	bool:kLocked,
	kOruzje[3],
	kMunicija[3],
	kDroga,
	kMats
}
new KucaInfo[MAX_KUCA][kInfo];
new Text3D:kText[MAX_KUCA];

forward LoadKuca(id,name[],value[]);
public LoadKuca(id,name[],value[])
{
	INI_Bool("Owned",KucaInfo[id][kOwned]);
	INI_String("OwnerName",KucaInfo[id][kOwnerName],MAX_PLAYER_NAME);
	INI_Int("Level",KucaInfo[id][kLevel]);
	INI_String("Name",KucaInfo[id][kName],MAX_PLAYER_NAME);
	INI_Int("Price",KucaInfo[id][kPrice]);
	INI_Float("UlazX",KucaInfo[id][kUlazX]);
	INI_Float("UlazY",KucaInfo[id][kUlazY]);
	INI_Float("UlazZ",KucaInfo[id][kUlazZ]);
	INI_Float("IzlazX",KucaInfo[id][kIzlazX]);
	INI_Float("IzlazY",KucaInfo[id][kIzlazY]);
	INI_Float("IzlazZ",KucaInfo[id][kIzlazZ]);
	INI_Int("UnutraPic",KucaInfo[id][kUnutraPic]);
	INI_Int("IzvanPic",KucaInfo[id][kIzvanPic]);
	INI_Int("Vrsta",KucaInfo[id][kVrsta]);
	INI_Int("VW",KucaInfo[id][kVW]);
	INI_Int("Interior",KucaInfo[id][kInterior]);
	INI_Int("Money",KucaInfo[id][kMoney]);
	INI_Bool("Locked",KucaInfo[id][kLocked]);
	INI_Int("Oruzje1",KucaInfo[id][kOruzje][0]);
	INI_Int("Municija1",KucaInfo[id][kMunicija][0]);
	INI_Int("Oruzje2",KucaInfo[id][kOruzje][1]);
	INI_Int("Municija2",KucaInfo[id][kMunicija][1]);
	INI_Int("Oruzje3",KucaInfo[id][kOruzje][2]);
	INI_Int("Municija3",KucaInfo[id][kMunicija][2]);
	INI_Int("Droga",KucaInfo[id][kDroga]);
	INI_Int("Mats",KucaInfo[id][kMats]);
	return 1;
}

SacuvajKucu(id)
{
	new str[50];
	format(str,sizeof(str),KPATH,id);
	new INI:File = INI_Open(str);
	INI_SetTag(File,"data");
	INI_WriteBool(File,"Owned",KucaInfo[id][kOwned]);
	INI_WriteString(File,"OwnerName",KucaInfo[id][kOwnerName]);
	INI_WriteInt(File,"Level",KucaInfo[id][kLevel]);
	INI_WriteString(File,"Name",KucaInfo[id][kName]);
	INI_WriteInt(File,"Price",KucaInfo[id][kPrice]);
	INI_WriteFloat(File,"UlazX",KucaInfo[id][kUlazX]);
	INI_WriteFloat(File,"UlazY",KucaInfo[id][kUlazY]);
	INI_WriteFloat(File,"UlazZ",KucaInfo[id][kUlazZ]);
	INI_WriteFloat(File,"IzlazX",KucaInfo[id][kIzlazX]);
	INI_WriteFloat(File,"IzlazY",KucaInfo[id][kIzlazY]);
	INI_WriteFloat(File,"IzlazZ",KucaInfo[id][kIzlazZ]);
	INI_WriteInt(File,"UnutraPic",KucaInfo[id][kUnutraPic]);
	INI_WriteInt(File,"IzvanPic",KucaInfo[id][kIzvanPic]);
	INI_WriteInt(File,"Vrsta",KucaInfo[id][kVrsta]);
	INI_WriteInt(File,"VW",KucaInfo[id][kVW]);
	INI_WriteInt(File,"Interior",KucaInfo[id][kInterior]);
	INI_WriteInt(File,"Money",KucaInfo[id][kMoney]);
	INI_WriteBool(File,"Locked",KucaInfo[id][kLocked]);
	INI_WriteInt(File,"Oruzje1",KucaInfo[id][kOruzje][0]);
	INI_WriteInt(File,"Municija1",KucaInfo[id][kMunicija][0]);
	INI_WriteInt(File,"Oruzje2",KucaInfo[id][kOruzje][1]);
	INI_WriteInt(File,"Municija2",KucaInfo[id][kMunicija][1]);
	INI_WriteInt(File,"Oruzje3",KucaInfo[id][kOruzje][2]);
	INI_WriteInt(File,"Municija3",KucaInfo[id][kMunicija][2]);
	INI_WriteInt(File,"Droga",KucaInfo[id][kDroga]);
	INI_WriteInt(File,"Mats",KucaInfo[id][kMats]);
	INI_Close(File);
	return 1;
}

VrstaKuce(id)
{
	new str[24];
	if(KucaInfo[id][kVrsta] == 0) str = "Mala kuca";
	else if(KucaInfo[id][kVrsta] == 1) str = "Srednja kuca";
	else if(KucaInfo[id][kVrsta] == 2) str = "Velika kuca";
	else if(KucaInfo[id][kVrsta] == 3) str = "Villa";
	return str;
}

KucaLP(id)
{
	if(!KucaInfo[id][kOwned])
	{
	    new str[200];
	    format(str,sizeof(str),""zelena"Kuca na prodaju!\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\n"bijela"Vrsta: %s\n"zelena"Da kupite kucu upisite "bijela"'/kupikucu'",KucaInfo[id][kName],KucaInfo[id][kLevel],KucaInfo[id][kPrice],VrstaKuce(id));
        Update3DTextLabelText(kText[id], -1, str);
	}
	else if(KucaInfo[id][kOwned])
	{
	    new str[200];
	    format(str,sizeof(str),""bijela"Vlasnik: "plava"%s\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\nVrsta: %s",KucaInfo[id][kOwnerName],KucaInfo[id][kName],KucaInfo[id][kLevel],KucaInfo[id][kPrice],VrstaKuce(id));
		Update3DTextLabelText(kText[id], -1, str);
	}
	return 1;
}

LoadKuce()
{
	static x;
	for(new i=0;i<MAX_KUCA;i++)
	{
	    new str1[20];
	    format(str1,sizeof(str1),KPATH,i);
 		INI_ParseFile(str1,"LoadKuca",.bExtra = true,.extra = i);
	    if(fexist(str1))
	    {
			if(!KucaInfo[i][kOwned])
			{
			    new str[200];
			    format(str,sizeof(str),""zelena"Kuca na prodaju!\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\nVrsta: %s\n"zelena"Da kupite kucu upisite "bijela"'/kupikucu'",KucaInfo[i][kName],KucaInfo[i][kLevel],KucaInfo[i][kPrice],VrstaKuce(i));
				kText[i] = Create3DTextLabel(str, -1, KucaInfo[i][kUlazX], KucaInfo[i][kUlazY], KucaInfo[i][kUlazZ], 20.0, 0, 0);
			}
			else if(KucaInfo[i][kOwned])
			{
			    new str[200];
			    format(str,sizeof(str),""bijela"Vlasnik: "plava"%s\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\nVrsta: %s",KucaInfo[i][kOwnerName],KucaInfo[i][kName],KucaInfo[i][kLevel],KucaInfo[i][kPrice],VrstaKuce(i));
				kText[i] = Create3DTextLabel(str, -1, KucaInfo[i][kUlazX], KucaInfo[i][kUlazY], KucaInfo[i][kUlazZ], 20.0, 0, 0);
			}
			KucaInfo[i][kVW] = i;
	  		KucaInfo[i][kUnutraPic] = CreateDynamicPickup(1239, 1, KucaInfo[i][kIzlazX], KucaInfo[i][kIzlazY], KucaInfo[i][kIzlazZ], KucaInfo[i][kVW]);
			KucaInfo[i][kIzvanPic] = CreateDynamicPickup(1273, 1, KucaInfo[i][kUlazX], KucaInfo[i][kUlazY], KucaInfo[i][kUlazZ], 0);
			x++;
		}
	}
	printf("Ucitano %d kuca!",x);
	return 1;
}

GetKuca(playerid)
{
	for(new i=0;i<MAX_KUCA;i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid,2.0,KucaInfo[i][kUlazX], KucaInfo[i][kUlazY], KucaInfo[i][kUlazZ])) return i;
	}
	return -1;
}

SacuvajSveKuce()
{
    for(new i=0;i<MAX_KUCA;i++)
	{
	    new str1[20];
	    format(str1,sizeof(str1),KPATH,i);
	    if(fexist(str1))
	    {
	        SacuvajKucu(i);
		}
	}
	return 1;
}
//==============================================================================
//shop info
enum ssInfo
{
	sName[24],
	sPrice
}

new ShopInfo[][ssInfo] =
{
	{"Mobitel",5000},
	{"Upaljac",500},
	{"Cigarete",1500},
	{"Dopuna od 100$",150},
	{"Uze",10000},
	{"Pivo",300},
	{"Cvijece",200},
	{"Marama",5000}
};
//==============================================================================
//binco system
enum skinInfo
{
	sID,
	sPrice
}

new SkinInfo[][skinInfo] =
{
	{1,1000}, {2,1000}, {3,1500}, {4,1000}, {5,1000}, {6,1000}, {7,1500}, {9,1000}, {10,1000},
	{12,1500}, {13,1000}, {14,1000}, {15,1000}, {18,1000}, {19,1500}, {20,1500}, {21,4000},
	{22,1000}, {23,1000}, {26,5000}, {28,5000}, {29,50000}, {30,1000}, {37,1600}, {40,7000},
	{41,10}, {45,10}, {48,15}, {55,20}, {56,18}, {59,40}, {60,30}, {65,25},
	{73,1000}, {76,5000}, {78,500}, {79,500}, {82,4000}, {83,4000}, {93,4000}, {96,1500},
	{98,1000}, {100,10000}, {101,1500}, {107,10000}, {120,45000}, {122,4500}, {124,10000}, {185,10000},
	{186,1000}, {192,1000}, {193,1000}, {195,1000}, {291,1000}, {294,49000}, {299,6000}
};
//==============================================================================
//placanje system
enum plInfo
{
	pBiznisID,
	pPrice
}
new PlacanjeInfo[MAX_PLAYERS][plInfo];

Placanje(playerid,biznisid,price)
{
	PlacanjeInfo[playerid][pBiznisID] = biznisid;
	PlacanjeInfo[playerid][pPrice] = price;
	ShowPlayerDialog(playerid,DIALOG_PLACANJE,DIALOG_STYLE_MSGBOX,""siva""IME" - Placanje",""bijela"Izaberite nacin placanja:\n"zuta"'ENTER'"bijela" za placanje bankovnom karticom.\n"zuta"'ESC'"bijela" za pljacanje gotovinom.","Karticom","Gotovinom");
	return 1;
}
//==============================================================================
//random poruke system
new Poruke[][] =
{
	{"Trebate pomoc? Upisite /askq!"},
	{"Izgubili ste se? Upisite /gps!"},
	{"Ne znate komandu? Upisite /help!"},
	{"Trebate admina ili gamemastera? Upisite /pitaj!"},
	{"Nemate prijevoz? Uzmite rent!"},
	{"Za ulazak u organizaciju je potreban level 2!"},
	{"Da uredite svoje postavke upisite /settings!"}
};
new Poruka = 0;
UpdatePoruke()
{
	Poruka++;
	if(Poruka >= sizeof(Poruke)) { Poruka=0; }
    new str12[200];
	format(str12,sizeof(str12),"%s",Poruke[Poruka][0]);
	TextDrawSetString(IgTextDraws[17],str12);
	return 1;
}
//==============================================================================
//benzin system
#define BENZIN 0
#define DIZEL 1
#define EUROSUPER 2
#define NEMA 3

#define MAX_MODELS 213

#define BENZIN_PRICE 25
#define DIZEL_PRICE 20
#define EUROSUPER_PRICE 50

enum benzInfo
{
	bID, //model vozila
	bMax, //max litara
	bTrosi, //koliko litara trosi
	bMin, //kada mu oduzime litara sa bTrosi
	bType //vrsta goriva
}

new BenzinInfo[MAX_MODELS][benzInfo] =
{
	{400,120,5,3,BENZIN},
	{401,70,7,3,BENZIN},
	{402,100,6,3,EUROSUPER},
	{403,1000,12,3,BENZIN},
	{404,70,5,3,BENZIN},
	{405,100,6,3,BENZIN},
	{406,5000,20,3,DIZEL},
	{407,150,5,4,DIZEL},
	{408,500,8,3,BENZIN},
	{409,120,5,3,DIZEL},
	{410,70,3,3,DIZEL},
	{411,120,6,3,EUROSUPER},
	{412,80,7,3,BENZIN},
	{413,100,8,3,BENZIN},
	{414,200,7,3,BENZIN},
	{415,120,6,3,EUROSUPER},
	{416,500,6,3,DIZEL},
	{417,3000,25,3,DIZEL},
	{418,100,3,3,DIZEL},
	{419,120,10,3,BENZIN},
	{420,100,5,3,DIZEL},
	{421,100,6,3,BENZIN},
	{422,70,3,3,BENZIN},
	{423,400,7,3,BENZIN},
	{424,100,5,3,EUROSUPER},
	{425,2000,20,3,DIZEL},
	{426,100,5,3,DIZEL},
	{427,500,7,3,DIZEL},
	{428,700,8,3,DIZEL},
	{429,120,6,3,EUROSUPER},
	{430,1500,30,3,DIZEL},
	{431,1000,9,3,DIZEL},
	{432,5000,50,3,DIZEL},
	{433,1000,17,3,DIZEL},
	{434,120,7,3,BENZIN},
	{435,0,0,0,NEMA},
	{436,70,4,3,DIZEL},
	{437,1000,9,3,BENZIN},
	{438,100,7,3,BENZIN},
	{439,80,6,3,DIZEL},
	{440,150,7,3,BENZIN},
	{441,0,0,0,NEMA},
	{442,120,7,3,BENZIN},
	{443,400,9,5,DIZEL},
    {444,600,15,3,DIZEL},
    {445,120,3,3,DIZEL},
    {446,800,6,3,DIZEL},
    {447,2000,20,3,DIZEL},
    {448,40,1,2},
    {449,0,0,0,NEMA},
    {450,0,0,0,NEMA},
    {451,120,6,3,EUROSUPER},
    {452,800,9,3,DIZEL},
    {453,500,9,3,DIZEL},
    {454,1000,12,3,DIZEL},
    {455,500,10,3,BENZIN},
    {456,500,9,3,BENZIN},
    {457,50,1,3,DIZEL},
    {458,100,6,3,DIZEL},
    {459,200,8,3,BENZIN},
    {460,2000,20,3,DIZEL},
    {461,50,2,3,BENZIN},
    {462,40,1,2,BENZIN},
    {463,50,2,3,BENZIN},
    {464,0,0,0,NEMA},
    {465,0,0,0,NEMA},
    {466,100,7,3,BENZIN},
    {467,100,8,3,BENZIN},
    {468,50,2,3,BENZIN},
    {469,2000,20,3,DIZEL},
    {470,150,7,3,BENZIN},
    {471,50,1,3,BENZIN},
    {472,1000,15,3,BENZIN},
    {473,300,7,3,BENZIN},
    {474,100,7,3,BENZIN},
    {475,100,7,3,BENZIN},
    {476,1000,13,3,BENZIN},
    {477,120,6,3,EUROSUPER},
    {478,80,4,3,BENZIN},
    {479,100,5,3,DIZEL},
    {480,80,6,3,DIZEL},
    {481,0,0,0,NEMA},
    {482,200,5,3,DIZEL},
    {483,100,5,3,DIZEL},
	{484,1000,12,3,DIZEL},
	{485,60,5,3,BENZIN},
	{486,130,8,3,BENZIN},
	{487,2000,20,3,DIZEL},
	{488,2000,20,3,DIZEL},
	{489,150,9,3,BENZIN},
	{490,150,9,3,BENZIN},
	{491,100,7,3,BENZIN},
	{492,100,7,3,BENZIN},
	{493,700,12,3,DIZEL},
    {494,120,6,3,EUROSUPER},
    {495,150,6,3,EUROSUPER},
    {496,100,5,3,DIZEL},
    {497,2000,20,3,DIZEL},
    {498,150,9,3,BENZIN},
    {499,150,9,3,BENZIN},
    {500,90,4,3,DIZEL},
    {501,0,0,0,NEMA},
    {502,120,6,3,EUROSUPER},
    {503,120,6,3,EUROSUPER},
    {504,120,6,3,EUROSUPER},
    {505,60,5,3,BENZIN},
    {506,120,6,3,EUROSUPER},
    {507,60,4,3,DIZEL},
    {508,100,7,3,BENZIN},
    {509,0,0,0,NEMA},
    {510,0,0,0,NEMA},
    {511,300,10,3,DIZEL},
    {512,300,10,3,DIZEL},
    {513,300,10,3,DIZEL},
    {514,500,10,3,DIZEL},
    {515,300,10,3,DIZEL},
    {516,60,4,3,DIZEL},
    {517,60,4,3,DIZEL},
    {518,60,4,3,DIZEL},
    {519,600,11,3,DIZEL},
    {520,400,12,3,DIZEL},
    {521,15,1,5,BENZIN},
    {522,20,2,5,BENZIN},
    {523,15,1,5,BENZIN},
    {524,100,12,3,BENZIN},
    {525,60,6,3,BENZIN},
    {526,50,3,3,BENZIN},
    {527,50,3,3,BENZIN},
    {528,70,5,3,BENZIN},
    {529,60,5,3,BENZIN},
    {530,20,1,5,BENZIN},
    {531,40,3,5,BENZIN},
    {532,50,5,5,BENZIN},
    {533,60,5,3,BENZIN},
    {534,70,5,3,BENZIN},
    {535,60,5,3,BENZIN},
    {536,60,5,3,BENZIN},
    {537,1000,15,3,BENZIN},
    {538,1000,15,3,BENZIN},
    {539,60,5,3,BENZIN},
    {540,60,5,3,BENZIN},
    {541,80,6,3,EUROSUPER},
    {542,60,7,3,BENZIN},
    {543,60,5,3,BENZIN},
    {544,80,6,3,BENZIN},
    {545,60,4,3,BENZIN},
    {546,60,3,3,DIZEL},
    {547,60,3,3,DIZEL},
    {548,700,10,3,BENZIN},
    {549,60,5,3,BENZIN},
    {550,60,5,3,BENZIN},
    {551,60,5,3,BENZIN},
	{552,60,5,3,BENZIN},
	{553,400,10,3,BENZIN},
	{554,90,5,3,BENZIN},
	{555,60,5,3,BENZIN},
	{556,140,8,3,BENZIN},
	{557,140,8,3,BENZIN},
	{558,60,5,3,BENZIN},
	{559,80,6,3,EUROSUPER},
	{560,90,5,3,DIZEL},
	{561,60,5,3,BENZIN},
	{562,70,6,3,EUROSUPER},
	{562,60,5,3,BENZIN},
	{563,600,12,4,BENZIN},
	{564,0,0,0,NEMA},
	{565,60,5,3,BENZIN},
	{566,60,5,3,BENZIN},
	{567,60,5,3,BENZIN},
	{568,80,6,3,EUROSUPER},
	{569,0,0,0,NEMA},
	{570,0,0,0,NEMA},
	{571,15,1,1,BENZIN},
	{572,20,1,1,BENZIN},
	{573,100,8,3,BENZIN},
	{574,20,1,1,BENZIN},
	{575,60,5,3,BENZIN},
    {576,60,5,3,BENZIN},
    {577,1000,15,3,BENZIN},
    {578,100,8,3,BENZIN},
    {579,100,8,3,BENZIN},
    {580,60,7,3,BENZIN},
    {581,20,2,5,BENZIN},
    {582,90,6,3,DIZEL},
    {583,20,1,1,BENZIN},
    {584,0,0,0,NEMA},
    {585,60,4,3,DIZEL},
    {586,20,2,5,BENZIN},
    {587,60,5,3,BENZIN},
    {588,100,8,3,BENZIN},
    {589,60,5,3,BENZIN},
    {590,0,0,0,NEMA},
    {591,0,0,0,NEMA},
    {592,2000,16,3,BENZIN},
    {593,300,8,3,BENZIN},
    {594,0,0,0,NEMA},
    {595,150,5,3,BENZIN},
    {596,100,4,3,DIZEL},
    {597,100,4,3,DIZEL},
    {598,100,4,3,DIZEL},
    {599,100,7,3,BENZIN},
    {600,60,5,3,BENZIN},
    {601,120,9,3,BENZIN},
    {602,60,5,3,BENZIN},
    {603,80,6,3,EUROSUPER},
    {604,60,5,3,BENZIN},
    {605,60,5,3,BENZIN},
    {606,0,0,0,NEMA},
    {607,0,0,0,NEMA},
    {608,0,0,0,NEMA},
    {609,80,5,3,BENZIN},
    {610,0,0,0,NEMA},
    {611,0,0,0,NEMA}
};

GetNumb(vehid)
{
	new id = GetVehicleModel(vehid),
		idd = -1;
	for(new i=0;i<MAX_MODELS;i++) {
	    if(id == BenzinInfo[i][bID]) { idd = i; break; } }
	return idd;
}

//tdovi
ShowBrzinomjer(playerid,bool:dane)
{
	if(dane) {
		for(new i=0;i<sizeof(brzinomjer);i++) { TextDrawShowForPlayer(playerid,brzinomjer[i]); }
		for(new i=0;i<sizeof(brzinomjerp);i++) { PlayerTextDrawShow(playerid,brzinomjerp[i][playerid]); }
	}else{
		for(new i=0;i<sizeof(brzinomjer);i++) { TextDrawHideForPlayer(playerid,brzinomjer[i]); }
		for(new i=0;i<sizeof(brzinomjerp);i++) { PlayerTextDrawHide(playerid,brzinomjerp[i][playerid]); } }
	return 1;
}

SetGorivo(vid,litara = 9999)
{
	new numb = GetNumb(vid);
	if(litara == 9999 || litara > BenzinInfo[numb][bMax] || litara < 0) {
	Gorivo[vid] = BenzinInfo[numb][bMax];
	}else{ Gorivo[vid] = litara; }
	return 1;
}

//==============================================================================
//benzinske system
#define BENPATH "/Benzinske/%d.ini"
#define MAX_BENZINSKA 30
enum benInfo
{
	Float:bX,
	Float:bY,
	Float:bZ
}
new BenzinskaInfo[MAX_BENZINSKA][benInfo];
new Text3D:benText[MAX_BENZINSKA];
new benPickup[MAX_BENZINSKA];

forward LoadBenzinska(id,name[],value[]);
public LoadBenzinska(id,name[],value[])
{
	INI_Float("X",BenzinskaInfo[id][bX]);
	INI_Float("Y",BenzinskaInfo[id][bY]);
	INI_Float("Z",BenzinskaInfo[id][bZ]);
	return 1;
}

stock SacuvajBenzinsku(id)
{
	new str[50];
	format(str,sizeof(str),BENPATH,id);
	new INI:File = INI_Open(str);
	INI_SetTag(File,"data");
	INI_WriteFloat(File,"X",BenzinskaInfo[id][bX]);
	INI_WriteFloat(File,"Y",BenzinskaInfo[id][bY]);
	INI_WriteFloat(File,"Z",BenzinskaInfo[id][bZ]);
	INI_Close(File);
	return 1;
}

KreirajBenzinsku(id)
{
    new str[200];
    format(str,sizeof(str),""zuta"[BENZINSKA]\n\n"bijela"Za tocenje goriva upisite '"zuta"/natoci"bijela"'.");
	benText[id] = Create3DTextLabel(str, -1, BenzinskaInfo[id][bX], BenzinskaInfo[id][bY], BenzinskaInfo[id][bZ], 20.0, 0, 0);
 	benPickup[id] = CreateDynamicPickup(1650, 1, BenzinskaInfo[id][bX], BenzinskaInfo[id][bY], BenzinskaInfo[id][bZ], 0);
	return 1;
}

IzbrisiBenzinsku(id)
{
	Delete3DTextLabel(benText[id]);
	DestroyDynamicPickup(benPickup[id]);
	return 1;
}

LoadBenzinske()
{
 	new x;
 	for(new b=0;b<MAX_BENZINSKA;b++)
	{
		new strt[20];
	  	format(strt,sizeof(strt),BENPATH,b);
	  	if(fexist(strt))
		{
			INI_ParseFile(strt,"LoadBenzinska",.bExtra = true,.extra = b);
			KreirajBenzinsku(b);
			x++;
		}
	}
	printf("Ucitano %d benzinska!",x);
	return 1;
}

SacuvajSveBenzinske()
{
    for(new i=0;i<MAX_BENZINSKA;i++)
	{
	    new str1[20];
	    format(str1,sizeof(str1),BENPATH,i);
	    if(fexist(str1))
	    {
	        SacuvajBenzinsku(i);
		}
	}
	return 1;
}
//==============================================================================
//vehicle ownership system
#define VPATH "/Vozila/%d.ini"
#define MAX_VOZILA 1000

enum vInfo
{
	vModel,
    Float:vX,
    Float:vY,
    Float:vZ,
    Float:vAZ,
    vBoja1,
    vBoja2,
    vOwnerName[24],
    bool:vOwned,
	vID,
	vLocked,
	vPrice,
	mod[17],
	vPaintJob,
	vVW,
	vOruzje[3],
	vMunicija[3],
	vDroga,
	vMats,
	vMoney
}
new VoziloInfo[MAX_VOZILA][vInfo];
new Text3D:vehtxt[MAX_VOZILA];

forward LoadVehicles(id, name[], value[]);
public LoadVehicles(id, name[], value[])
{
    INI_Int("Model", VoziloInfo[id][vModel]);
    INI_Float("X", VoziloInfo[id][vX]);
    INI_Float("Y", VoziloInfo[id][vY]);
    INI_Float("Z", VoziloInfo[id][vZ]);
    INI_Float("AZ", VoziloInfo[id][vAZ]);
    INI_Int("Boja1", VoziloInfo[id][vBoja1]);
    INI_Int("Boja2", VoziloInfo[id][vBoja2]);
    INI_String("OwnerName", VoziloInfo[id][vOwnerName],24);
    INI_Bool("Owned", VoziloInfo[id][vOwned]);
    INI_Int("ID", VoziloInfo[id][vID]);
	INI_Int("Locked", VoziloInfo[id][vLocked]);
	INI_Int("Price", VoziloInfo[id][vPrice]);
	INI_Int("Mod0", VoziloInfo[id][mod][0]);
    INI_Int("Mod1", VoziloInfo[id][mod][1]);
    INI_Int("Mod2", VoziloInfo[id][mod][2]);
    INI_Int("Mod3", VoziloInfo[id][mod][3]);
    INI_Int("Mod4", VoziloInfo[id][mod][4]);
    INI_Int("Mod5", VoziloInfo[id][mod][5]);
    INI_Int("Mod6", VoziloInfo[id][mod][6]);
    INI_Int("Mod7", VoziloInfo[id][mod][7]);
    INI_Int("Mod8", VoziloInfo[id][mod][8]);
    INI_Int("Mod9", VoziloInfo[id][mod][9]);
    INI_Int("Mod10", VoziloInfo[id][mod][10]);
    INI_Int("Mod11", VoziloInfo[id][mod][11]);
    INI_Int("Mod12", VoziloInfo[id][mod][12]);
    INI_Int("Mod13", VoziloInfo[id][mod][13]);
    INI_Int("Mod14", VoziloInfo[id][mod][14]);
    INI_Int("Mod15", VoziloInfo[id][mod][15]);
    INI_Int("Mod16", VoziloInfo[id][mod][16]);
    INI_Int("PainJob", VoziloInfo[id][vPaintJob]);
    INI_Int("VW", VoziloInfo[id][vVW]);
    INI_Int("Oruzje1", VoziloInfo[id][vOruzje][0]);
    INI_Int("Oruzje2", VoziloInfo[id][vOruzje][1]);
    INI_Int("Oruzje3", VoziloInfo[id][vOruzje][2]);
    INI_Int("Municija1", VoziloInfo[id][vMunicija][0]);
    INI_Int("Municija2", VoziloInfo[id][vMunicija][1]);
    INI_Int("Municija3", VoziloInfo[id][vMunicija][2]);
    INI_Int("Droga", VoziloInfo[id][vDroga]);
    INI_Int("Mats", VoziloInfo[id][vMats]);
    INI_Int("Money", VoziloInfo[id][vMoney]);
    return 1;
}

stock SacuvajVozilo(id)
{
    new vFile[80];
    format(vFile, sizeof(vFile), VPATH, id);
	new INI:File = INI_Open(vFile);
    INI_WriteInt(File,"Model", VoziloInfo[id][vModel]);
    INI_WriteFloat(File,"X", VoziloInfo[id][vX]);
    INI_WriteFloat(File,"Y", VoziloInfo[id][vY]);
    INI_WriteFloat(File,"Z", VoziloInfo[id][vZ]);
    INI_WriteFloat(File,"AZ", VoziloInfo[id][vAZ]);
    INI_WriteInt(File,"Boja1", VoziloInfo[id][vBoja1]);
    INI_WriteInt(File,"Boja2", VoziloInfo[id][vBoja2]);
    INI_WriteString(File,"OwnerName", VoziloInfo[id][vOwnerName]);
    INI_WriteBool(File,"Owned", VoziloInfo[id][vOwned]);
    INI_WriteInt(File,"ID", VoziloInfo[id][vID]);
	INI_WriteInt(File,"Locked", VoziloInfo[id][vLocked]);
	INI_WriteInt(File,"Price", VoziloInfo[id][vPrice]);
	INI_WriteInt(File,"Mod0", VoziloInfo[id][mod][0]);
    INI_WriteInt(File,"Mod1", VoziloInfo[id][mod][1]);
    INI_WriteInt(File,"Mod2", VoziloInfo[id][mod][2]);
    INI_WriteInt(File,"Mod3", VoziloInfo[id][mod][3]);
    INI_WriteInt(File,"Mod4", VoziloInfo[id][mod][4]);
    INI_WriteInt(File,"Mod5", VoziloInfo[id][mod][5]);
    INI_WriteInt(File,"Mod6", VoziloInfo[id][mod][6]);
    INI_WriteInt(File,"Mod7", VoziloInfo[id][mod][7]);
    INI_WriteInt(File,"Mod8", VoziloInfo[id][mod][8]);
    INI_WriteInt(File,"Mod9", VoziloInfo[id][mod][9]);
    INI_WriteInt(File,"Mod10", VoziloInfo[id][mod][10]);
    INI_WriteInt(File,"Mod11", VoziloInfo[id][mod][11]);
    INI_WriteInt(File,"Mod12", VoziloInfo[id][mod][12]);
    INI_WriteInt(File,"Mod13", VoziloInfo[id][mod][13]);
    INI_WriteInt(File,"Mod14", VoziloInfo[id][mod][14]);
    INI_WriteInt(File,"Mod15", VoziloInfo[id][mod][15]);
    INI_WriteInt(File,"Mod16", VoziloInfo[id][mod][16]);
    INI_WriteInt(File,"PaintJob", VoziloInfo[id][vPaintJob]);
    INI_WriteInt(File,"VW", VoziloInfo[id][vVW]);
    INI_WriteInt(File,"Oruzje1", VoziloInfo[id][vOruzje][0]);
    INI_WriteInt(File,"Oruzje2", VoziloInfo[id][vOruzje][1]);
    INI_WriteInt(File,"Oruzje3", VoziloInfo[id][vOruzje][2]);
    INI_WriteInt(File,"Municija1", VoziloInfo[id][vMunicija][0]);
    INI_WriteInt(File,"Municija2", VoziloInfo[id][vMunicija][1]);
    INI_WriteInt(File,"Municija3", VoziloInfo[id][vMunicija][2]);
    INI_WriteInt(File,"Droga", VoziloInfo[id][vDroga]);
    INI_WriteInt(File,"Mats", VoziloInfo[id][vMats]);
    INI_WriteInt(File,"Money", VoziloInfo[id][vMoney]);
	INI_Close(File);
	return 1;
}

UcitajVozila()
{
    for(new i=0;i<MAX_VOZILA;i++)
	{
		new vFile[50];
        format(vFile, sizeof(vFile), VPATH, i);
        if(fexist(vFile))
        {
            INI_ParseFile(vFile, "LoadVehicles", .bExtra = true, .extra = i);
            VoziloInfo[i][vID] = CreateVehicle(VoziloInfo[i][vModel],VoziloInfo[i][vX],VoziloInfo[i][vY],VoziloInfo[i][vZ],VoziloInfo[i][vAZ],VoziloInfo[i][vBoja1],VoziloInfo[i][vBoja2],30000);
            SetGorivo(VoziloInfo[i][vID]);
			ModVehicle(VoziloInfo[i][vID]);
            SetVehicleVirtualWorld(VoziloInfo[i][vID],VoziloInfo[i][vVW]);
            if(VoziloInfo[i][vPaintJob] != -1)
            {
				ChangeVehiclePaintjob(VoziloInfo[i][vID], VoziloInfo[i][vPaintJob]);
			}
			ChangeVehicleColor(VoziloInfo[i][vID], VoziloInfo[i][vBoja1], VoziloInfo[i][vBoja2]);
			Locked[VoziloInfo[i][vID]] = VoziloInfo[i][vLocked];
			if(!VoziloInfo[i][vOwned])
			{
			    new str[120];
			    new price;
				price = VoziloInfo[i][vPrice]/2;
				format(str,sizeof(str),""zuta"[%s]\n"zelena"Vozilo na prodaju!\n"zelena"Cijena: %d$",GetVehicleName(VoziloInfo[i][vID]),price);
				vehtxt[VoziloInfo[i][vID]] = Create3DTextLabel(str, -1, 0.0, 0.0, 0.0, 50.0, VoziloInfo[i][vVW], 0 );
			 	Attach3DTextLabelToVehicle(vehtxt[VoziloInfo[i][vID]], VoziloInfo[i][vID], 0.0, 0.0, 0.0);
			}
		}
	}
	return 1;
}

SacuvajSvaVozila()
{
    for(new i=0;i<MAX_VOZILA;i++)
	{
	    new str1[20];
	    format(str1,sizeof(str1),VPATH,i);
	    if(fexist(str1))
	    {
	        SacuvajVozilo(i);
		}
	}
	return 1;
}

new spoiler[20][0] = {
	{1000},
	{1001},
	{1002},
	{1003},
	{1014},
	{1015},
	{1016},
	{1023},
	{1058},
	{1060},
	{1049},
	{1050},
	{1138},
	{1139},
	{1146},
	{1147},
	{1158},
	{1162},
	{1163},
	{1164}
};

new nitro[3][0] = {
    {1008},
    {1009},
    {1010}
};

new fbumper[23][0] = {
    {1117},
    {1152},
    {1153},
    {1155},
    {1157},
    {1160},
    {1165},
    {1166},
    {1169},
    {1170},
    {1171},
    {1172},
    {1173},
    {1174},
    {1175},
    {1179},
    {1181},
    {1182},
    {1185},
    {1188},
    {1189},
    {1192},
    {1193}
};

new rbumper[22][0] = {
    {1140},
    {1141},
    {1148},
    {1149},
    {1150},
    {1151},
    {1154},
    {1156},
    {1159},
    {1161},
    {1167},
    {1168},
    {1176},
    {1177},
    {1178},
    {1180},
    {1183},
    {1184},
    {1186},
    {1187},
    {1190},
    {1191}
};

new exhaust[28][0] = {
    {1018},
    {1019},
    {1020},
    {1021},
    {1022},
    {1028},
    {1029},
    {1037},
    {1043},
    {1044},
    {1045},
    {1046},
    {1059},
    {1064},
    {1065},
    {1066},
    {1089},
    {1092},
    {1104},
    {1105},
    {1113},
    {1114},
    {1126},
    {1127},
    {1129},
    {1132},
    {1135},
    {1136}
};

new bventr[2][0] = {
    {1142},
    {1144}
};

new bventl[2][0] = {
    {1143},
    {1145}
};

new bscoop[4][0] = {
	{1004},
	{1005},
	{1011},
	{1012}
};

new rscoop[17][0] = {
    {1006},
    {1032},
    {1033},
    {1035},
    {1038},
    {1053},
    {1054},
    {1055},
    {1061},
    {1067},
    {1068},
    {1088},
    {1091},
    {1103},
    {1128},
    {1130},
    {1131}
};

new lskirt[21][0] = {
    {1007},
    {1026},
    {1031},
    {1036},
    {1039},
    {1042},
    {1047},
    {1048},
    {1056},
    {1057},
    {1069},
    {1070},
    {1090},
    {1093},
    {1106},
    {1108},
    {1118},
    {1119},
    {1133},
    {1122},
    {1134}
};

new rskirt[21][0] = {
    {1017},
    {1027},
    {1030},
    {1040},
    {1041},
    {1051},
    {1052},
    {1062},
    {1063},
    {1071},
    {1072},
    {1094},
    {1095},
    {1099},
    {1101},
    {1102},
    {1107},
    {1120},
    {1121},
    {1124},
    {1137}
};

new hydraulics[1][0] = {
    {1087}
};

new base2[1][0] = {
    {1086}
};

new rbbars[4][0] = {
    {1109},
    {1110},
    {1123},
    {1125}
};

new fbbars[2][0] = {
    {1115},
    {1116}
};

new wheels[17][0] = {
    {1025},
    {1073},
    {1074},
    {1075},
    {1076},
    {1077},
    {1078},
    {1079},
    {1080},
    {1081},
    {1082},
    {1083},
    {1084},
    {1085},
    {1096},
    {1097},
    {1098}
};

new lights[2][0] = {
	{1013},
	{1024}
};

forward SaveComponent(vehicleid, componentid);
public SaveComponent(vehicleid, componentid)
{
    new playerid = GetDriverID(vehicleid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	 	new id;
	  	for(new i; i < MAX_VOZILA; i++)
		{
			if(VoziloInfo[i][vID] == vehicleid)
			{
	  			id=i;
	   		}
		}
		for(new s=0; s<20; s++) {
			if(componentid == spoiler[s][0]) {
				VoziloInfo[id][mod][0] = componentid;
			}
		}
		for(new s=0; s<4; s++) {
			if(componentid == bscoop[s][0]) {
				VoziloInfo[id][mod][1] = componentid;
			}
		}
		for(new s=0; s<17; s++) {
	 		if(componentid == rscoop[s][0]) {
				VoziloInfo[id][mod][2] = componentid;
			}
		}
		for(new s=0; s<21; s++) {
			if(componentid == rskirt[s][0]) {
	   			VoziloInfo[id][mod][3] = componentid;
			}
		}
		for(new s=0; s<21; s++) {
	 		if(componentid == lskirt[s][0]) {
				VoziloInfo[id][mod][16] = componentid;
			}
	   	}
		for(new s=0; s<2; s++) {
	 		if(componentid == lights[s][0]) {
				VoziloInfo[id][mod][4] = componentid;
			}
		}
		for(new s=0; s<3; s++) {
			if(componentid == nitro[s][0]) {
	   			VoziloInfo[id][mod][5] = componentid;
			}
		}
		for(new s=0; s<28; s++) {
			if(componentid == exhaust[s][0]) {
	   			VoziloInfo[id][mod][6] = componentid;
			}
		}
		for(new s=0; s<17; s++) {
	 		if(componentid == wheels[s][0]) {
				VoziloInfo[id][mod][7] = componentid;
			}
		}
		for(new s=0; s<1; s++) {
			if(componentid == base2[s][0]) {
				VoziloInfo[id][mod][8] = componentid;
			}
		}
		for(new s=0; s<1; s++) {
	 		if(componentid == hydraulics[s][0]) {
	   			VoziloInfo[id][mod][9] = componentid;
			}
		}
		for(new s=0; s<23; s++) {
			if(componentid == fbumper[s][0]) {
	   			VoziloInfo[id][mod][10] = componentid;
			}
		}
		for(new s=0; s<22; s++) {
	 		if(componentid == rbumper[s][0]) {
				VoziloInfo[id][mod][11] = componentid;
			}
		}
		for(new s=0; s<2; s++) {
	 		if(componentid == bventr[s][0]) {
				VoziloInfo[id][mod][12] = componentid;
			}
		}
		for(new s=0; s<2; s++) {
	 		if(componentid == bventl[s][0]) {
				VoziloInfo[id][mod][13] = componentid;
			}
		}
		for(new s=0; s<2; s++) {
	 		if(componentid == fbbars[s][0]) {
				VoziloInfo[id][mod][15] = componentid;
			}
		}
		for(new s=0; s<4; s++) {
			if(componentid == rbbars[s][0]) {
				VoziloInfo[id][mod][14] = componentid;
			}
		}
		SacuvajVozilo(id);
	}
	return 0;
}

ModVehicle(vehicleid)
{
	if(vehicleid <= 0 || vehicleid >= MAX_VEHICLES) return;
	new id;
	for(new i; i < MAX_VOZILA; i++)
	{
 		if(VoziloInfo[i][vID] == vehicleid)
   		{
   		    id=i;
   		}
	}
	for(new i = 0; i < 17; ++i)
	{
		if(VoziloInfo[id][mod][i] != 0)
		{
			AddVehicleComponent(VoziloInfo[id][vID], VoziloInfo[id][mod][i]);
		}
	}
}

GetDriverID(vehicleid)
{
    foreach(Player,i)
    {
        if(GetPlayerVehicleID(i) == vehicleid && GetPlayerState(i) == PLAYER_STATE_DRIVER) return i;
    }
    return -1;
}

new Float:RandomSajamSpawn[][] =
{
    {-2016.9690, -143.4361, 35.4114, 90.7224},
	{-2016.9690, -148.1827, 35.4114, 90.7224},
	{-2016.9690, -153.4830, 35.4114, 90.7224},
	{-2016.9690, -158.7070, 35.4114, 90.7224},
	{-2016.9690, -163.6305, 35.4114, 90.7224},
	{-2016.9690, -168.5253, 35.4114, 90.7224},
	{-2016.9690, -173.7349, 35.4114, 90.7224},
	{-2016.9690, -178.7881, 35.4114, 90.7224},
	{-2016.9690, -183.2128, 35.4114, 90.7224},
	{-2016.9690, -188.4751, 35.4114, 90.7224},
	{-2016.9690, -193.3535, 35.4114, 90.7224},
	{-2016.9690, -198.1900, 35.4114, 90.7224},
	{-2016.9690, -203.5697, 35.4114, 90.7224},
	{-2016.9690, -208.4553, 35.4114, 90.7224},
	{-2016.9690, -213.4340, 35.4114, 90.7224},
	{-2016.9690, -218.5402, 35.4114, 90.7224},
	{-2016.9690, -223.1213, 35.4114, 90.7224},
	{-2016.9690, -228.2413, 35.4114, 90.7224},
	{-2016.9690, -233.2013, 35.4114, 90.7224},
	{-2016.9690, -238.5414, 35.4114, 90.7224},
	{-2016.9690, -243.4400, 35.4114, 90.7224},
	{-2016.9690, -248.4203, 35.4114, 90.7224},
	{-2016.9690, -253.6413, 35.4114, 90.7224},
	{-2016.9690, -258.4220, 35.4114, 90.7224},
	{-2016.9690, -263.5420, 35.4114, 90.7224},
	{-2016.9690, -268.6823, 35.4114, 90.7224},
	{-2016.9690, -273.5823, 35.4114, 90.7224},
	{-2016.9690, -278.0782, 35.4114, 90.7224},
	{-2044.6187, -148.4947, 35.4114, 90.7224},
	{-2044.6187, -153.2605, 35.4114, 90.7224},
	{-2044.6187, -157.5808, 35.4114, 90.7224},
	{-2044.6187, -162.1177, 35.4114, 90.7224},
	{-2044.6187, -166.4816, 35.4114, 90.7224},
	{-2044.6187, -171.2837, 35.4114, 90.7224},
	{-2044.6187, -184.7250, 35.4114, 90.7224},
	{-2044.6187, -189.1095, 35.4114, 90.7224},
	{-2044.6187, -193.7928, 35.4114, 90.7224},
	{-2044.6187, -198.2499, 35.4114, 90.7224},
	{-2044.6187, -202.8692, 35.4114, 90.7224},
	{-2044.6187, -207.3316, 35.4114, 90.7224},
	{-2044.6187, -220.9948, 35.4114, 90.7224},
	{-2044.6187, -225.5918, 35.4114, 90.7224},
	{-2044.6187, -230.1523, 35.4114, 90.7224},
	{-2044.6187, -234.6512, 35.4114, 90.7224},
	{-2044.6187, -239.1321, 35.4114, 90.7224},
	{-2044.6187, -243.8137, 35.4114, 90.7224},
	{-2044.6187, -256.9577, 35.4114, 90.7224},
	{-2044.6187, -261.3217, 35.4114, 90.7224},
	{-2044.6187, -266.1244, 35.4114, 90.7224},
	{-2044.6187, -270.5272, 35.4114, 90.7224},
	{-2044.6187, -275.2495, 35.4114, 90.7224},
	{-2063.0374, -149.0754, 35.4114, 269.7317},
	{-2063.0374, -153.6996, 35.4114, 269.7317},
	{-2063.0374, -158.0655, 35.4114, 269.7317},
	{-2063.0374, -162.7446, 35.4114, 269.7317},
	{-2063.0374, -167.4110, 35.4114, 269.7317},
	{-2063.0374, -171.6525, 35.4114, 269.7317},
	{-2063.0374, -185.2778, 35.4114, 269.7317},
	{-2063.0374, -189.7263, 35.4114, 269.7317},
	{-2063.0374, -194.4791, 35.4114, 269.7317},
	{-2063.0374, -198.9419, 35.4114, 269.7317},
	{-2063.0374, -203.3641, 35.4114, 269.7317},
	{-2063.0374, -208.0198, 35.4114, 269.7317},
	{-2063.0374, -221.3447, 35.4114, 269.7317},
	{-2063.0374, -225.8123, 35.4114, 269.7317},
	{-2063.0374, -230.4585, 35.4114, 269.7317},
	{-2063.0374, -234.9217, 35.4114, 269.7317},
	{-2063.0374, -239.3825, 35.4114, 269.7317},
	{-2063.0374, -244.0039, 35.4114, 269.7317},
	{-2063.0374, -257.5840, 35.4114, 269.7317},
	{-2063.0374, -262.1872, 35.4114, 269.7317},
	{-2063.0374, -266.7291, 35.4114, 269.7317},
	{-2063.0374, -271.1692, 35.4114, 269.7317},
	{-2063.0374, -275.3686, 35.4114, 269.7317},
	{-2091.0649, -144.7124, 35.4114, 269.7317},
	{-2091.0649, -149.6581, 35.4114, 269.7317},
	{-2091.0649, -154.7857, 35.4114, 269.7317},
	{-2091.0649, -160.0204, 35.4114, 269.7317},
	{-2091.0649, -164.8916, 35.4114, 269.7317},
	{-2091.0649, -170.0320, 35.4114, 269.7317},
	{-2091.0649, -175.0988, 35.4114, 269.7317},
	{-2091.0649, -180.0125, 35.4114, 269.7317},
	{-2091.0649, -184.7604, 35.4114, 269.7317},
	{-2091.0649, -189.7657, 35.4114, 269.7317},
	{-2091.0649, -194.7864, 35.4114, 269.7317},
	{-2091.0649, -199.7448, 35.4114, 269.7317},
	{-2091.0649, -204.9026, 35.4114, 269.7317},
	{-2091.0649, -209.6905, 35.4114, 269.7317},
	{-2091.0649, -214.9270, 35.4114, 269.7317},
	{-2091.0649, -219.9295, 35.4114, 269.7317},
	{-2091.0649, -224.7321, 35.4114, 269.7317},
	{-2091.0649, -229.8170, 35.4114, 269.7317},
	{-2091.0649, -234.6989, 35.4114, 269.7317},
	{-2091.0649, -239.6961, 35.4114, 269.7317},
	{-2091.0649, -244.8414, 35.4114, 269.7317},
	{-2091.0649, -249.7210, 35.4114, 269.7317},
	{-2091.0649, -254.8965, 35.4114, 269.7317},
	{-2091.0649, -259.8024, 35.4114, 269.7317},
	{-2091.0649, -264.9260, 35.4114, 269.7317},
	{-2091.0649, -269.5638, 35.4114, 269.7317},
	{-2091.0649, -274.9058, 35.4114, 269.7317}
};

new Float:RandomKupovinaSpawn[][] =
{
    {1741.8048,-1791.8568,13.2746,358.8126},
	{1737.0859,-1791.4465,13.2357,358.9684},
	{1731.6415,-1791.0820,13.2163,0.4846},
	{1727.0532,-1791.2697,13.2193,2.6018},
	{1722.1616,-1791.0146,13.2194,357.8623},
	{1717.0830,-1791.6489,13.2703,0.1149},
	{1712.1837,-1791.3480,13.2980,0.6483},
	{1706.8834,-1790.7456,13.3095,356.9844},
	{1712.5710,-1764.6129,13.4462,358.2082},
	{1718.1481,-1763.4354,13.3562,359.9645},
	{1722.8289,-1763.9226,13.2818,358.9312},
	{1727.8395,-1764.5433,13.2198,0.1679},
	{1732.7821,-1764.6324,13.2193,0.7311},
	{1738.3313,-1764.0347,13.2606,1.3562},
	{1742.6351,-1764.6097,13.3326,0.2417},
	{1742.5400,-1773.7046,13.3819,178.5527},
	{1738.3260,-1773.3423,13.2605,179.6777},
	{1733.3820,-1774.0870,13.2193,179.4740},
	{1728.2260,-1773.6528,13.2193,180.8984},
	{1723.2721,-1773.7478,13.2428,180.5168},
	{1717.9763,-1773.4850,13.3214,178.3296},
	{1713.2200,-1772.7855,13.3921,180.3741}
};

new Float:RandomKupovinaSpawnAvioni[][] =
{
    {1912.2336, -2247.3123, 14.1511, 180.4846},
	{1937.4769, -2246.9570, 14.1511, 180.4846},
	{1875.1852, -2274.5322, 14.7520, 270.8520},
	{1875.0258, -2298.7107, 14.7520, 267.6127}
};

new Float:RandomKupovinaSpawnBrodovi[][] =
{
    {2948.3713, -2077.8987, 0.0991, 203.1395},
	{2932.7393, -2076.6299, 0.0991, 203.1395},
	{2951.8069, -2033.0717, 0.0991, 214.8699},
	{2933.8376, -2026.4084, 0.0991, 219.0359}
};


#define MAX_KATALOG 45

enum kkInfo
{
	kID,
	kPrice
}

new KatalogInfo[MAX_KATALOG][kkInfo] =
{
    {400,620000},
	{402,800000},
	{405,400000},
	{415,900000},
	{426,700000},
	{439,400000},
	{451,3000000},
	{445,700000},
	{475,300000},
	{477,800000},
	{480,800000},
	{489,700000},
	{492,400000},
	{496,500000},
	{506,550000},
	{507,400000},
	{526,200000},
	{534,800000},
	{541,4000000},
	{549,500000},
	{550,350000},
	{558,900000},
	{559,700000},
	{560,9000000},
	{562,8000000},
	{565,5000000},
	{566,350000},
	{567,500000},
	{579,1300000},
	{587,800000},
	{589,850000},
	{462,100000},
	{461,500000},
	{468,450000},
	{581,600000},
	{521,1500000},
	{522,3000000},
	{593,1000000},
	{513,900000},
	{487,3000000},
	{476,1200000},
	{447,800000},
	{430,700000},
	{446,750000},
	{446,1000000}
};
//==============================================================================
//organizacije system

#define MAX_ORGS 10

#define THE_RED_BRIGADE 0
#define THE_ESCOBAR_CARTEL 1
#define YAKUZA 2
#define LCN 3
#define GSF 4
#define BALLAS 5
#define VAGOS 6
#define ARTEZ 7
#define POLICIJA 8
#define ROYAL_BOYS 9

#define ULAZ_PICKUP 1239

enum oInfo
{
	oName[24],
	Float:oUlazX,
	Float:oUlazY,
	Float:oUlazZ,
	Float:oUlazAZ,
	Float:oIzlazX,
	Float:oIzlazY,
	Float:oIzlazZ,
	Float:oIzlazAZ,
	oInt,
	oVW,
	oMaxClanova,
	oKapijaObj,
	Float:oKapijaX,
	Float:oKapijaY,
	Float:oKapijaZ,
	Float:oKapijaRX,
	Float:oKapijaRY,
	Float:oKapijaRZ,
	Float:oKapijaMoveX,
	Float:oKapijaMoveY,
	Float:oKapijaMoveZ,
	oRankSkin1,
	oRankSkin2,
	oRankSkin3,
	oRankSkin4,
	oRankSkin5,
    oRankSkin6,
    bool:oSef,
    Float:oSefX,
    Float:oSefY,
    Float:oSefZ,
    oColor
}

new OrgInfo[MAX_ORGS][oInfo] =
{
	{"The Red Brigade",1215.0023,-1102.9001,25.1232,5.4243, 221.0073,1557.4501,-68.5000,173.7841,0,1,30,19912,1213.899658, -1047.968261, 33.387908, 0.000000, 0.000000, 0.000000,1225.56946, -1047.55225, 33.38791,
	19,82,180,189,170,49,true,233.1254,1538.8510,-68.5000,0xFF0000AA},
	{"The Escobar Cartel",691.1464,-1276.0775,13.5604,88.7484, 221.0073,1557.4501,-68.5000,173.7841,0,2,30,19912,670.654479,-1309.045043, 15.203880, 0.000000, 0.000000, 0.000000,682.2508,-1309.1741,15.2039,
	25,21,48,187,66,24,true,233.1254,1538.8510,-68.5000,0xFFFF00AA},
	{"Yakuza",865.1291,-1634.3254,14.9297,179.5925, 221.0073,1557.4501,-68.5000,173.7841,0,3,40,19912,907.868347, -1660.801025, 14.207150, 0.000000, 0.000000, 90.000000,907.6479, -1650.2562, 14.2072,
	117,118,165,166,17,120,true,233.1254,1538.8510,-68.5000,0x000000AA},
	{"LCN",1689.2144,-1238.7942,14.9844,188.0527, 221.0073,1557.4501,-68.5000,173.7841,0,4,30,19912,1670.643310, -1282.686401, 16.534599, 0.000000, 0.000000, 0.000000,1682.1492, -1282.4386, 16.5346,
	46,47,48,126,127,113,true,233.1254,1538.8510,-68.5000,0x5F5F5FAA},
	{"GSF",2495.3516,-1690.9218,14.7656,360.0000,1528.9374,85.9982,-3.7246,272.0268,0,5,30,-1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,107,106,105,271,269,270,true,1546.0482,84.8540,-3.7380,0x008000AA},
	{"Ballas",2236.3540,-1440.8622,24.1309,269.5201,1528.9374,85.9982,-3.7246,272.0268,0,6,30,-1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,22,104,103,303,102,296,true,1546.0482,84.8540,-3.7380,0xFF0080AA},
	{"Vagos",1828.1179,-1980.7219,13.5469,186.1960,1528.9374,85.9982,-3.7246,272.0268,0,7,30,-1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,121,123,108,109,110,292,true,1546.0482,84.8540,-3.7380,0x8C8C00AA},
	{"Artez",2545.4114,-1127.8788,63.0443,174.8925,1528.9374,85.9982,-3.7246,272.0268,0,8,30,-1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,176,177,173,174,175,291,true,1546.0482,84.8540,-3.7380,0x2D2DFFAA},
	{"Policija",1544.3368,-1635.9204,13.3800,85.4008,246.7974,62.5176,1003.6406,355.4123,6,9,70,-1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,280,293,285,286,288,310,false,0.0,0.0,0.0,0x0000FFAA},
	{"Royal Boys",1298.5531,-798.2918,84.1406,186.0718,221.0073,1557.4501,-68.5000,173.7841,0,10,30,19912,1251.297363, -767.219177, 93.765579,0.0, 0.0, 0.0,1261.89111, -766.81903, 93.76558,
	24,25,290,291,292,3,true,233.1254,1538.8510,-68.5000,0x3E0000AA}
};
new OrgPickup[3][MAX_ORGS];
new Text3D:OrgLabel[3][MAX_ORGS];
new KapijaObject[MAX_ORGS];
new KapijaState[MAX_ORGS];

#define OPATH "/Organizacije/%d.ini"

enum orgInfo
{
	oName[24],
	oMoney,
	oDroga,
	oMats,
	oClanovi
}
new OrgInfo2[MAX_ORGS][orgInfo];

forward LoadOrg(id,name[],value[]);
public LoadOrg(id,name[],value[])
{
    INI_String("Name",OrgInfo2[id][oName],24);
	INI_Int("Money",OrgInfo2[id][oMoney]);
	INI_Int("Droga",OrgInfo2[id][oDroga]);
	INI_Int("Mats",OrgInfo2[id][oMats]);
	INI_Int("Clanovi",OrgInfo2[id][oClanovi]);
	return 1;
}

stock SacuvajOrganizaciju(id)
{
	new str[50];
	format(str,sizeof(str),OPATH,id);
	new INI:File = INI_Open(str);
	INI_SetTag(File,"data");
 	INI_WriteString(File,"Name",OrgInfo2[id][oName]);
	INI_WriteInt(File,"Money",OrgInfo2[id][oMoney]);
	INI_WriteInt(File,"Droga",OrgInfo2[id][oDroga]);
	INI_WriteInt(File,"Mats",OrgInfo2[id][oMats]);
	INI_WriteInt(File,"Clanovi",OrgInfo2[id][oClanovi]);
	INI_Close(File);
	return 1;
}

KreirajOrganizacije()
{
	new x;
	for(new i=0;i<MAX_ORGS;i++)
	{
	    new str[150];
	    format(str,sizeof(str),""smeda"[ "bijela"%s "smeda"]\n"bijela"Za ulaz pritisnite '"smeda"F"bijela"' ili '"smeda"ENTER"bijela"'.",OrgInfo[i][oName]);
	    
		OrgPickup[0][i] = CreateDynamicPickup(ULAZ_PICKUP, 1, OrgInfo[i][oUlazX],OrgInfo[i][oUlazY],OrgInfo[i][oUlazZ], 0);
		OrgPickup[1][i] = CreateDynamicPickup(ULAZ_PICKUP, 1, OrgInfo[i][oIzlazX],OrgInfo[i][oIzlazY],OrgInfo[i][oIzlazZ], OrgInfo[i][oVW]);
    	OrgLabel[0][i] = Create3DTextLabel(str, -1, OrgInfo[i][oUlazX],OrgInfo[i][oUlazY],OrgInfo[i][oUlazZ] , 20.0, 0, 0);
    	if(OrgInfo[i][oKapijaObj] != -1)
		{
    		OrgLabel[1][i] = Create3DTextLabel(""bijela"Pritisnite '"smeda"H"bijela"' ili '"smeda"C"bijela"'.", -1, OrgInfo[i][oKapijaX],OrgInfo[i][oKapijaY],OrgInfo[i][oKapijaZ] , 20.0, 0, 0);
        	KapijaObject[i] = CreateDynamicObjectEx(OrgInfo[i][oKapijaObj],OrgInfo[i][oKapijaX],OrgInfo[i][oKapijaY],OrgInfo[i][oKapijaZ],OrgInfo[i][oKapijaRX],OrgInfo[i][oKapijaRY],OrgInfo[i][oKapijaRZ],300.0,300.0);
            KapijaState[i] = 0;
		}
		if(OrgInfo[i][oSef])
		{
			OrgPickup[2][i] = CreateDynamicPickup(ULAZ_PICKUP, 1, OrgInfo[i][oSefX],OrgInfo[i][oSefY],OrgInfo[i][oSefZ], OrgInfo[i][oVW]);
    		OrgLabel[2][i] = Create3DTextLabel(""smeda"[SEF]\n"bijela"Da upravljate sefom upisite '"smeda"/sef"bijela"'.", -1, OrgInfo[i][oSefX],OrgInfo[i][oSefY],OrgInfo[i][oSefZ] , 20.0, OrgInfo[i][oVW], 0);
		}
  		format(str,sizeof(str),OPATH,i);
	  	if(fexist(str))
		{
			INI_ParseFile(str,"LoadOrg",.bExtra = true,.extra = i);
			if(strcmp(OrgInfo2[i][oName],OrgInfo[i][oName],false))
			{
                strmid(OrgInfo2[i][oName], OrgInfo[i][oName], 0, strlen(OrgInfo[i][oName]), MAX_PLAYER_NAME);
             	SacuvajOrganizaciju(i);
			}
		}
		else
		{
 			strmid(OrgInfo2[i][oName], OrgInfo[i][oName], 0, strlen(OrgInfo[i][oName]), MAX_PLAYER_NAME);
			OrgInfo2[i][oMoney] = 0;
			OrgInfo2[i][oDroga] = 0;
			OrgInfo2[i][oMats] = 0;
			OrgInfo2[i][oClanovi] = 0;
			SacuvajOrganizaciju(i);
		}
		x++;
	}
	printf("Kreirano %d organizacija!",x);
	return 1;
}

OrgJeMafija(id)
{
	if(id == THE_RED_BRIGADE || id == THE_ESCOBAR_CARTEL || id == YAKUZA || id == LCN || id == ROYAL_BOYS) return true;
	return false;
}

OrgJeBanda(id)
{
	if(id == GSF || id == BALLAS || id == VAGOS || id == ARTEZ) return true;
	return false;
}

SacuvajSveOrganizacije()
{
    for(new i=0;i<MAX_ORGS;i++)
	{
	    new str1[20];
	    format(str1,sizeof(str1),OPATH,i);
	    if(fexist(str1))
	    {
	        SacuvajOrganizaciju(i);
		}
	}
	return 1;
}
//==============================================================================
//anticheat system
enum aCheat
{
	aArmourHack,
	aHealthHack,
	aSpeedHack,
	aJetPackHack,
	aTeleportHack
}
new AntiCheat[MAX_PLAYERS][aCheat];
new Float:ACX[MAX_PLAYERS],Float:ACY[MAX_PLAYERS],Float:ACZ[MAX_PLAYERS],ACINT[MAX_PLAYERS],ACVW[MAX_PLAYERS],ACNUMB[MAX_PLAYERS],bool:AFK[MAX_PLAYERS];
//==============================================================================
//wantedlevel(wl) system
PostaviZlocin(playerid,prijavio[],zlocin[],wl)
{
	strmid(PlayerInfo[playerid][pPrijavio], prijavio, 0, strlen(prijavio), MAX_PLAYER_NAME);
	strmid(PlayerInfo[playerid][pZlocin], zlocin, 0, strlen(zlocin), 64);
    if(PlayerInfo[playerid][pWL] == 0) { WLTimer[playerid] = SetTimerEx("wltimer",5*60000,true,"d",playerid); }
	new wll = PlayerInfo[playerid][pWL]+=wl;
	if(wll > 100) { PlayerInfo[playerid][pWL] += wl; }
	else { PlayerInfo[playerid][pWL] += 1; }
	new str[200];
	format(str,sizeof(str),""crvena"Prijavio:"plava" %s "crvena"| Zlocin: "plava"%s "crvena"| WantedLevel: "plava"%d"crvena" |",prijavio,zlocin,wl);
	SCM(playerid,-1,str);
	UpdateWlPanel(playerid);
	return 1;
}

UpdateWlPanel(playerid)
{
	if(PlayerInfo[playerid][pWL] < 1)
	{
	    KillTimer(WLTimer[playerid]);
     	PlayerTextDrawHide(playerid,WlPanel[playerid][0]);
		PlayerTextDrawHide(playerid,WlPanel[playerid][1]);
		PlayerTextDrawHide(playerid,WlPanel[playerid][2]);
		PlayerTextDrawHide(playerid,WlPanel[playerid][3]);
		PlayerTextDrawHide(playerid,WlPanel[playerid][4]);
	}
	else
	{
	    new str[100],str1[100],str2[100];
     	format(str,sizeof(str),"~r~Prijavio: ~w~%s",PlayerInfo[playerid][pPrijavio]);
	 	PlayerTextDrawSetString(playerid,WlPanel[playerid][1],str);// prijavo pa zlocin pa wl
		format(str1,sizeof(str1),"~r~Zlocin: ~w~%s",PlayerInfo[playerid][pZlocin]);
		PlayerTextDrawSetString(playerid,WlPanel[playerid][2],str1);
		format(str2,sizeof(str2),"~r~WantedLevel: ~w~%d",PlayerInfo[playerid][pWL]);
		PlayerTextDrawSetString(playerid,WlPanel[playerid][3],str2);
		PlayerTextDrawShow(playerid,WlPanel[playerid][0]);
		PlayerTextDrawShow(playerid,WlPanel[playerid][1]);
		PlayerTextDrawShow(playerid,WlPanel[playerid][2]);
		PlayerTextDrawShow(playerid,WlPanel[playerid][3]);
		PlayerTextDrawShow(playerid,WlPanel[playerid][4]);
	}
	return 1;
}
GetPlayerWL(playerid) return PlayerInfo[playerid][pWL];

OcistiDosije(playerid)
{
	SetPlayerWantedLevel(playerid,0);
    PlayerInfo[playerid][pWL] = 0;
   	strmid(PlayerInfo[playerid][pPrijavio], "Nitko", 0, strlen("Nitko"), MAX_PLAYER_NAME);
	strmid(PlayerInfo[playerid][pZlocin], "Nema", 0, strlen("Nema"), 64);
    KillTimer(WLTimer[playerid]);
	UpdateWlPanel(playerid);
	return 1;
}
//==============================================================================
//droga system
enum dInfo
{
	dObject,
	Float:dX,
	Float:dY,
	Float:dZ,
	Float:dRotX,
	Float:dRotY,
	Float:dRotZ,
	bool:dUsed,
	dIzrasla
}
new DrogaInfo[MAX_PLAYERS][dInfo];
new DrogaTimer[MAX_PLAYERS];
new Text3D:DrogaText[MAX_PLAYERS];
//==============================================================================
//rent system
#define MAX_RENTS 200
#define RPATH "/Rents/%d.ini"

enum rInfo
{
	rID,
	rModel,
	Float:rX,
	Float:rY,
	Float:rZ,
	Float:rAZ,
	rColor1,
	rColor2,
	rRespawn
}
new RentInfo[MAX_RENTS][rInfo];
new bool:VoziloZaRent[MAX_VEHICLES];
new bool:VoziloRentano[MAX_VEHICLES];
new bool:RentaVozilo[MAX_PLAYERS];
new IdRentVozila[MAX_PLAYERS];
new RentVrijeme[MAX_PLAYERS];
new RentTimer[MAX_PLAYERS];
new Text3D:renttxt[MAX_RENTS];

enum eInfo
{
	eModel,
	eColor1,
	eColor2,
	eRespawn,
	eID
}
new EditInfo[MAX_PLAYERS][eInfo];

forward LoadRent(i,name[],value[]);
public LoadRent(i,name[],value[])
{
    INI_Int("ID",RentInfo[i][rID]);
    INI_Int("Model",RentInfo[i][rModel]);
	INI_Float("X",RentInfo[i][rX]);
	INI_Float("Y",RentInfo[i][rY]);
	INI_Float("Z",RentInfo[i][rZ]);
	INI_Float("AZ",RentInfo[i][rAZ]);
	INI_Int("Color1",RentInfo[i][rColor1]);
	INI_Int("Color2",RentInfo[i][rColor2]);
	INI_Int("Respawn",RentInfo[i][rRespawn]);
	return 1;
}

stock SacuvajRent(id)
{
	new str[50];
	format(str,sizeof(str),RPATH,id);
	new INI:File = INI_Open(str);
	INI_SetTag(File,"data");
	INI_WriteInt(File,"ID",RentInfo[id][rID]);
	INI_WriteInt(File,"Model",RentInfo[id][rModel]);
	INI_WriteFloat(File,"X",RentInfo[id][rX]);
	INI_WriteFloat(File,"Y",RentInfo[id][rY]);
	INI_WriteFloat(File,"Z",RentInfo[id][rZ]);
	INI_WriteFloat(File,"AZ",RentInfo[id][rAZ]);
	INI_WriteInt(File,"Color1",RentInfo[id][rColor1]);
	INI_WriteInt(File,"Color2",RentInfo[id][rColor2]);
	INI_WriteInt(File,"Respawn",RentInfo[id][rRespawn]);
	INI_Close(File);
	return 1;
}

LoadRents()
{
	static x;
    for(new i=0;i<MAX_RENTS;i++)
	{
		new str1[20];
	  	format(str1,sizeof(str1),RPATH,i);
		if(fexist(str1))
		{
		    INI_ParseFile(str1,"LoadRent",.bExtra = true,.extra = i);
			RentInfo[i][rID] = CreateVehicle(RentInfo[i][rModel],RentInfo[i][rX],RentInfo[i][rY],RentInfo[i][rZ],RentInfo[i][rAZ],RentInfo[i][rColor1],RentInfo[i][rColor2],RentInfo[i][rRespawn]);
			SetGorivo(RentInfo[i][rID]);
			VoziloZaRent[RentInfo[i][rID]] = true;
			VoziloRentano[RentInfo[i][rID]] = false;
			SetVehicleNumberPlate(RentInfo[i][rID],"RENT");
			renttxt[i] = Create3DTextLabel( "[ RENT ]", -1, RentInfo[i][rX],RentInfo[i][rY],RentInfo[i][rZ], 50.0, 0, 1 );
			Attach3DTextLabelToVehicle(renttxt[i],RentInfo[i][rID],0.0,0.0,0.0);
			x++;
		}
	}
	printf("Ucitano %d rent vozila!",x);
	return 1;
}

SacuvajSveRentove()
{
    for(new i=0;i<MAX_RENTS;i++)
	{
	    new str1[20];
	    format(str1,sizeof(str1),RPATH,i);
	    if(fexist(str1))
	    {
	        SacuvajRent(i);
		}
	}
	return 1;
}
//==============================================================================
//gang zone system
#define MAX_ZONA 13

#define FREE_ZONA_COLOR 0xC7C7C7AA

enum zInfo
{
	Float:zMinX,
	Float:zMinY,
	Float:zMaxX,
	Float:zMaxY,
	zPlaca
}
new ZonaInfo[MAX_ZONA][zInfo] =
{
	{-1127.0, -761.5,  -969.0,    -577.5, 2000},
	{-626.0,  -573.5,  -458.0,    -464.5, 1500},
	{-1480.0, -1618.5, -1394.0,   -1433.5, 1000},
	{675.0,   231.5,   822.0,   399.5, 1500},
	{995.0,   -382.5,  1134.0,  -270.5, 2000},
	{2074.0,  974.5,   2344.0,  1190.5, 4000},
	{2776.0,  831.5,   2894.0,  1023.5, 2500},
	{1414.0,  2717.5,  1544.0,  2885.5, 2300},
	{-1626.0, 2493.5,  -1355.0, 2720.5, 3000},
	{-2398.0, 61.5,    -2267.0, 245.5, 2400},
	{-2458.0, -648.5,  -2358.0, -548.5, 1500},
	{-2167.0, -1004.5, -1926.0, -712.5, 5500},
	{2669.0,  -2560.5, 2807.0,  -2505.5, 2000}
};
new zona[MAX_ZONA];
new zonatimer[MAX_ZONA];
new zonatime[MAX_ZONA];
new bool:zplaca;

#define ZPATH "/Zone/%d.ini"

enum zonInfo
{
	zOrgID
}
new ZonaInfo2[MAX_ZONA][zonInfo];

forward LoadZone(id,name[],value[]);
public LoadZone(id,name[],value[])
{
	INI_Int("OrgID",ZonaInfo2[id][zOrgID]);
	return 1;
}

stock SacuvajZonu(id)
{
	new str[50];
	format(str,sizeof(str),ZPATH,id);
	new INI:File = INI_Open(str);
	INI_SetTag(File,"data");
	INI_WriteInt(File,"OrgID",ZonaInfo2[id][zOrgID]);
	INI_Close(File);
	return 1;
}

KreirajZone()
{
	static x;
	for(new i=0;i<MAX_ZONA;i++)
	{
	    zona[i] = GangZoneCreate(ZonaInfo[i][zMinX],ZonaInfo[i][zMinY],ZonaInfo[i][zMaxX],ZonaInfo[i][zMaxY]);
	    new str[24];
	    format(str,sizeof(str),ZPATH,i);
	  	if(fexist(str))
		{
			INI_ParseFile(str,"LoadZone",.bExtra = true,.extra = i);
			if(ZonaInfo2[i][zOrgID] == POLICIJA || ZonaInfo2[i][zOrgID] >= MAX_ORGS) { ZonaInfo2[i][zOrgID] = -1; SacuvajZonu(i); }
		}
		else
		{
            ZonaInfo2[i][zOrgID] = -1;
			SacuvajZonu(i);
		}
		zonatime[i] = -1;
		x++;
	}
	printf("Kreirano %d zona!",x);
	return 1;
}

ShowGangZones(playerid,bool:show)
{
	if(show)
	{
	    for(new i=0;i<MAX_ZONA;i++)
		{
		    if(ZonaInfo2[i][zOrgID] == -1)
		    {
		    	GangZoneShowForPlayer(playerid,zona[i],FREE_ZONA_COLOR);
			}
			else
			{
			    GangZoneShowForPlayer(playerid,zona[i],OrgInfo[ZonaInfo2[i][zOrgID]][oColor]);
			}
		}
	}
	else
	{
	    for(new i=0;i<MAX_ZONA;i++)
		{
	    	GangZoneHideForPlayer(playerid,zona[i]);
		}
	}
	return 1;
}

IsPlayerInZone(playerid,zoneid)
{
    new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	if(x >= ZonaInfo[zoneid][zMinX] && x <= ZonaInfo[zoneid][zMaxX] && y >= ZonaInfo[zoneid][zMinY] && y <= ZonaInfo[zoneid][zMaxY] && zoneid >= 0 && zoneid < MAX_ZONA)
	{
	    return true;
	}
	return false;
}

stock GetPlayerZoneID(playerid)
{
	for(new i=0;i<MAX_ZONA;i++)
	{
		if(IsPlayerInZone(playerid,i)) return i;
	}
	return -1;
}
//==============================================================================
//stan system
#define STANPATH "/Stanovi/%d.ini"
#define MAX_STANOVA 1000

enum stanInfo
{
	bool:sOwned,
	sOwnerName[MAX_PLAYER_NAME],
	sLevel,
	sName[MAX_PLAYER_NAME],
	sPrice,
	Float:sUlazX,
	Float:sUlazY,
	Float:sUlazZ,
	Float:sIzlazX,
	Float:sIzlazY,
	Float:sIzlazZ,
	sUnutraPic,
	sIzvanPic,
	sVrsta,
	sVW,
	sInterior,
	sMoney,
	bool:sLocked,
	sOruzje[3],
	sMunicija[3],
	sDroga,
	sMats
}
new StanInfo[MAX_STANOVA][stanInfo];
new Text3D:sText[MAX_STANOVA];

forward LoadStan(id,name[],value[]);
public LoadStan(id,name[],value[])
{
	INI_Bool("Owned",StanInfo[id][sOwned]);
	INI_String("OwnerName",StanInfo[id][sOwnerName],MAX_PLAYER_NAME);
	INI_Int("Level",StanInfo[id][sLevel]);
	INI_String("Name",StanInfo[id][sName],MAX_PLAYER_NAME);
	INI_Int("Price",StanInfo[id][sPrice]);
	INI_Float("UlazX",StanInfo[id][sUlazX]);
	INI_Float("UlazY",StanInfo[id][sUlazY]);
	INI_Float("UlazZ",StanInfo[id][sUlazZ]);
	INI_Float("IzlazX",StanInfo[id][sIzlazX]);
	INI_Float("IzlazY",StanInfo[id][sIzlazY]);
	INI_Float("IzlazZ",StanInfo[id][sIzlazZ]);
	INI_Int("UnutraPic",StanInfo[id][sUnutraPic]);
	INI_Int("IzvanPic",StanInfo[id][sIzvanPic]);
	INI_Int("Vrsta",StanInfo[id][sVrsta]);
	INI_Int("VW",StanInfo[id][sVW]);
	INI_Int("Interior",StanInfo[id][sInterior]);
	INI_Int("Money",StanInfo[id][sMoney]);
	INI_Bool("Locked",StanInfo[id][sLocked]);
	INI_Int("Oruzje1",StanInfo[id][sOruzje][0]);
	INI_Int("Municija1",StanInfo[id][sMunicija][0]);
	INI_Int("Oruzje2",StanInfo[id][sOruzje][1]);
	INI_Int("Municija2",StanInfo[id][sMunicija][1]);
	INI_Int("Oruzje3",StanInfo[id][sOruzje][2]);
	INI_Int("Municija3",StanInfo[id][sMunicija][2]);
	INI_Int("Droga",StanInfo[id][sDroga]);
	INI_Int("Mats",StanInfo[id][sMats]);
	return 1;
}

SacuvajStan(id)
{
	new str[50];
	format(str,sizeof(str),STANPATH,id);
	new INI:File = INI_Open(str);
	INI_SetTag(File,"data");
	INI_WriteBool(File,"Owned",StanInfo[id][sOwned]);
	INI_WriteString(File,"OwnerName",StanInfo[id][sOwnerName]);
	INI_WriteInt(File,"Level",StanInfo[id][sLevel]);
	INI_WriteString(File,"Name",StanInfo[id][sName]);
	INI_WriteInt(File,"Price",StanInfo[id][sPrice]);
	INI_WriteFloat(File,"UlazX",StanInfo[id][sUlazX]);
	INI_WriteFloat(File,"UlazY",StanInfo[id][sUlazY]);
	INI_WriteFloat(File,"UlazZ",StanInfo[id][sUlazZ]);
	INI_WriteFloat(File,"IzlazX",StanInfo[id][sIzlazX]);
	INI_WriteFloat(File,"IzlazY",StanInfo[id][sIzlazY]);
	INI_WriteFloat(File,"IzlazZ",StanInfo[id][sIzlazZ]);
	INI_WriteInt(File,"UnutraPic",StanInfo[id][sUnutraPic]);
	INI_WriteInt(File,"IzvanPic",StanInfo[id][sIzvanPic]);
	INI_WriteInt(File,"Vrsta",StanInfo[id][sVrsta]);
	INI_WriteInt(File,"VW",StanInfo[id][sVW]);
	INI_WriteInt(File,"Interior",StanInfo[id][sInterior]);
	INI_WriteInt(File,"Money",StanInfo[id][sMoney]);
	INI_WriteBool(File,"Locked",StanInfo[id][sLocked]);
	INI_WriteInt(File,"Oruzje1",StanInfo[id][sOruzje][0]);
	INI_WriteInt(File,"Municija1",StanInfo[id][sMunicija][0]);
	INI_WriteInt(File,"Oruzje2",StanInfo[id][sOruzje][1]);
	INI_WriteInt(File,"Municija2",StanInfo[id][sMunicija][1]);
	INI_WriteInt(File,"Oruzje3",StanInfo[id][sOruzje][2]);
	INI_WriteInt(File,"Municija3",StanInfo[id][sMunicija][2]);
	INI_WriteInt(File,"Droga",StanInfo[id][sDroga]);
	INI_WriteInt(File,"Mats",StanInfo[id][sMats]);
	INI_Close(File);
	return 1;
}

StanLP(id)
{
	if(!StanInfo[id][sOwned])
	{
	    new str[200];
     	format(str,sizeof(str),""zuta"Stan na prodaju!\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\n"zuta"Da kupite stan upisite "bijela"'/kupistan'",StanInfo[id][sName],StanInfo[id][sLevel],StanInfo[id][sPrice]);
        Update3DTextLabelText(sText[id], -1, str);
	}
	else if(StanInfo[id][sOwned])
	{
	    new str[200];
	    format(str,sizeof(str),""bijela"Vlasnik: "plava"%s\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$",StanInfo[id][sOwnerName],StanInfo[id][sName],StanInfo[id][sLevel],StanInfo[id][sPrice]);
		Update3DTextLabelText(sText[id], -1, str);
	}
	return 1;
}

LoadStanove()
{
	static x;
	for(new i=0;i<MAX_STANOVA;i++)
	{
	    new str1[20];
	    format(str1,sizeof(str1),STANPATH,i);
 		INI_ParseFile(str1,"LoadStan",.bExtra = true,.extra = i);
	    if(fexist(str1))
	    {
			if(!StanInfo[i][sOwned])
			{
			    new str[200];
			    format(str,sizeof(str),""zuta"Stan na prodaju!\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\n"zuta"Da kupite stan upisite "bijela"'/kupistan'",StanInfo[i][sName],StanInfo[i][sLevel],StanInfo[i][sPrice]);
				sText[i] = Create3DTextLabel(str, -1, StanInfo[i][sUlazX], StanInfo[i][sUlazY], StanInfo[i][sUlazZ], 20.0, 0, 0);
			}
			else if(StanInfo[i][sOwned])
			{
			    new str[200];
			    format(str,sizeof(str),""bijela"Vlasnik: "plava"%s\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$",StanInfo[i][sOwnerName],StanInfo[i][sName],StanInfo[i][sLevel],StanInfo[i][sPrice]);
				sText[i] = Create3DTextLabel(str, -1, StanInfo[i][sUlazX], StanInfo[i][sUlazY], StanInfo[i][sUlazZ], 20.0, 0, 0);
			}
			StanInfo[i][sVW] = i;
	  		StanInfo[i][sUnutraPic] = CreateDynamicPickup(1239, 1, StanInfo[i][sIzlazX], StanInfo[i][sIzlazY], StanInfo[i][sIzlazZ], StanInfo[i][sVW]);
			StanInfo[i][sIzvanPic] = CreateDynamicPickup(19524, 1, StanInfo[i][sUlazX], StanInfo[i][sUlazY], StanInfo[i][sUlazZ], 0);
			x++;
		}
	}
	printf("Ucitano %d stanova!",x);
	return 1;
}

GetStan(playerid)
{
	for(new i=0;i<MAX_STANOVA;i++)
	{
	    if(IsPlayerInRangeOfPoint(playerid,2.0,StanInfo[i][sUlazX], StanInfo[i][sUlazY], StanInfo[i][sUlazZ])) return i;
	}
	return -1;
}

SacuvajSveStanove()
{
    for(new i=0;i<MAX_STANOVA;i++)
	{
	    new str1[20];
	    format(str1,sizeof(str1),STANPATH,i);
	    if(fexist(str1))
	    {
	        SacuvajStan(i);
		}
	}
	return 1;
}
//==============================================================================
CreateTextDraws()
{
	//registracija
    reg[0] = TextDrawCreate(-0.999997, 0.429598, "box");
	TextDrawLetterSize(reg[0], 0.000000, 49.733318);
	TextDrawTextSize(reg[0], 226.000000, 0.000000);
	TextDrawAlignment(reg[0], 1);
	TextDrawColor(reg[0], -1);
	TextDrawUseBox(reg[0], 1);
	TextDrawBoxColor(reg[0], 170);
	TextDrawSetShadow(reg[0], 0);
	TextDrawSetOutline(reg[0], 0);
	TextDrawBackgroundColor(reg[0], 255);
	TextDrawFont(reg[0], 1);
	TextDrawSetProportional(reg[0], 1);
	TextDrawSetShadow(reg[0], 0);

	reg[1] = TextDrawCreate(54.333324, 85.466674, "P");
	TextDrawLetterSize(reg[1], 0.908666, 4.727704);
	TextDrawAlignment(reg[1], 1);
	TextDrawColor(reg[1], 111738879);
	TextDrawSetShadow(reg[1], 0);
	TextDrawSetOutline(reg[1], -2);
	TextDrawBackgroundColor(reg[1], 255);
	TextDrawFont(reg[1], 1);
	TextDrawSetProportional(reg[1], 1);
	TextDrawSetShadow(reg[1], 0);

	reg[2] = TextDrawCreate(72.666656, 99.985198, "X");
	TextDrawLetterSize(reg[2], 0.640330, 2.898370);
	TextDrawAlignment(reg[2], 1);
	TextDrawColor(reg[2], -1);
	TextDrawSetShadow(reg[2], 0);
	TextDrawSetOutline(reg[2], -1);
	TextDrawBackgroundColor(reg[2], 111738879);
	TextDrawFont(reg[2], 1);
	TextDrawSetProportional(reg[2], 1);
	TextDrawSetShadow(reg[2], 0);

	reg[3] = TextDrawCreate(92.000030, 103.303672, "-_Registracija~n~");
	TextDrawLetterSize(reg[3], 0.467999, 2.035552);
	TextDrawAlignment(reg[3], 1);
	TextDrawColor(reg[3], -1);
	TextDrawSetShadow(reg[3], 0);
	TextDrawSetOutline(reg[3], 257);
	TextDrawBackgroundColor(reg[3], 255);
	TextDrawFont(reg[3], 1);
	TextDrawSetProportional(reg[3], 1);
	TextDrawSetShadow(reg[3], 0);

	reg[4] = TextDrawCreate(4.666662, 155.155578, "Lozinka_-");
	TextDrawLetterSize(reg[4], 0.417665, 1.765925);
	TextDrawAlignment(reg[4], 1);
	TextDrawColor(reg[4], 111738879);
	TextDrawSetShadow(reg[4], 0);
	TextDrawSetOutline(reg[4], 0);
	TextDrawBackgroundColor(reg[4], 255);
	TextDrawFont(reg[4], 1);
	TextDrawSetProportional(reg[4], 1);
	TextDrawSetShadow(reg[4], 0);

	reg[5] = TextDrawCreate(4.666662, 176.956909, "Mail_-");
	TextDrawLetterSize(reg[5], 0.417665, 1.765925);
	TextDrawAlignment(reg[5], 1);
	TextDrawColor(reg[5], 111738879);
	TextDrawSetShadow(reg[5], 0);
	TextDrawSetOutline(reg[5], 0);
	TextDrawBackgroundColor(reg[5], 255);
	TextDrawFont(reg[5], 1);
	TextDrawSetProportional(reg[5], 1);
	TextDrawSetShadow(reg[5], 0);

	reg[6] = TextDrawCreate(4.666662, 199.958312, "Godine_-");
	TextDrawLetterSize(reg[6], 0.417665, 1.765925);
	TextDrawAlignment(reg[6], 1);
	TextDrawColor(reg[6], 111738879);
	TextDrawSetShadow(reg[6], 0);
	TextDrawSetOutline(reg[6], 0);
	TextDrawBackgroundColor(reg[6], 255);
	TextDrawFont(reg[6], 1);
	TextDrawSetProportional(reg[6], 1);
	TextDrawSetShadow(reg[6], 0);

	reg[7] = TextDrawCreate(4.666662, 221.259613, "Drzava_-");
	TextDrawLetterSize(reg[7], 0.417665, 1.765925);
	TextDrawAlignment(reg[7], 1);
	TextDrawColor(reg[7], 111738879);
	TextDrawSetShadow(reg[7], 0);
	TextDrawSetOutline(reg[7], 0);
	TextDrawBackgroundColor(reg[7], 255);
	TextDrawFont(reg[7], 1);
	TextDrawSetProportional(reg[7], 1);
	TextDrawSetShadow(reg[7], 0);

	reg[8] = TextDrawCreate(4.666662, 241.160827, "Spol_-");
	TextDrawLetterSize(reg[8], 0.417665, 1.765925);
	TextDrawAlignment(reg[8], 1);
	TextDrawColor(reg[8], 111738879);
	TextDrawSetShadow(reg[8], 0);
	TextDrawSetOutline(reg[8], 0);
	TextDrawBackgroundColor(reg[8], 255);
	TextDrawFont(reg[8], 1);
	TextDrawSetProportional(reg[8], 1);
	TextDrawSetShadow(reg[8], 0);

	reg[9] = TextDrawCreate(7.000057, 319.681457, "");
	TextDrawLetterSize(reg[9], 0.000000, 0.000000);
	TextDrawTextSize(reg[9], 36.000000, 33.000000);
	TextDrawAlignment(reg[9], 1);
	TextDrawColor(reg[9], 111738879);
	TextDrawSetShadow(reg[9], 0);
	TextDrawSetOutline(reg[9], 0);
	TextDrawBackgroundColor(reg[9], 268435456);
	TextDrawFont(reg[9], 5);
	TextDrawSetProportional(reg[9], 0);
	TextDrawSetShadow(reg[9], 0);
	TextDrawSetSelectable(reg[9], true);
	TextDrawSetPreviewModel(reg[9], 1318);
	TextDrawSetPreviewRot(reg[9], 0.000000, 270.000000, 90.000000, 1.000000);

	reg[10] = TextDrawCreate(151.333404, 317.192626, "");
	TextDrawLetterSize(reg[10], 0.000000, 0.000000);
	TextDrawTextSize(reg[10], 36.000000, 33.000000);
	TextDrawAlignment(reg[10], 1);
	TextDrawColor(reg[10], 111738879);
	TextDrawSetShadow(reg[10], 0);
	TextDrawSetOutline(reg[10], 0);
	TextDrawBackgroundColor(reg[10], 268435456);
	TextDrawFont(reg[10], 5);
	TextDrawSetProportional(reg[10], 0);
	TextDrawSetShadow(reg[10], 0);
	TextDrawSetSelectable(reg[10], true);
	TextDrawSetPreviewModel(reg[10], 1318);
	TextDrawSetPreviewRot(reg[10], 180.000000, 90.000000, 90.000000, 1.000000);

	reg[11] = TextDrawCreate(7.633034, 391.143066, "REGISTRACIJA");
	TextDrawLetterSize(reg[11], 0.268332, 1.832296);
	TextDrawTextSize(reg[11], 70.000000, 10.119998);
	TextDrawAlignment(reg[11], 1);
	TextDrawColor(reg[11], -1);
	TextDrawUseBox(reg[11], 1);
	TextDrawBoxColor(reg[11], 268435456);
	TextDrawSetShadow(reg[11], 0);
	TextDrawSetOutline(reg[11], 0);
	TextDrawBackgroundColor(reg[11], 255);
	TextDrawFont(reg[11], 1);
	TextDrawSetProportional(reg[11], 1);
	TextDrawSetShadow(reg[11], 0);
	TextDrawSetSelectable(reg[11], true);

	reg[12] = TextDrawCreate(121.299697, 390.313415, "IZADITE");
	TextDrawLetterSize(reg[12], 0.268332, 1.832296);
	TextDrawTextSize(reg[12], 157.000000, 10.119998);
	TextDrawAlignment(reg[12], 1);
	TextDrawColor(reg[12], -1);
	TextDrawUseBox(reg[12], 1);
	TextDrawBoxColor(reg[12], 268435456);
	TextDrawSetShadow(reg[12], 0);
	TextDrawSetOutline(reg[12], 0);
	TextDrawBackgroundColor(reg[12], 255);
	TextDrawFont(reg[12], 1);
	TextDrawSetProportional(reg[12], 1);
	TextDrawSetShadow(reg[12], 0);
	TextDrawSetSelectable(reg[12], true);

	reg[13] = TextDrawCreate(178.000091, 434.740753, "since~n~");
	TextDrawLetterSize(reg[13], 0.298666, 1.214221);
	TextDrawAlignment(reg[13], 1);
	TextDrawColor(reg[13], -1);
	TextDrawSetShadow(reg[13], 0);
	TextDrawSetOutline(reg[13], 0);
	TextDrawBackgroundColor(reg[13], 255);
	TextDrawFont(reg[13], 1);
	TextDrawSetProportional(reg[13], 1);
	TextDrawSetShadow(reg[13], 0);

	reg[14] = TextDrawCreate(203.666763, 435.155761, "2017");
	TextDrawLetterSize(reg[14], 0.269333, 1.164443);
	TextDrawAlignment(reg[14], 1);
	TextDrawColor(reg[14], 111738879);
	TextDrawSetShadow(reg[14], 0);
	TextDrawSetOutline(reg[14], 0);
	TextDrawBackgroundColor(reg[14], 255);
	TextDrawFont(reg[14], 1);
	TextDrawSetProportional(reg[14], 1);
	TextDrawSetShadow(reg[14], 0);
	//--------------------------------------------------------------------------
	//bankomati
	BankomatTD[0] = TextDrawCreate(62.666648, 35.118526, "");
	TextDrawLetterSize(BankomatTD[0], 0.000000, 0.000000);
	TextDrawTextSize(BankomatTD[0], 449.000000, 396.000000);
	TextDrawAlignment(BankomatTD[0], 1);
	TextDrawColor(BankomatTD[0], -1);
	TextDrawSetShadow(BankomatTD[0], 0);
	TextDrawSetOutline(BankomatTD[0], 0);
	TextDrawBackgroundColor(BankomatTD[0], 268435456);
	TextDrawFont(BankomatTD[0], 5);
	TextDrawSetProportional(BankomatTD[0], 0);
	TextDrawSetShadow(BankomatTD[0], 0);
	TextDrawSetPreviewModel(BankomatTD[0], 19324);
	TextDrawSetPreviewRot(BankomatTD[0], -50.000000, 0.000000, 180.000000, 1.000000);

	BankomatTD[1] = TextDrawCreate(247.000045, 197.725906, "");
	TextDrawLetterSize(BankomatTD[1], 0.000000, 0.000000);
	TextDrawTextSize(BankomatTD[1], 58.000000, 64.000000);
	TextDrawAlignment(BankomatTD[1], 1);
	TextDrawColor(BankomatTD[1], -1);
	TextDrawSetShadow(BankomatTD[1], 0);
	TextDrawSetOutline(BankomatTD[1], 0);
	TextDrawBackgroundColor(BankomatTD[1], 255);
	TextDrawFont(BankomatTD[1], 5);
	TextDrawSetProportional(BankomatTD[1], 0);
	TextDrawSetShadow(BankomatTD[1], 0);
	TextDrawSetPreviewModel(BankomatTD[1], 14772);
	TextDrawSetPreviewRot(BankomatTD[1], 0.000000, 0.000000, 0.000000, 0.000000);

	BankomatTD[2] = TextDrawCreate(294.666748, 210.585220, "ld_pool:ball");
	TextDrawLetterSize(BankomatTD[2], 0.000000, 0.000000);
	TextDrawTextSize(BankomatTD[2], 8.000000, 8.000000);
	TextDrawAlignment(BankomatTD[2], 1);
	TextDrawColor(BankomatTD[2], -2139062017);
	TextDrawSetShadow(BankomatTD[2], 0);
	TextDrawSetOutline(BankomatTD[2], 0);
	TextDrawBackgroundColor(BankomatTD[2], 255);
	TextDrawFont(BankomatTD[2], 4);
	TextDrawSetProportional(BankomatTD[2], 0);
	TextDrawSetShadow(BankomatTD[2], 0);
	TextDrawSetSelectable(BankomatTD[2], true);

	BankomatTD[3] = TextDrawCreate(294.666748, 227.486251, "ld_pool:ball");
	TextDrawLetterSize(BankomatTD[3], 0.000000, 0.000000);
	TextDrawTextSize(BankomatTD[3], 8.000000, 8.000000);
	TextDrawAlignment(BankomatTD[3], 1);
	TextDrawColor(BankomatTD[3], -2139062017);
	TextDrawSetShadow(BankomatTD[3], 0);
	TextDrawSetOutline(BankomatTD[3], 0);
	TextDrawBackgroundColor(BankomatTD[3], 255);
	TextDrawFont(BankomatTD[3], 4);
	TextDrawSetProportional(BankomatTD[3], 0);
	TextDrawSetShadow(BankomatTD[3], 0);
	TextDrawSetSelectable(BankomatTD[3], true);

	BankomatTD[4] = TextDrawCreate(294.666748, 244.087265, "ld_pool:ball");
	TextDrawLetterSize(BankomatTD[4], 0.000000, 0.000000);
	TextDrawTextSize(BankomatTD[4], 8.000000, 8.000000);
	TextDrawAlignment(BankomatTD[4], 1);
	TextDrawColor(BankomatTD[4], -2139062017);
	TextDrawSetShadow(BankomatTD[4], 0);
	TextDrawSetOutline(BankomatTD[4], 0);
	TextDrawBackgroundColor(BankomatTD[4], 255);
	TextDrawFont(BankomatTD[4], 4);
	TextDrawSetProportional(BankomatTD[4], 0);
	TextDrawSetShadow(BankomatTD[4], 0);
	TextDrawSetSelectable(BankomatTD[4], true);

	BankomatTD[5] = TextDrawCreate(249.666656, 209.911056, "Stanje");
	TextDrawLetterSize(BankomatTD[5], 0.327333, 0.845035);
	TextDrawAlignment(BankomatTD[5], 1);
	TextDrawColor(BankomatTD[5], -1);
	TextDrawSetShadow(BankomatTD[5], 0);
	TextDrawSetOutline(BankomatTD[5], 1);
	TextDrawBackgroundColor(BankomatTD[5], 255);
	TextDrawFont(BankomatTD[5], 1);
	TextDrawSetProportional(BankomatTD[5], 1);
	TextDrawSetShadow(BankomatTD[5], 0);

	BankomatTD[6] = TextDrawCreate(249.666656, 226.612075, "Podigni");
	TextDrawLetterSize(BankomatTD[6], 0.327333, 0.845035);
	TextDrawAlignment(BankomatTD[6], 1);
	TextDrawColor(BankomatTD[6], -1);
	TextDrawSetShadow(BankomatTD[6], 0);
	TextDrawSetOutline(BankomatTD[6], 1);
	TextDrawBackgroundColor(BankomatTD[6], 255);
	TextDrawFont(BankomatTD[6], 1);
	TextDrawSetProportional(BankomatTD[6], 1);
	TextDrawSetShadow(BankomatTD[6], 0);

	BankomatTD[7] = TextDrawCreate(249.666656, 243.713119, "Izvadi~n~karticu");
	TextDrawLetterSize(BankomatTD[7], 0.327333, 0.845035);
	TextDrawAlignment(BankomatTD[7], 1);
	TextDrawColor(BankomatTD[7], -1);
	TextDrawSetShadow(BankomatTD[7], 0);
	TextDrawSetOutline(BankomatTD[7], 1);
	TextDrawBackgroundColor(BankomatTD[7], 255);
	TextDrawFont(BankomatTD[7], 1);
	TextDrawSetProportional(BankomatTD[7], 1);
	TextDrawSetShadow(BankomatTD[7], 0);
	//--------------------------------------------------------------------------
	//ig textdraws
	IgTextDraws[0] = TextDrawCreate(10.666695, 432.666778, "box");
	TextDrawLetterSize(IgTextDraws[0], 0.000000, 1.333333);
	TextDrawTextSize(IgTextDraws[0], 625.000000, 0.000000);
	TextDrawAlignment(IgTextDraws[0], 1);
	TextDrawColor(IgTextDraws[0], -1);
	TextDrawUseBox(IgTextDraws[0], 1);
	TextDrawBoxColor(IgTextDraws[0], 255);
	TextDrawSetShadow(IgTextDraws[0], 0);
	TextDrawSetOutline(IgTextDraws[0], 0);
	TextDrawBackgroundColor(IgTextDraws[0], 255);
	TextDrawFont(IgTextDraws[0], 1);
	TextDrawSetProportional(IgTextDraws[0], 1);
	TextDrawSetShadow(IgTextDraws[0], 0);

	IgTextDraws[1] = TextDrawCreate(2.999989, 429.607330, "ld_pool:ball");
	TextDrawLetterSize(IgTextDraws[1], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[1], 19.000000, 18.000000);
	TextDrawAlignment(IgTextDraws[1], 1);
	TextDrawColor(IgTextDraws[1], 111738879);
	TextDrawSetShadow(IgTextDraws[1], 0);
	TextDrawSetOutline(IgTextDraws[1], 0);
	TextDrawBackgroundColor(IgTextDraws[1], 255);
	TextDrawFont(IgTextDraws[1], 4);
	TextDrawSetProportional(IgTextDraws[1], 0);
	TextDrawSetShadow(IgTextDraws[1], 0);

	IgTextDraws[2] = TextDrawCreate(618.266906, 429.292572, "ld_pool:ball");
	TextDrawLetterSize(IgTextDraws[2], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[2], 19.000000, 18.000000);
	TextDrawAlignment(IgTextDraws[2], 1);
	TextDrawColor(IgTextDraws[2], 111738879);
	TextDrawSetShadow(IgTextDraws[2], 0);
	TextDrawSetOutline(IgTextDraws[2], 0);
	TextDrawBackgroundColor(IgTextDraws[2], 255);
	TextDrawFont(IgTextDraws[2], 4);
	TextDrawSetProportional(IgTextDraws[2], 0);
	TextDrawSetShadow(IgTextDraws[2], 0);

	IgTextDraws[3] = TextDrawCreate(26.199985, 433.081573, "12:10:10");
	TextDrawLetterSize(IgTextDraws[3], 0.326665, 1.122961);
	TextDrawAlignment(IgTextDraws[3], 1);
	TextDrawColor(IgTextDraws[3], -1);
	TextDrawSetShadow(IgTextDraws[3], 0);
	TextDrawSetOutline(IgTextDraws[3], 0);
	TextDrawBackgroundColor(IgTextDraws[3], 255);
	TextDrawFont(IgTextDraws[3], 1);
	TextDrawSetProportional(IgTextDraws[3], 1);
	TextDrawSetShadow(IgTextDraws[3], 0);

	IgTextDraws[4] = TextDrawCreate(75.902122, 429.292602, "ld_pool:ball");
	TextDrawLetterSize(IgTextDraws[4], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[4], 19.000000, 18.000000);
	TextDrawAlignment(IgTextDraws[4], 1);
	TextDrawColor(IgTextDraws[4], 111738879);
	TextDrawSetShadow(IgTextDraws[4], 0);
	TextDrawSetOutline(IgTextDraws[4], 0);
	TextDrawBackgroundColor(IgTextDraws[4], 255);
	TextDrawFont(IgTextDraws[4], 4);
	TextDrawSetProportional(IgTextDraws[4], 0);
	TextDrawSetShadow(IgTextDraws[4], 0);

	IgTextDraws[5] = TextDrawCreate(551.604431, 433.011138, "24/08/2018");
	TextDrawLetterSize(IgTextDraws[5], 0.326665, 1.122961);
	TextDrawAlignment(IgTextDraws[5], 1);
	TextDrawColor(IgTextDraws[5], -1);
	TextDrawSetShadow(IgTextDraws[5], 0);
	TextDrawSetOutline(IgTextDraws[5], 0);
	TextDrawBackgroundColor(IgTextDraws[5], 255);
	TextDrawFont(IgTextDraws[5], 1);
	TextDrawSetProportional(IgTextDraws[5], 1);
	TextDrawSetShadow(IgTextDraws[5], 0);

	IgTextDraws[6] = TextDrawCreate(527.321899, 430.122161, "ld_pool:ball");
	TextDrawLetterSize(IgTextDraws[6], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[6], 19.000000, 17.000000);
	TextDrawAlignment(IgTextDraws[6], 1);
	TextDrawColor(IgTextDraws[6], 111738879);
	TextDrawSetShadow(IgTextDraws[6], 0);
	TextDrawSetOutline(IgTextDraws[6], 0);
	TextDrawBackgroundColor(IgTextDraws[6], 255);
	TextDrawFont(IgTextDraws[6], 4);
	TextDrawSetProportional(IgTextDraws[6], 0);
	TextDrawSetShadow(IgTextDraws[6], 0);

	IgTextDraws[7] = TextDrawCreate(161.988540, 412.699829, "ld_pool:ball");
	TextDrawLetterSize(IgTextDraws[7], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[7], 17.000000, 15.000000);
	TextDrawAlignment(IgTextDraws[7], 1);
	TextDrawColor(IgTextDraws[7], 111738879);
	TextDrawSetShadow(IgTextDraws[7], 0);
	TextDrawSetOutline(IgTextDraws[7], 0);
	TextDrawBackgroundColor(IgTextDraws[7], 255);
	TextDrawFont(IgTextDraws[7], 4);
	TextDrawSetProportional(IgTextDraws[7], 0);
	TextDrawSetShadow(IgTextDraws[7], 0);

	IgTextDraws[8] = TextDrawCreate(448.738220, 412.355438, "ld_pool:ball");
	TextDrawLetterSize(IgTextDraws[8], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[8], 17.000000, 15.000000);
	TextDrawAlignment(IgTextDraws[8], 1);
	TextDrawColor(IgTextDraws[8], 111738879);
	TextDrawSetShadow(IgTextDraws[8], 0);
	TextDrawSetOutline(IgTextDraws[8], 0);
	TextDrawBackgroundColor(IgTextDraws[8], 255);
	TextDrawFont(IgTextDraws[8], 4);
	TextDrawSetProportional(IgTextDraws[8], 0);
	TextDrawSetShadow(IgTextDraws[8], 0);

	IgTextDraws[9] = TextDrawCreate(171.666687, 414.000061, "box");
	TextDrawLetterSize(IgTextDraws[9], 0.000000, 1.366667);
	TextDrawTextSize(IgTextDraws[9], 456.000000, 0.000000);
	TextDrawAlignment(IgTextDraws[9], 1);
	TextDrawColor(IgTextDraws[9], -1);
	TextDrawUseBox(IgTextDraws[9], 1);
	TextDrawBoxColor(IgTextDraws[9], 255);
	TextDrawSetShadow(IgTextDraws[9], 0);
	TextDrawSetOutline(IgTextDraws[9], 0);
	TextDrawBackgroundColor(IgTextDraws[9], 255);
	TextDrawFont(IgTextDraws[9], 1);
	TextDrawSetProportional(IgTextDraws[9], 1);
	TextDrawSetShadow(IgTextDraws[9], 0);

	IgTextDraws[10] = TextDrawCreate(262.738220, 433.925842, "ld_pool:ball");
	TextDrawLetterSize(IgTextDraws[10], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[10], 12.000000, 12.000000);
	TextDrawAlignment(IgTextDraws[10], 1);
	TextDrawColor(IgTextDraws[10], 111738879);
	TextDrawSetShadow(IgTextDraws[10], 0);
	TextDrawSetOutline(IgTextDraws[10], 0);
	TextDrawBackgroundColor(IgTextDraws[10], 255);
	TextDrawFont(IgTextDraws[10], 4);
	TextDrawSetProportional(IgTextDraws[10], 0);
	TextDrawSetShadow(IgTextDraws[10], 0);

	IgTextDraws[11] = TextDrawCreate(355.505035, 433.981506, "ld_pool:ball");
	TextDrawLetterSize(IgTextDraws[11], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[11], 12.000000, 12.000000);
	TextDrawAlignment(IgTextDraws[11], 1);
	TextDrawColor(IgTextDraws[11], 111738879);
	TextDrawSetShadow(IgTextDraws[11], 0);
	TextDrawSetOutline(IgTextDraws[11], 0);
	TextDrawBackgroundColor(IgTextDraws[11], 255);
	TextDrawFont(IgTextDraws[11], 4);
	TextDrawSetProportional(IgTextDraws[11], 0);
	TextDrawSetShadow(IgTextDraws[11], 0);

	IgTextDraws[12] = TextDrawCreate(269.666534, 435.585052, "box");
	TextDrawLetterSize(IgTextDraws[12], 0.000000, 0.966666);
	TextDrawTextSize(IgTextDraws[12], 361.000000, 0.000000);
	TextDrawAlignment(IgTextDraws[12], 1);
	TextDrawColor(IgTextDraws[12], 111738879);
	TextDrawUseBox(IgTextDraws[12], 1);
	TextDrawBoxColor(IgTextDraws[12], 255);
	TextDrawSetShadow(IgTextDraws[12], 0);
	TextDrawSetOutline(IgTextDraws[12], 0);
	TextDrawBackgroundColor(IgTextDraws[12], 255);
	TextDrawFont(IgTextDraws[12], 1);
	TextDrawSetProportional(IgTextDraws[12], 1);
	TextDrawSetShadow(IgTextDraws[12], 0);

	IgTextDraws[13] = TextDrawCreate(288.333435, 432.666625, "Project");
	TextDrawLetterSize(IgTextDraws[13], 0.357998, 1.376000);
	TextDrawAlignment(IgTextDraws[13], 1);
	TextDrawColor(IgTextDraws[13], -1);
	TextDrawSetShadow(IgTextDraws[13], 0);
	TextDrawSetOutline(IgTextDraws[13], 0);
	TextDrawBackgroundColor(IgTextDraws[13], 255);
	TextDrawFont(IgTextDraws[13], 1);
	TextDrawSetProportional(IgTextDraws[13], 1);
	TextDrawSetShadow(IgTextDraws[13], 0);

	IgTextDraws[14] = TextDrawCreate(330.333221, 431.422302, "X");
	TextDrawLetterSize(IgTextDraws[14], 0.400000, 1.600000);
	TextDrawAlignment(IgTextDraws[14], 1);
	TextDrawColor(IgTextDraws[14], 111738879);
	TextDrawSetShadow(IgTextDraws[14], 0);
	TextDrawSetOutline(IgTextDraws[14], 0);
	TextDrawBackgroundColor(IgTextDraws[14], 255);
	TextDrawFont(IgTextDraws[14], 1);
	TextDrawSetProportional(IgTextDraws[14], 1);
	TextDrawSetShadow(IgTextDraws[14], 0);

	IgTextDraws[15] = TextDrawCreate(133.937744, 433.425903, "Online:_1000");
	TextDrawLetterSize(IgTextDraws[15], 0.326665, 1.122961);
	TextDrawAlignment(IgTextDraws[15], 1);
	TextDrawColor(IgTextDraws[15], -1);
	TextDrawSetShadow(IgTextDraws[15], 0);
	TextDrawSetOutline(IgTextDraws[15], 0);
	TextDrawBackgroundColor(IgTextDraws[15], 255);
	TextDrawFont(IgTextDraws[15], 1);
	TextDrawSetProportional(IgTextDraws[15], 1);
	TextDrawSetShadow(IgTextDraws[15], 0);

	IgTextDraws[16] = TextDrawCreate(411.638153, 434.370330, "Rekord:1000");
	TextDrawLetterSize(IgTextDraws[16], 0.326665, 1.122961);
	TextDrawAlignment(IgTextDraws[16], 1);
	TextDrawColor(IgTextDraws[16], -1);
	TextDrawSetShadow(IgTextDraws[16], 0);
	TextDrawSetOutline(IgTextDraws[16], 0);
	TextDrawBackgroundColor(IgTextDraws[16], 255);
	TextDrawFont(IgTextDraws[16], 1);
	TextDrawSetProportional(IgTextDraws[16], 1);
	TextDrawSetShadow(IgTextDraws[16], 0);

	IgTextDraws[17] = TextDrawCreate(306.666931, 414.400085, "Trebate_pomoc?_Upisite_/askq!");
	TextDrawLetterSize(IgTextDraws[17], 0.232333, 1.122962);
	TextDrawAlignment(IgTextDraws[17], 2);
	TextDrawColor(IgTextDraws[17], -1);
	TextDrawSetShadow(IgTextDraws[17], 0);
	TextDrawSetOutline(IgTextDraws[17], 0);
	TextDrawBackgroundColor(IgTextDraws[17], 255);
	TextDrawFont(IgTextDraws[17], 1);
	TextDrawSetProportional(IgTextDraws[17], 1);
	TextDrawSetShadow(IgTextDraws[17], 0);

	IgTextDraws[18] = TextDrawCreate(496.666717, 100.659263, "ld_pool:ball");
	TextDrawLetterSize(IgTextDraws[18], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[18], 16.000000, 16.000000);
	TextDrawAlignment(IgTextDraws[18], 1);
	TextDrawColor(IgTextDraws[18], 111738879);
	TextDrawSetShadow(IgTextDraws[18], 0);
	TextDrawSetOutline(IgTextDraws[18], 0);
	TextDrawBackgroundColor(IgTextDraws[18], 255);
	TextDrawFont(IgTextDraws[18], 4);
	TextDrawSetProportional(IgTextDraws[18], 0);
	TextDrawSetShadow(IgTextDraws[18], 0);

	IgTextDraws[19] = TextDrawCreate(597.698181, 100.599975, "ld_pool:ball");
	TextDrawLetterSize(IgTextDraws[19], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[19], 16.000000, 16.000000);
	TextDrawAlignment(IgTextDraws[19], 1);
	TextDrawColor(IgTextDraws[19], 111738879);
	TextDrawSetShadow(IgTextDraws[19], 0);
	TextDrawSetOutline(IgTextDraws[19], 0);
	TextDrawBackgroundColor(IgTextDraws[19], 255);
	TextDrawFont(IgTextDraws[19], 4);
	TextDrawSetProportional(IgTextDraws[19], 0);
	TextDrawSetShadow(IgTextDraws[19], 0);

	IgTextDraws[20] = TextDrawCreate(505.666625, 102.474075, "box");
	TextDrawLetterSize(IgTextDraws[20], 0.000000, 1.366667);
	TextDrawTextSize(IgTextDraws[20], 605.000000, 0.000000);
	TextDrawAlignment(IgTextDraws[20], 1);
	TextDrawColor(IgTextDraws[20], -1);
	TextDrawUseBox(IgTextDraws[20], 1);
	TextDrawBoxColor(IgTextDraws[20], 255);
	TextDrawSetShadow(IgTextDraws[20], 0);
	TextDrawSetOutline(IgTextDraws[20], 0);
	TextDrawBackgroundColor(IgTextDraws[20], 255);
	TextDrawFont(IgTextDraws[20], 1);
	TextDrawSetProportional(IgTextDraws[20], 1);
	TextDrawSetShadow(IgTextDraws[20], 0);

	IgTextDraws[21] = TextDrawCreate(504.000091, 90.703758, "");
	TextDrawLetterSize(IgTextDraws[21], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[21], 17.000000, 33.000000);
	TextDrawAlignment(IgTextDraws[21], 1);
	TextDrawColor(IgTextDraws[21], -1);
	TextDrawSetShadow(IgTextDraws[21], 0);
	TextDrawSetOutline(IgTextDraws[21], 0);
	TextDrawBackgroundColor(IgTextDraws[21], 1090519040);
	TextDrawFont(IgTextDraws[21], 5);
	TextDrawSetProportional(IgTextDraws[21], 0);
	TextDrawSetShadow(IgTextDraws[21], 0);
	TextDrawSetPreviewModel(IgTextDraws[21], 1212);
	TextDrawSetPreviewRot(IgTextDraws[21], 50.000000, 10.000000, 0.000000, 1.000000);

	IgTextDraws[22] = TextDrawCreate(496.666717, 119.458976, "ld_pool:ball");
	TextDrawLetterSize(IgTextDraws[22], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[22], 16.000000, 16.000000);
	TextDrawAlignment(IgTextDraws[22], 1);
	TextDrawColor(IgTextDraws[22], 111738879);
	TextDrawSetShadow(IgTextDraws[22], 0);
	TextDrawSetOutline(IgTextDraws[22], 0);
	TextDrawBackgroundColor(IgTextDraws[22], 255);
	TextDrawFont(IgTextDraws[22], 4);
	TextDrawSetProportional(IgTextDraws[22], 0);
	TextDrawSetShadow(IgTextDraws[22], 0);

	IgTextDraws[23] = TextDrawCreate(597.698181, 119.399688, "ld_pool:ball");
	TextDrawLetterSize(IgTextDraws[23], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[23], 16.000000, 16.000000);
	TextDrawAlignment(IgTextDraws[23], 1);
	TextDrawColor(IgTextDraws[23], 111738879);
	TextDrawSetShadow(IgTextDraws[23], 0);
	TextDrawSetOutline(IgTextDraws[23], 0);
	TextDrawBackgroundColor(IgTextDraws[23], 255);
	TextDrawFont(IgTextDraws[23], 4);
	TextDrawSetProportional(IgTextDraws[23], 0);
	TextDrawSetShadow(IgTextDraws[23], 0);

	IgTextDraws[24] = TextDrawCreate(505.666625, 121.073791, "box");
	TextDrawLetterSize(IgTextDraws[24], 0.000000, 1.366667);
	TextDrawTextSize(IgTextDraws[24], 605.000000, 0.000000);
	TextDrawAlignment(IgTextDraws[24], 1);
	TextDrawColor(IgTextDraws[24], -1);
	TextDrawUseBox(IgTextDraws[24], 1);
	TextDrawBoxColor(IgTextDraws[24], 255);
	TextDrawSetShadow(IgTextDraws[24], 0);
	TextDrawSetOutline(IgTextDraws[24], 0);
	TextDrawBackgroundColor(IgTextDraws[24], 255);
	TextDrawFont(IgTextDraws[24], 1);
	TextDrawSetProportional(IgTextDraws[24], 1);
	TextDrawSetShadow(IgTextDraws[24], 0);

	IgTextDraws[25] = TextDrawCreate(504.000091, 108.703483, "");
	TextDrawLetterSize(IgTextDraws[25], 0.000000, 0.000000);
	TextDrawTextSize(IgTextDraws[25], 17.000000, 33.000000);
	TextDrawAlignment(IgTextDraws[25], 1);
	TextDrawColor(IgTextDraws[25], -1);
	TextDrawSetShadow(IgTextDraws[25], 0);
	TextDrawSetOutline(IgTextDraws[25], 0);
	TextDrawBackgroundColor(IgTextDraws[25], 1090519040);
	TextDrawFont(IgTextDraws[25], 5);
	TextDrawSetProportional(IgTextDraws[25], 0);
	TextDrawSetShadow(IgTextDraws[25], 0);
	TextDrawSetPreviewModel(IgTextDraws[25], 19941);
	TextDrawSetPreviewRot(IgTextDraws[25], -20.000000, 0.000000, 60.000000, 1.000000);
    //--------------------------------------------------------------------------
    //brzinomjer
    brzinomjer[0] = TextDrawCreate(530.333374, 324.399902, "box");
	TextDrawLetterSize(brzinomjer[0], 0.000000, 10.399999);
	TextDrawTextSize(brzinomjer[0], 627.000000, 0.000000);
	TextDrawAlignment(brzinomjer[0], 1);
	TextDrawColor(brzinomjer[0], -1);
	TextDrawUseBox(brzinomjer[0], 1);
	TextDrawBoxColor(brzinomjer[0], 170);
	TextDrawSetShadow(brzinomjer[0], 0);
	TextDrawSetOutline(brzinomjer[0], 0);
	TextDrawBackgroundColor(brzinomjer[0], 255);
	TextDrawFont(brzinomjer[0], 1);
	TextDrawSetProportional(brzinomjer[0], 1);
	TextDrawSetShadow(brzinomjer[0], 0);

	brzinomjer[1] = TextDrawCreate(524.333312, 318.022033, "ld_pool:ball");
	TextDrawLetterSize(brzinomjer[1], 0.000000, 0.000000);
	TextDrawTextSize(brzinomjer[1], 12.000000, 13.000000);
	TextDrawAlignment(brzinomjer[1], 1);
	TextDrawColor(brzinomjer[1], 111738879);
	TextDrawSetShadow(brzinomjer[1], 0);
	TextDrawSetOutline(brzinomjer[1], 0);
	TextDrawBackgroundColor(brzinomjer[1], 255);
	TextDrawFont(brzinomjer[1], 4);
	TextDrawSetProportional(brzinomjer[1], 0);
	TextDrawSetShadow(brzinomjer[1], 0);

	brzinomjer[2] = TextDrawCreate(525.666809, 410.940704, "ld_pool:ball");
	TextDrawLetterSize(brzinomjer[2], 0.000000, 0.000000);
	TextDrawTextSize(brzinomjer[2], 12.000000, 13.000000);
	TextDrawAlignment(brzinomjer[2], 1);
	TextDrawColor(brzinomjer[2], 111738879);
	TextDrawSetShadow(brzinomjer[2], 0);
	TextDrawSetOutline(brzinomjer[2], 0);
	TextDrawBackgroundColor(brzinomjer[2], 255);
	TextDrawFont(brzinomjer[2], 4);
	TextDrawSetProportional(brzinomjer[2], 0);
	TextDrawSetShadow(brzinomjer[2], 0);

	brzinomjer[3] = TextDrawCreate(621.999938, 412.600036, "ld_pool:ball");
	TextDrawLetterSize(brzinomjer[3], 0.000000, 0.000000);
	TextDrawTextSize(brzinomjer[3], 12.000000, 13.000000);
	TextDrawAlignment(brzinomjer[3], 1);
	TextDrawColor(brzinomjer[3], 111738879);
	TextDrawSetShadow(brzinomjer[3], 0);
	TextDrawSetOutline(brzinomjer[3], 0);
	TextDrawBackgroundColor(brzinomjer[3], 255);
	TextDrawFont(brzinomjer[3], 4);
	TextDrawSetProportional(brzinomjer[3], 0);
	TextDrawSetShadow(brzinomjer[3], 0);

	brzinomjer[4] = TextDrawCreate(620.666809, 320.096252, "ld_pool:ball");
	TextDrawLetterSize(brzinomjer[4], 0.000000, 0.000000);
	TextDrawTextSize(brzinomjer[4], 12.000000, 13.000000);
	TextDrawAlignment(brzinomjer[4], 1);
	TextDrawColor(brzinomjer[4], 111738879);
	TextDrawSetShadow(brzinomjer[4], 0);
	TextDrawSetOutline(brzinomjer[4], 0);
	TextDrawBackgroundColor(brzinomjer[4], 255);
	TextDrawFont(brzinomjer[4], 4);
	TextDrawSetProportional(brzinomjer[4], 0);
	TextDrawSetShadow(brzinomjer[4], 0);

	brzinomjer[5] = TextDrawCreate(547.333435, 325.903564, "ld_pool:ball");
	TextDrawLetterSize(brzinomjer[5], 0.000000, 0.000000);
	TextDrawTextSize(brzinomjer[5], 12.000000, 13.000000);
	TextDrawAlignment(brzinomjer[5], 1);
	TextDrawColor(brzinomjer[5], 111738879);
	TextDrawSetShadow(brzinomjer[5], 0);
	TextDrawSetOutline(brzinomjer[5], 0);
	TextDrawBackgroundColor(brzinomjer[5], 255);
	TextDrawFont(brzinomjer[5], 4);
	TextDrawSetProportional(brzinomjer[5], 0);
	TextDrawSetShadow(brzinomjer[5], 0);

	brzinomjer[6] = TextDrawCreate(594.733093, 325.533142, "ld_pool:ball");
	TextDrawLetterSize(brzinomjer[6], 0.000000, 0.000000);
	TextDrawTextSize(brzinomjer[6], 12.000000, 13.000000);
	TextDrawAlignment(brzinomjer[6], 1);
	TextDrawColor(brzinomjer[6], 111738879);
	TextDrawSetShadow(brzinomjer[6], 0);
	TextDrawSetOutline(brzinomjer[6], 0);
	TextDrawBackgroundColor(brzinomjer[6], 255);
	TextDrawFont(brzinomjer[6], 4);
	TextDrawSetProportional(brzinomjer[6], 0);
	TextDrawSetShadow(brzinomjer[6], 0);

	brzinomjer[7] = TextDrawCreate(554.666870, 327.303619, "box");
	TextDrawLetterSize(brzinomjer[7], 0.000000, 1.133333);
	TextDrawTextSize(brzinomjer[7], 600.000000, 0.000000);
	TextDrawAlignment(brzinomjer[7], 1);
	TextDrawColor(brzinomjer[7], -1);
	TextDrawUseBox(brzinomjer[7], 1);
	TextDrawBoxColor(brzinomjer[7], 255);
	TextDrawSetShadow(brzinomjer[7], 0);
	TextDrawSetOutline(brzinomjer[7], 0);
	TextDrawBackgroundColor(brzinomjer[7], 255);
	TextDrawFont(brzinomjer[7], 1);
	TextDrawSetProportional(brzinomjer[7], 1);
	TextDrawSetShadow(brzinomjer[7], 0);
    //--------------------------------------------------------------------------
    //katalog
    katalog[0] = TextDrawCreate(18.333332, 105.377784, "box");
	TextDrawLetterSize(katalog[0], 0.000000, 24.333330);
	TextDrawTextSize(katalog[0], 180.000000, 0.000000);
	TextDrawAlignment(katalog[0], 1);
	TextDrawColor(katalog[0], -1);
	TextDrawUseBox(katalog[0], 1);
	TextDrawBoxColor(katalog[0], 170);
	TextDrawSetShadow(katalog[0], 0);
	TextDrawSetOutline(katalog[0], 0);
	TextDrawBackgroundColor(katalog[0], 268435626);
	TextDrawFont(katalog[0], 1);
	TextDrawSetProportional(katalog[0], 1);
	TextDrawSetShadow(katalog[0], 0);

	katalog[1] = TextDrawCreate(12.333333, 99.829612, "ld_pool:ball");
	TextDrawLetterSize(katalog[1], 0.000000, 0.000000);
	TextDrawTextSize(katalog[1], 11.000000, 12.000000);
	TextDrawAlignment(katalog[1], 1);
	TextDrawColor(katalog[1], 111738879);
	TextDrawSetShadow(katalog[1], 0);
	TextDrawSetOutline(katalog[1], 0);
	TextDrawBackgroundColor(katalog[1], 255);
	TextDrawFont(katalog[1], 4);
	TextDrawSetProportional(katalog[1], 0);
	TextDrawSetShadow(katalog[1], 0);

	katalog[2] = TextDrawCreate(12.333333, 318.437164, "ld_pool:ball");
	TextDrawLetterSize(katalog[2], 0.000000, 0.000000);
	TextDrawTextSize(katalog[2], 11.000000, 12.000000);
	TextDrawAlignment(katalog[2], 1);
	TextDrawColor(katalog[2], 111738879);
	TextDrawSetShadow(katalog[2], 0);
	TextDrawSetOutline(katalog[2], 0);
	TextDrawBackgroundColor(katalog[2], 255);
	TextDrawFont(katalog[2], 4);
	TextDrawSetProportional(katalog[2], 0);
	TextDrawSetShadow(katalog[2], 0);

	katalog[3] = TextDrawCreate(175.000000, 318.437164, "ld_pool:ball");
	TextDrawLetterSize(katalog[3], 0.000000, 0.000000);
	TextDrawTextSize(katalog[3], 11.000000, 12.000000);
	TextDrawAlignment(katalog[3], 1);
	TextDrawColor(katalog[3], 111738879);
	TextDrawSetShadow(katalog[3], 0);
	TextDrawSetOutline(katalog[3], 0);
	TextDrawBackgroundColor(katalog[3], 255);
	TextDrawFont(katalog[3], 4);
	TextDrawSetProportional(katalog[3], 0);
	TextDrawSetShadow(katalog[3], 0);

	katalog[4] = TextDrawCreate(175.666671, 99.829772, "ld_pool:ball");
	TextDrawLetterSize(katalog[4], 0.000000, 0.000000);
	TextDrawTextSize(katalog[4], 11.000000, 12.000000);
	TextDrawAlignment(katalog[4], 1);
	TextDrawColor(katalog[4], 111738879);
	TextDrawSetShadow(katalog[4], 0);
	TextDrawSetOutline(katalog[4], 0);
	TextDrawBackgroundColor(katalog[4], 255);
	TextDrawFont(katalog[4], 4);
	TextDrawSetProportional(katalog[4], 0);
	TextDrawSetShadow(katalog[4], 0);

	katalog[5] = TextDrawCreate(54.733173, 123.059417, "ld_pool:ball");
	TextDrawLetterSize(katalog[5], 0.000000, 0.000000);
	TextDrawTextSize(katalog[5], 11.000000, 12.000000);
	TextDrawAlignment(katalog[5], 1);
	TextDrawColor(katalog[5], 111738879);
	TextDrawSetShadow(katalog[5], 0);
	TextDrawSetOutline(katalog[5], 0);
	TextDrawBackgroundColor(katalog[5], 255);
	TextDrawFont(katalog[5], 4);
	TextDrawSetProportional(katalog[5], 0);
	TextDrawSetShadow(katalog[5], 0);

	katalog[6] = TextDrawCreate(140.200805, 123.059402, "ld_pool:ball");
	TextDrawLetterSize(katalog[6], 0.000000, 0.000000);
	TextDrawTextSize(katalog[6], 11.000000, 12.000000);
	TextDrawAlignment(katalog[6], 1);
	TextDrawColor(katalog[6], 111738879);
	TextDrawSetShadow(katalog[6], 0);
	TextDrawSetOutline(katalog[6], 0);
	TextDrawBackgroundColor(katalog[6], 255);
	TextDrawFont(katalog[6], 4);
	TextDrawSetProportional(katalog[6], 0);
	TextDrawSetShadow(katalog[6], 0);

	katalog[7] = TextDrawCreate(61.399818, 124.459236, "box");
	TextDrawLetterSize(katalog[7], 0.000000, 0.999998);
	TextDrawTextSize(katalog[7], 144.400756, 0.000000);
	TextDrawAlignment(katalog[7], 1);
	TextDrawColor(katalog[7], -1);
	TextDrawUseBox(katalog[7], 1);
	TextDrawBoxColor(katalog[7], 255);
	TextDrawSetShadow(katalog[7], 0);
	TextDrawSetOutline(katalog[7], 0);
	TextDrawBackgroundColor(katalog[7], 255);
	TextDrawFont(katalog[7], 1);
	TextDrawSetProportional(katalog[7], 1);
	TextDrawSetShadow(katalog[7], 0);

	katalog[8] = TextDrawCreate(57.433132, 228.365463, "ld_pool:ball");
	TextDrawLetterSize(katalog[8], 0.000000, 0.000000);
	TextDrawTextSize(katalog[8], 11.000000, 12.000000);
	TextDrawAlignment(katalog[8], 1);
	TextDrawColor(katalog[8], 111738879);
	TextDrawSetShadow(katalog[8], 0);
	TextDrawSetOutline(katalog[8], 0);
	TextDrawBackgroundColor(katalog[8], 255);
	TextDrawFont(katalog[8], 4);
	TextDrawSetProportional(katalog[8], 0);
	TextDrawSetShadow(katalog[8], 0);

	katalog[9] = TextDrawCreate(142.434249, 228.237319, "ld_pool:ball");
	TextDrawLetterSize(katalog[9], 0.000000, 0.000000);
	TextDrawTextSize(katalog[9], 11.000000, 12.000000);
	TextDrawAlignment(katalog[9], 1);
	TextDrawColor(katalog[9], 111738879);
	TextDrawSetShadow(katalog[9], 0);
	TextDrawSetOutline(katalog[9], 0);
	TextDrawBackgroundColor(katalog[9], 255);
	TextDrawFont(katalog[9], 4);
	TextDrawSetProportional(katalog[9], 0);
	TextDrawSetShadow(katalog[9], 0);

	katalog[10] = TextDrawCreate(63.899780, 229.822250, "box");
	TextDrawLetterSize(katalog[10], 0.000000, 0.999998);
	TextDrawTextSize(katalog[10], 146.900909, 0.000000);
	TextDrawAlignment(katalog[10], 1);
	TextDrawColor(katalog[10], -1);
	TextDrawUseBox(katalog[10], 1);
	TextDrawBoxColor(katalog[10], 255);
	TextDrawSetShadow(katalog[10], 0);
	TextDrawSetOutline(katalog[10], 0);
	TextDrawBackgroundColor(katalog[10], 255);
	TextDrawFont(katalog[10], 1);
	TextDrawSetProportional(katalog[10], 1);
	TextDrawSetShadow(katalog[10], 0);

	katalog[11] = TextDrawCreate(162.333343, 173.822296, ">");
	TextDrawLetterSize(katalog[11], 0.492000, 2.342518);
	TextDrawTextSize(katalog[11], 174.000000, 10.000000);
	TextDrawAlignment(katalog[11], 1);
	TextDrawColor(katalog[11], 111738879);
	TextDrawUseBox(katalog[11], 1);
	TextDrawBoxColor(katalog[11], 1090519040);
	TextDrawSetShadow(katalog[11], 0);
	TextDrawSetOutline(katalog[11], 1);
	TextDrawBackgroundColor(katalog[11], 255);
	TextDrawFont(katalog[11], 1);
	TextDrawSetProportional(katalog[11], 1);
	TextDrawSetShadow(katalog[11], 0);
	TextDrawSetSelectable(katalog[11], true);

	katalog[12] = TextDrawCreate(23.932605, 175.737197, "<");
	TextDrawLetterSize(katalog[12], 0.492000, 2.342518);
	TextDrawTextSize(katalog[12], 38.000000, 10.000000);
	TextDrawAlignment(katalog[12], 1);
	TextDrawColor(katalog[12], 111738879);
	TextDrawUseBox(katalog[12], 1);
	TextDrawBoxColor(katalog[12], 1090519040);
	TextDrawSetShadow(katalog[12], 0);
	TextDrawSetOutline(katalog[12], 1);
	TextDrawBackgroundColor(katalog[12], 255);
	TextDrawFont(katalog[12], 1);
	TextDrawSetProportional(katalog[12], 1);
	TextDrawSetShadow(katalog[12], 0);
	TextDrawSetSelectable(katalog[12], true);

	katalog[13] = TextDrawCreate(77.833236, 273.792572, "KUPI");
	TextDrawLetterSize(katalog[13], 0.599665, 2.674370);
	TextDrawTextSize(katalog[13], 128.499938, 15.000000);
	TextDrawAlignment(katalog[13], 1);
	TextDrawColor(katalog[13], 111738879);
	TextDrawUseBox(katalog[13], 1);
	TextDrawBoxColor(katalog[13], 1090519040);
	TextDrawSetShadow(katalog[13], 0);
	TextDrawSetOutline(katalog[13], 2);
	TextDrawBackgroundColor(katalog[13], 255);
	TextDrawFont(katalog[13], 1);
	TextDrawSetProportional(katalog[13], 1);
	TextDrawSetShadow(katalog[13], 0);
	TextDrawSetSelectable(katalog[13], true);
	
	katalog[14] = TextDrawCreate(26.833267, 106.622207, "ODUSTANI");
	TextDrawLetterSize(katalog[14], 0.231331, 1.288889);
	TextDrawTextSize(katalog[14], 71.000000, 10.000000);
	TextDrawAlignment(katalog[14], 1);
	TextDrawColor(katalog[14], 111738879);
	TextDrawUseBox(katalog[14], 1);
	TextDrawBoxColor(katalog[14], 1090519040);
	TextDrawSetShadow(katalog[14], 0);
	TextDrawSetOutline(katalog[14], 2);
	TextDrawBackgroundColor(katalog[14], 255);
	TextDrawFont(katalog[14], 1);
	TextDrawSetProportional(katalog[14], 1);
	TextDrawSetShadow(katalog[14], 0);
	TextDrawSetSelectable(katalog[14], true);
	//--------------------------------------------------------------------------
	return 1;
	
}
//==============================================================================
CreatePlayerTextDraws(playerid)
{
	//registracija
	regp[0][playerid] = CreatePlayerTextDraw(playerid, 72.166374, 155.270370, "UPISITE");
	PlayerTextDrawLetterSize(playerid, regp[0][playerid], 0.421665, 1.774222);
	PlayerTextDrawTextSize(playerid, regp[0][playerid], 127.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, regp[0][playerid], 1);
	PlayerTextDrawColor(playerid, regp[0][playerid], -1);
	PlayerTextDrawUseBox(playerid, regp[0][playerid], 1);
	PlayerTextDrawBoxColor(playerid, regp[0][playerid], 268435456);
	PlayerTextDrawSetShadow(playerid, regp[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, regp[0][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, regp[0][playerid], 255);
	PlayerTextDrawFont(playerid, regp[0][playerid], 1);
	PlayerTextDrawSetProportional(playerid, regp[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid, regp[0][playerid], 0);
	PlayerTextDrawSetSelectable(playerid, regp[0][playerid], true);

	regp[1][playerid] = CreatePlayerTextDraw(playerid, 48.633060, 177.067489, "UPISITE");
	PlayerTextDrawLetterSize(playerid, regp[1][playerid], 0.421665, 1.774222);
	PlayerTextDrawTextSize(playerid, regp[1][playerid], 100.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, regp[1][playerid], 1);
	PlayerTextDrawColor(playerid, regp[1][playerid], -1);
	PlayerTextDrawUseBox(playerid, regp[1][playerid], 1);
	PlayerTextDrawBoxColor(playerid, regp[1][playerid], 268435456);
	PlayerTextDrawSetShadow(playerid, regp[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, regp[1][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, regp[1][playerid], 255);
	PlayerTextDrawFont(playerid, regp[1][playerid], 1);
	PlayerTextDrawSetProportional(playerid, regp[1][playerid], 1);
	PlayerTextDrawSetShadow(playerid, regp[1][playerid], 0);
	PlayerTextDrawSetSelectable(playerid, regp[1][playerid], true);

	regp[2][playerid] = CreatePlayerTextDraw(playerid, 67.966369, 200.742874, "UPISITE");
	PlayerTextDrawLetterSize(playerid, regp[2][playerid], 0.421665, 1.774222);
	PlayerTextDrawTextSize(playerid, regp[2][playerid], 120.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, regp[2][playerid], 1);
	PlayerTextDrawColor(playerid, regp[2][playerid], -1);
	PlayerTextDrawUseBox(playerid, regp[2][playerid], 1);
	PlayerTextDrawBoxColor(playerid, regp[2][playerid], 268435456);
	PlayerTextDrawSetShadow(playerid, regp[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid, regp[2][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, regp[2][playerid], 255);
	PlayerTextDrawFont(playerid, regp[2][playerid], 1);
	PlayerTextDrawSetProportional(playerid, regp[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid, regp[2][playerid], 0);
	PlayerTextDrawSetSelectable(playerid, regp[2][playerid], true);

	regp[3][playerid] = CreatePlayerTextDraw(playerid, 67.966369, 223.142913, "IZABERITE");
	PlayerTextDrawLetterSize(playerid, regp[3][playerid], 0.421665, 1.774222);
	PlayerTextDrawTextSize(playerid, regp[3][playerid], 135.000000, 10.119998);
	PlayerTextDrawAlignment(playerid, regp[3][playerid], 1);
	PlayerTextDrawColor(playerid, regp[3][playerid], -1);
	PlayerTextDrawUseBox(playerid, regp[3][playerid], 1);
	PlayerTextDrawBoxColor(playerid, regp[3][playerid], 268435456);
	PlayerTextDrawSetShadow(playerid, regp[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid, regp[3][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, regp[3][playerid], 255);
	PlayerTextDrawFont(playerid, regp[3][playerid], 1);
	PlayerTextDrawSetProportional(playerid, regp[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid, regp[3][playerid], 0);
	PlayerTextDrawSetSelectable(playerid, regp[3][playerid], true);

	regp[4][playerid] = CreatePlayerTextDraw(playerid, 48.633037, 241.809600, "IZABERITE");
	PlayerTextDrawLetterSize(playerid, regp[4][playerid], 0.421665, 1.774222);
	PlayerTextDrawTextSize(playerid, regp[4][playerid], 115.000000, 10.119998);
	PlayerTextDrawAlignment(playerid, regp[4][playerid], 1);
	PlayerTextDrawColor(playerid, regp[4][playerid], -1);
	PlayerTextDrawUseBox(playerid, regp[4][playerid], 1);
	PlayerTextDrawBoxColor(playerid, regp[4][playerid], 268435456);
	PlayerTextDrawSetShadow(playerid, regp[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid, regp[4][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, regp[4][playerid], 255);
	PlayerTextDrawFont(playerid, regp[4][playerid], 1);
	PlayerTextDrawSetProportional(playerid, regp[4][playerid], 1);
	PlayerTextDrawSetShadow(playerid, regp[4][playerid], 0);
	PlayerTextDrawSetSelectable(playerid, regp[4][playerid], true);

	regp[5][playerid] = CreatePlayerTextDraw(playerid, 48.333354, 282.762878, "");
	PlayerTextDrawLetterSize(playerid, regp[5][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, regp[5][playerid], 90.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, regp[5][playerid], 1);
	PlayerTextDrawColor(playerid, regp[5][playerid], -1);
	PlayerTextDrawSetShadow(playerid, regp[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid, regp[5][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, regp[5][playerid], 268435456);
	PlayerTextDrawFont(playerid, regp[5][playerid], 5);
	PlayerTextDrawSetProportional(playerid, regp[5][playerid], 0);
	PlayerTextDrawSetShadow(playerid, regp[5][playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, regp[5][playerid], 23);
	PlayerTextDrawSetPreviewRot(playerid, regp[5][playerid], 0.000000, 0.000000, 0.000000, 1.000000);
	//--------------------------------------------------------------------------
	//banka i zlato
	BankaTD[playerid] = CreatePlayerTextDraw(playerid, 523.666748, 100.814804, "000000000$");
	PlayerTextDrawLetterSize(playerid, BankaTD[playerid], 0.360666, 1.434074);
	PlayerTextDrawAlignment(playerid, BankaTD[playerid], 1);
	PlayerTextDrawColor(playerid, BankaTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, BankaTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, BankaTD[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, BankaTD[playerid], 255);
	PlayerTextDrawFont(playerid, BankaTD[playerid], 3);
	PlayerTextDrawSetProportional(playerid, BankaTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, BankaTD[playerid], 0);

	ZlatoTD[playerid] = CreatePlayerTextDraw(playerid, 523.666748, 119.481498, "10000000g");
	PlayerTextDrawLetterSize(playerid, ZlatoTD[playerid], 0.360666, 1.434074);
	PlayerTextDrawAlignment(playerid, ZlatoTD[playerid], 1);
	PlayerTextDrawColor(playerid, ZlatoTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, ZlatoTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ZlatoTD[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, ZlatoTD[playerid], 255);
	PlayerTextDrawFont(playerid, ZlatoTD[playerid], 3);
	PlayerTextDrawSetProportional(playerid, ZlatoTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ZlatoTD[playerid], 0);
	//--------------------------------------------------------------------------
	//brzinomjer
	brzinomjerp[0][playerid] = CreatePlayerTextDraw(playerid, 558.333374, 326.888854, "550km/h");
	PlayerTextDrawLetterSize(playerid, brzinomjerp[0][playerid], 0.249000, 1.015111);
	PlayerTextDrawAlignment(playerid, brzinomjerp[0][playerid], 1);
	PlayerTextDrawColor(playerid, brzinomjerp[0][playerid], -1);
	PlayerTextDrawSetShadow(playerid, brzinomjerp[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, brzinomjerp[0][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, brzinomjerp[0][playerid], 255);
	PlayerTextDrawFont(playerid, brzinomjerp[0][playerid], 1);
	PlayerTextDrawSetProportional(playerid, brzinomjerp[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid, brzinomjerp[0][playerid], 0);

	brzinomjerp[1][playerid] = CreatePlayerTextDraw(playerid, 523.200256, 369.044403, "");
	PlayerTextDrawLetterSize(playerid, brzinomjerp[1][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, brzinomjerp[1][playerid], 54.000000, 49.000000);
	PlayerTextDrawAlignment(playerid, brzinomjerp[1][playerid], 1);
	PlayerTextDrawColor(playerid, brzinomjerp[1][playerid], -1);
	PlayerTextDrawSetShadow(playerid, brzinomjerp[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, brzinomjerp[1][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, brzinomjerp[1][playerid], 1090519040);
	PlayerTextDrawFont(playerid, brzinomjerp[1][playerid], 5);
	PlayerTextDrawSetProportional(playerid, brzinomjerp[1][playerid], 0);
	PlayerTextDrawSetShadow(playerid, brzinomjerp[1][playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, brzinomjerp[1][playerid], 522);
	PlayerTextDrawSetPreviewRot(playerid, brzinomjerp[1][playerid], -30.000000, 0.000000, 20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, brzinomjerp[1][playerid], 2, 2);

	brzinomjerp[2][playerid] = CreatePlayerTextDraw(playerid, 539.333312, 413.585327, "NRG-500");
	PlayerTextDrawLetterSize(playerid, brzinomjerp[2][playerid], 0.174999, 0.571259);
	PlayerTextDrawAlignment(playerid, brzinomjerp[2][playerid], 1);
	PlayerTextDrawColor(playerid, brzinomjerp[2][playerid], -1);
	PlayerTextDrawSetShadow(playerid, brzinomjerp[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid, brzinomjerp[2][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, brzinomjerp[2][playerid], 255);
	PlayerTextDrawFont(playerid, brzinomjerp[2][playerid], 1);
	PlayerTextDrawSetProportional(playerid, brzinomjerp[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid, brzinomjerp[2][playerid], 0);

	brzinomjerp[3][playerid] = CreatePlayerTextDraw(playerid, 570.666564, 347.629547, "Gorivo:_1000l");
	PlayerTextDrawLetterSize(playerid, brzinomjerp[3][playerid], 0.209333, 0.878222);
	PlayerTextDrawAlignment(playerid, brzinomjerp[3][playerid], 1);
	PlayerTextDrawColor(playerid, brzinomjerp[3][playerid], -1);
	PlayerTextDrawSetShadow(playerid, brzinomjerp[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid, brzinomjerp[3][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, brzinomjerp[3][playerid], 255);
	PlayerTextDrawFont(playerid, brzinomjerp[3][playerid], 1);
	PlayerTextDrawSetProportional(playerid, brzinomjerp[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid, brzinomjerp[3][playerid], 0);

	brzinomjerp[4][playerid] = CreatePlayerTextDraw(playerid, 570.666564, 367.130737, "Vrsta:_Dizel");
	PlayerTextDrawLetterSize(playerid, brzinomjerp[4][playerid], 0.209333, 0.878222);
	PlayerTextDrawAlignment(playerid, brzinomjerp[4][playerid], 1);
	PlayerTextDrawColor(playerid, brzinomjerp[4][playerid], -1);
	PlayerTextDrawSetShadow(playerid, brzinomjerp[4][playerid], 0);
	PlayerTextDrawSetOutline(playerid, brzinomjerp[4][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, brzinomjerp[4][playerid], 255);
	PlayerTextDrawFont(playerid, brzinomjerp[4][playerid], 1);
	PlayerTextDrawSetProportional(playerid, brzinomjerp[4][playerid], 1);
	PlayerTextDrawSetShadow(playerid, brzinomjerp[4][playerid], 0);

	brzinomjerp[5][playerid] = CreatePlayerTextDraw(playerid, 569.766662, 385.028350, "Potrosnja:~n~50l_-_5min");
	PlayerTextDrawLetterSize(playerid, brzinomjerp[5][playerid], 0.209333, 0.878222);
	PlayerTextDrawAlignment(playerid, brzinomjerp[5][playerid], 1);
	PlayerTextDrawColor(playerid, brzinomjerp[5][playerid], -1);
	PlayerTextDrawSetShadow(playerid, brzinomjerp[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid, brzinomjerp[5][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, brzinomjerp[5][playerid], 255);
	PlayerTextDrawFont(playerid, brzinomjerp[5][playerid], 1);
	PlayerTextDrawSetProportional(playerid, brzinomjerp[5][playerid], 1);
	PlayerTextDrawSetShadow(playerid, brzinomjerp[5][playerid], 0);
	//--------------------------------------------------------------------------
	//katalog
	katalogp[0][playerid] = CreatePlayerTextDraw(playerid, 103.033142, 124.729537, "Infernus");
	PlayerTextDrawLetterSize(playerid, katalogp[0][playerid], 0.222000, 0.845036);
	PlayerTextDrawAlignment(playerid, katalogp[0][playerid], 2);
	PlayerTextDrawColor(playerid, katalogp[0][playerid], -1);
	PlayerTextDrawSetShadow(playerid, katalogp[0][playerid], 0);
	PlayerTextDrawSetOutline(playerid, katalogp[0][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, katalogp[0][playerid], 255);
	PlayerTextDrawFont(playerid, katalogp[0][playerid], 1);
	PlayerTextDrawSetProportional(playerid, katalogp[0][playerid], 1);
	PlayerTextDrawSetShadow(playerid, katalogp[0][playerid], 0);

	katalogp[1][playerid] = CreatePlayerTextDraw(playerid, 58.166519, 135.088928, "");
	PlayerTextDrawLetterSize(playerid, katalogp[1][playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, katalogp[1][playerid], 85.000000, 90.000000);
	PlayerTextDrawAlignment(playerid, katalogp[1][playerid], 1);
	PlayerTextDrawColor(playerid, katalogp[1][playerid], -1);
	PlayerTextDrawSetShadow(playerid, katalogp[1][playerid], 0);
	PlayerTextDrawSetOutline(playerid, katalogp[1][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, katalogp[1][playerid], 1090519040);
	PlayerTextDrawFont(playerid, katalogp[1][playerid], 5);
	PlayerTextDrawSetProportional(playerid, katalogp[1][playerid], 0);
	PlayerTextDrawSetShadow(playerid, katalogp[1][playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, katalogp[1][playerid], 411);
	PlayerTextDrawSetPreviewRot(playerid, katalogp[1][playerid], -20.000000, 0.000000, 10.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, katalogp[1][playerid], 2, 2);

	katalogp[2][playerid] = CreatePlayerTextDraw(playerid, 64.699783, 228.992614, "Cijena:_65000000$");
	PlayerTextDrawLetterSize(playerid, katalogp[2][playerid], 0.234332, 0.936295);
	PlayerTextDrawAlignment(playerid, katalogp[2][playerid], 1);
	PlayerTextDrawColor(playerid, katalogp[2][playerid], -1);
	PlayerTextDrawSetShadow(playerid, katalogp[2][playerid], 0);
	PlayerTextDrawSetOutline(playerid, katalogp[2][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, katalogp[2][playerid], 255);
	PlayerTextDrawFont(playerid, katalogp[2][playerid], 1);
	PlayerTextDrawSetProportional(playerid, katalogp[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid, katalogp[2][playerid], 0);

	katalogp[3][playerid] = CreatePlayerTextDraw(playerid, 148.333358, 107.866592, "1/100");
	PlayerTextDrawLetterSize(playerid, katalogp[3][playerid], 0.270000, 1.222518);
	PlayerTextDrawAlignment(playerid, katalogp[3][playerid], 1);
	PlayerTextDrawColor(playerid, katalogp[3][playerid], -1);
	PlayerTextDrawSetShadow(playerid, katalogp[3][playerid], 0);
	PlayerTextDrawSetOutline(playerid, katalogp[3][playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, katalogp[3][playerid], 255);
	PlayerTextDrawFont(playerid, katalogp[3][playerid], 1);
	PlayerTextDrawSetProportional(playerid, katalogp[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid, katalogp[3][playerid], 0);
	//--------------------------------------------------------------------------
	//wanted level panel
	WlPanel[playerid][0] = CreatePlayerTextDraw(playerid,53,224,"~r~---------------");
	PlayerTextDrawLetterSize(playerid,WlPanel[playerid][0],0.500000,1.000000);
	PlayerTextDrawAlignment(playerid,WlPanel[playerid][0],0);
	PlayerTextDrawBackgroundColor(playerid,WlPanel[playerid][0],0x000000FF);
	PlayerTextDrawFont(playerid,WlPanel[playerid][0],3);
	PlayerTextDrawUseBox(playerid,WlPanel[playerid][0],0);
	PlayerTextDrawSetOutline(playerid,WlPanel[playerid][0],0);
	PlayerTextDrawSetProportional(playerid,WlPanel[playerid][0],1);
	PlayerTextDrawSetShadow(playerid,WlPanel[playerid][0],1);

	WlPanel[playerid][1] = CreatePlayerTextDraw(playerid,51,236,"~r~Prijavio: ~w~Banka");
	PlayerTextDrawLetterSize(playerid,WlPanel[playerid][1],0.299999,1.600000);
	PlayerTextDrawAlignment(playerid,WlPanel[playerid][1],0);
	PlayerTextDrawBackgroundColor(playerid,WlPanel[playerid][1],0x000000FF);
	PlayerTextDrawFont(playerid,WlPanel[playerid][1],1);
	PlayerTextDrawUseBox(playerid,WlPanel[playerid][1],0);
	PlayerTextDrawSetOutline(playerid,WlPanel[playerid][1],0);
	PlayerTextDrawSetProportional(playerid,WlPanel[playerid][1],1);
	PlayerTextDrawSetShadow(playerid,WlPanel[playerid][1],1);

	WlPanel[playerid][2] = CreatePlayerTextDraw(playerid,51,253,"~r~Zlocin: ~w~Pljacka banke");
	PlayerTextDrawLetterSize(playerid,WlPanel[playerid][2],0.299999,1.500000);
	PlayerTextDrawAlignment(playerid,WlPanel[playerid][2],0);
	PlayerTextDrawBackgroundColor(playerid,WlPanel[playerid][2],0x000000FF);
	PlayerTextDrawFont(playerid,WlPanel[playerid][2],1);
	PlayerTextDrawUseBox(playerid,WlPanel[playerid][2],0);
	PlayerTextDrawSetOutline(playerid,WlPanel[playerid][2],0);
	PlayerTextDrawSetProportional(playerid,WlPanel[playerid][2],1);
	PlayerTextDrawSetShadow(playerid,WlPanel[playerid][2],1);

	WlPanel[playerid][3] = CreatePlayerTextDraw(playerid,51,266,"~r~WantedLevel: ~w~6");
	PlayerTextDrawLetterSize(playerid,WlPanel[playerid][3],0.349999,1.400000);
	PlayerTextDrawAlignment(playerid,WlPanel[playerid][3],0);
	PlayerTextDrawBackgroundColor(playerid,WlPanel[playerid][3],0x000000FF);
	PlayerTextDrawFont(playerid,WlPanel[playerid][3],1);
	PlayerTextDrawUseBox(playerid,WlPanel[playerid][3],0);
	PlayerTextDrawSetOutline(playerid,WlPanel[playerid][3],0);
	PlayerTextDrawSetProportional(playerid,WlPanel[playerid][3],1);
	PlayerTextDrawSetShadow(playerid,WlPanel[playerid][3],1);

	WlPanel[playerid][4] = CreatePlayerTextDraw(playerid,53,279,"~r~---------------");
	PlayerTextDrawLetterSize(playerid,WlPanel[playerid][4],0.500000,1.000000);
	PlayerTextDrawAlignment(playerid,WlPanel[playerid][4],0);
	PlayerTextDrawBackgroundColor(playerid,WlPanel[playerid][4],0x000000FF);
	PlayerTextDrawFont(playerid,WlPanel[playerid][4],3);
	PlayerTextDrawUseBox(playerid,WlPanel[playerid][4],0);
	PlayerTextDrawSetOutline(playerid,WlPanel[playerid][4],0);
	PlayerTextDrawSetProportional(playerid,WlPanel[playerid][4],1);
	PlayerTextDrawSetShadow(playerid,WlPanel[playerid][4],1);
	//--------------------------------------------------------------------------
	return 1;
}
//==============================================================================
Freeze(playerid)
{
 	TogglePlayerControllable(playerid,0);
 	SetTimerEx("unfreeze",(PlayerInfo[playerid][pUcitavanje]*1000),false,"d",playerid);
 	GameTextForPlayer(playerid,"~b~Ucitavanje",(PlayerInfo[playerid][pUcitavanje]*1000),4);
	return 1;
}
//==============================================================================
AGM(playerid)
{
 	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
	    if(!AdminDuty[playerid]) { return false; } else { return true; }
	}
	else if(PlayerInfo[playerid][pGameMaster] >= 1)
	{
	    if(!GameMasterDuty[playerid]) { return false; } else { return true; }
	}
	return false;
}
//==============================================================================
SendAdminMessage(message[])
{
	foreach(Player,i)
	{
 		if(PlayerInfo[i][pAdmin] >= 1)
		{
  			SCM(i,-1,message);
		}
	}
	return 1;
}
//==============================================================================
SendGameMasterMessage(message[])
{
	foreach(Player,i)
	{
 		if(PlayerInfo[i][pGameMaster] >= 1)
		{
  			SCM(i,-1,message);
		}
	}
	return 1;
}
//==============================================================================
#define ADMIN_LOG "/Logs/AdminLog.ini"
#define KREDIT_LOG "/Logs/KreditLog.ini"
#define REG_LOG "/Logs/Registracija.ini"
#define POLICIJA_LOG "/Logs/Policija.ini"
#define DAJ_LOG "/Logs/Daj.ini"
#define BUG_LOG "/Logs/Bug.ini" 
#define QPATH "/Banovani/%s.ini"
#define SPECNICKPATH "/SpecNickovi/%s.ini"

Log(file[],text[])
{
	new File:fl = fopen(file,io_append);
	new strr[200];
	new sec,minu,hour,day,month,year;
	gettime(hour,minu,sec);
	getdate(year,month,day);
	format(strr,sizeof(strr),"\r\n[%d/%d/%d][%d:%d:%d] %s",day,month,year,hour,minu,sec,text);
	fwrite(fl,strr);
	fclose(fl);
	return 1;
}
//==============================================================================
ProvjeraZaVozilo(playerid, vehicleid)
{
	if(Locked[vehicleid] == 1)
	{
		ClearAnimations(playerid);
		GameTextForPlayer(playerid,"~r~Zakljucano",1000,3);
	}
	else if(Locked[vehicleid] == 2)
	{
        for(new i=0;i<sizeof(Kamion);i++) {
     		if(vehicleid == Kamion[i]) {
	        	if(PlayerInfo[playerid][pPosao] != KAMIONDZIJA) {
					ClearAnimations(playerid);
					GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); } } }
        for(new i=0;i<sizeof(FarmerVozilo);i++) {
     		if(vehicleid == FarmerVozilo[i]) {
	        	if(PlayerInfo[playerid][pPosao] != FARMER) {
					ClearAnimations(playerid);
					GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); } } }
        for(new i=0;i<sizeof(GradevinarVozilo);i++) {
     		if(vehicleid == GradevinarVozilo[i]) {
	        	if(PlayerInfo[playerid][pPosao] != GRADEVINAR) {
					ClearAnimations(playerid);
					GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); } } }
        for(new i=0;i<sizeof(TRB);i++) {
     		if(vehicleid == TRB[i]) {
	        	if(PlayerInfo[playerid][pOrgID] != THE_RED_BRIGADE) {
					ClearAnimations(playerid);
					GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); } } }
        for(new i=0;i<sizeof(TEC);i++) {
     		if(vehicleid == TEC[i]) {
	        	if(PlayerInfo[playerid][pOrgID] != THE_ESCOBAR_CARTEL) {
					ClearAnimations(playerid);
					GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); } } }
        for(new i=0;i<sizeof(yakuza);i++) {
     		if(vehicleid == yakuza[i]) {
	        	if(PlayerInfo[playerid][pOrgID] != YAKUZA) {
					ClearAnimations(playerid);
					GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); } } }
        for(new i=0;i<sizeof(lcn);i++) {
     		if(vehicleid == lcn[i]) {
	        	if(PlayerInfo[playerid][pOrgID] != LCN) {
					ClearAnimations(playerid);
					GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); } } }
        for(new i=0;i<sizeof(gsf);i++) {
     		if(vehicleid == gsf[i]) {
	        	if(PlayerInfo[playerid][pOrgID] != GSF) {
					ClearAnimations(playerid);
					GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); } } }
        for(new i=0;i<sizeof(ballas);i++) {
     		if(vehicleid == ballas[i]) {
	        	if(PlayerInfo[playerid][pOrgID] != BALLAS) {
					ClearAnimations(playerid);
					GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); } } }
        for(new i=0;i<sizeof(vagos);i++) {
     		if(vehicleid == vagos[i]) {
	        	if(PlayerInfo[playerid][pOrgID] != VAGOS) {
					ClearAnimations(playerid);
					GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); } } }
        for(new i=0;i<sizeof(artez);i++) {
     		if(vehicleid == artez[i]) {
	        	if(PlayerInfo[playerid][pOrgID] != ARTEZ) {
					ClearAnimations(playerid);
					GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); } } }
		for(new i=0;i<sizeof(policija);i++) {
     		if(vehicleid == policija[i]) {
	        	if(PlayerInfo[playerid][pOrgID] != POLICIJA) {
					ClearAnimations(playerid);
					GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); } } }
        for(new i=0;i<sizeof(royalboys);i++) {
     		if(vehicleid == royalboys[i]) {
	        	if(PlayerInfo[playerid][pOrgID] != ROYAL_BOYS) {
					ClearAnimations(playerid);
					GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); } } }
	}
	return 1;
}
//==============================================================================
ParanBroj(broj)
{
  	new ostatak = broj % 2;
	if(ostatak > 0) return false;
	return true;
}
//==============================================================================
GetPlayerID(pName[])
{
	new playerid = INVALID_PLAYER_ID;
	sscanf(pName,"u",playerid);
	return playerid;
}
//==============================================================================
IsPointInRangeOfPoint(Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2, Float:range)
{
	x2 -= x;
	y2 -= y;
	z2 -= z;
	return ((x2 * x2) + (y2 * y2) + (z2 * z2)) < (range * range);
}
//==============================================================================
Placa(playerid)
{
  	new str[150],str1[300];
	PlayerInfo[playerid][pSatiOnline]++;
	new iskustvo = PlayerInfo[playerid][pLevel] * 2;
	if(dupliexp)
 	{
  		if(PlayerInfo[playerid][pLevel] < 5)
    	{
   			PlayerInfo[playerid][pEXP] += 3;
		}
		else
		{
		    PlayerInfo[playerid][pEXP] += 2;
		}
	}
	if(!dupliexp)
	{
	    if(PlayerInfo[playerid][pLevel] < 5)
     	{
    		PlayerInfo[playerid][pEXP] += 2;
		}
		else
		{
		    PlayerInfo[playerid][pEXP]++;
		}
	}
	if(PlayerInfo[playerid][pEXP] >= iskustvo)
	{
 		PlayerInfo[playerid][pLevel]++;
   		if(PlayerInfo[playerid][pEXP] == iskustvo) { PlayerInfo[playerid][pEXP] = 0; }
   		else{ PlayerInfo[playerid][pEXP] = PlayerInfo[playerid][pEXP]-iskustvo; }
     	SetPlayerScore(playerid,PlayerInfo[playerid][pLevel]);
     	GivePlayerMoney(playerid,PlayerInfo[playerid][pLevel]*50000);
     	PlayerInfo[playerid][pMoney] += PlayerInfo[playerid][pLevel]*50000;
		format(str,sizeof(str),""zuta"\nDobili ste levelup i %d$!",PlayerInfo[playerid][pLevel]*50000);
		strcat(str1,str);
	}
	new pl;
	if(PlayerInfo[playerid][pPlaca] >= 1)
	{
	    PlayerInfo[playerid][pBankMoney] += PlayerInfo[playerid][pPlaca];
	    pl = PlayerInfo[playerid][pPlaca];
	    PlayerInfo[playerid][pPlaca] = 0;
	    UpdateBankaZlatoTD(playerid);
	}
	if(PlayerInfo[playerid][pAdmin] > 1)
	{
	    PlayerInfo[playerid][pBankMoney] += (PlayerInfo[playerid][pAdmin]*10000)+40000;
	}
	if(PlayerInfo[playerid][pGameMaster] > 1)
	{
	    PlayerInfo[playerid][pBankMoney] += (PlayerInfo[playerid][pGameMaster]*5000)+20000;
	}
	if(PlayerInfo[playerid][pImaKredit])
	{
	    if(PlayerInfo[playerid][pBankMoney] < PlayerInfo[playerid][pRataKredita])
	    {
	    	GivePlayerMoney(playerid,-PlayerInfo[playerid][pRataKredita]);
	    	PlayerInfo[playerid][pMoney] -= PlayerInfo[playerid][pRataKredita];
		}
		else
		{
			PlayerInfo[playerid][pBankMoney] -= PlayerInfo[playerid][pRataKredita];
		}
		PlayerInfo[playerid][pKolicinaKredita] -= PlayerInfo[playerid][pRataKredita];
		format(str,sizeof(str),""crvena"\nNaplacene su rate kredita u iznosu od %d$!",PlayerInfo[playerid][pRataKredita]);
		strcat(str1,str);
		if(PlayerInfo[playerid][pKolicinaKredita] <= 0)
		{
		    PlayerInfo[playerid][pImaKredit] = false;
		    PlayerInfo[playerid][pRataKredita] = 0;
			format(str,sizeof(str),""zuta"\nUspjesno ste otplatili kredit!");
			strcat(str1,str);
		}
	}
	format(str,sizeof(str),""crvena"\n");
	strcat(str1,str);
	format(str,sizeof(str),""zuta"\nNovac: "bijela"%d$",PlayerInfo[playerid][pMoney]);
	strcat(str1,str);
	if(PlayerInfo[playerid][pBankovniRacun])
	{
		format(str,sizeof(str),""zuta"\nNovac u banci: "bijela"%d$",PlayerInfo[playerid][pBankMoney]);
		strcat(str1,str);
	}
	format(str,sizeof(str),""zuta"\nLevel: "bijela"%d",PlayerInfo[playerid][pLevel]);
	strcat(str1,str);
	format(str,sizeof(str),""zuta"\nRespekti: "bijela"%d/%d",PlayerInfo[playerid][pEXP],(PlayerInfo[playerid][pLevel] * 2));
	strcat(str1,str);
	if(PlayerInfo[playerid][pImaKredit])
	{
		format(str,sizeof(str),""zuta"\nKredit: "bijela"%d$",PlayerInfo[playerid][pKolicinaKredita]);
		strcat(str1,str);
    	format(str,sizeof(str),""zuta"\nRata kredita: "bijela"%d$",PlayerInfo[playerid][pRataKredita]);
		strcat(str1,str);
	}
	if(PlayerInfo[playerid][pPosao] != -1)
	{
		format(str,sizeof(str),""zuta"\nPlaca: "bijela"%d$",pl);
		strcat(str1,str);
	}
	if(PlayerInfo[playerid][pAdmin] > 1)
	{
		format(str,sizeof(str),""zuta"\nAdmin placa: "bijela"%d$",(PlayerInfo[playerid][pAdmin]*10000)+40000);
		strcat(str1,str);
	}
	if(PlayerInfo[playerid][pGameMaster] > 1)
	{
		format(str,sizeof(str),""zuta"\nGameMaster placa: "bijela"%d$",(PlayerInfo[playerid][pGameMaster]*5000)+20000);
		strcat(str1,str);
	}
	PlayerInfo[playerid][pTime] = 0;
	UpdateBankaZlatoTD(playerid);
	SacuvajIgraca(playerid);
   	SetPlayerScore(playerid,PlayerInfo[playerid][pLevel]);
   	ShowPlayerDialog(playerid,DIALOG_PLACA,DIALOG_STYLE_MSGBOX,""plava""IME" - Placa:",str1,""plava"Ok","");
	return 1;
}
//==============================================================================
Aktivnost(playerid,txt[])
{
	new str2[300],Float:x,Float:y,Float:z;
	new pnm[MAX_PLAYER_NAME];
	if(Marama[playerid]) { format(pnm,sizeof(pnm),"Stranac"); } else { format(pnm,sizeof(pnm),"%s",GetName(playerid)); }
	format(str2,sizeof(str2),""aktivnost"%s %s",pnm,txt);
	GetPlayerPos(playerid,x,y,z);
	foreach(Player,i)
	{
	    if(Ulogovan[i] && IsPlayerInRangeOfPoint(i,20.0,x,y,z) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && GetPlayerInterior(i) == GetPlayerInterior(playerid)
	    && PlayerInfo[playerid][pUbizzu] == PlayerInfo[i][pUbizzu] && PlayerInfo[playerid][pUkuci] == PlayerInfo[i][pUkuci] && PlayerInfo[playerid][pUorg] == PlayerInfo[i][pUorg] && PlayerInfo[playerid][pUstanu] == PlayerInfo[i][pUstanu])
	    {
	        SCM(i,-1,str2);
	    }
	}
	return 1;
}
//==============================================================================
new VehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
	"Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
	"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
	"Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
	"Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
	"Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
	"Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
	"Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
	"Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
	"Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
	"Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
	"Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
	"Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
	"Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin",
	"Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
	"Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
 	"Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
 	"FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
 	"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
 	"Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
	"Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
	"Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
	"Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
	"Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
	"News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
 	"Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
 	"Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
 	"Tiller", "Utility Trailer"
};

GetVehicleName(vehicleid)
{
	new str[50];
	format(str,sizeof(str),"%s",VehicleNames[GetVehicleModel(vehicleid) - 400]);
	return str;
}
//==============================================================================
UpdateBankaZlatoTD(playerid)
{
	new str[50];
	if(PlayerInfo[playerid][pBankovniRacun])
	{
		if(PlayerInfo[playerid][pBankMoney] < 999999999) { format(str,sizeof(str),"%09d$",PlayerInfo[playerid][pBankMoney]);
		}else{ format(str,sizeof(str),"%d$",PlayerInfo[playerid][pBankMoney]); }
	}
	else
	{
	    format(str,sizeof(str),"~r~N/A",PlayerInfo[playerid][pBankMoney]);
	}
	PlayerTextDrawSetString(playerid,BankaTD[playerid],str);
 	format(str,sizeof(str),"%dg",PlayerInfo[playerid][pZlato]);
	PlayerTextDrawSetString(playerid,ZlatoTD[playerid],str);
	return 1;
}
//==============================================================================
GetPlayerSpeed(playerid,bool:kmh)
{
    new Float:Vx,Float:Vy,Float:Vz,Float:rtn;
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),Vx,Vy,Vz); else GetPlayerVelocity(playerid,Vx,Vy,Vz);
    rtn = floatsqroot(floatabs(floatpower(Vx + Vy + Vz,2)));
    return kmh?floatround(rtn * 100 * 1.61):floatround(rtn * 100);
}
//==============================================================================
IsMotorOn(veh)
{
    new engine, lightss, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(veh, engine, lightss, alarm, doors, bonnet, boot, objective);
	if(engine == 1) return true;
	return false;
}
//==============================================================================
GetXYBehindVehicle(vehicleid, &Float:q, &Float:w, Float:distance)
{
    new Float:a;
    GetVehiclePos(vehicleid, q, w, a);
    GetVehicleZAngle(vehicleid, a);
    q += (distance * -floatsin(-a, degrees));
    w += (distance * -floatcos(-a, degrees));
}
//==============================================================================
GetPosBehindVehicle(vehicleid, &Float:x, &Float:y, &Float:z, Float:offset=0.5)
{
    new Float:vehicleSize[3], Float:vehiclePos[3];
    GetVehiclePos(vehicleid, vehiclePos[0], vehiclePos[1], vehiclePos[2]);
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, vehicleSize[0], vehicleSize[1], vehicleSize[2]);
    GetXYBehindVehicle(vehicleid, vehiclePos[0], vehiclePos[1], (vehicleSize[1]/2)+offset);
    x = vehiclePos[0];
    y = vehiclePos[1];
    z = vehiclePos[2];
    return 1;
}
//==============================================================================
IsTrunkOpened(veh)
{
    new engine, lightss, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(veh, engine, lightss, alarm, doors, bonnet, boot, objective);
	if(boot == 1) return true;
	return false;
}
//==============================================================================
VoziloJeAvion(id)
{
	if(id == 592 || id == 577 || id == 511 || id == 512 || id == 593 || id == 520 || id == 553 || id == 476 || id == 519 || id == 460 || id == 513) return true;
	else if(id == 548 || id == 425 || id == 417 || id == 487 || id == 488 || id == 497 || id == 563 || id == 447 || id == 469) return true;
	else return false;
}
//==============================================================================
VoziloJeBrod(id)
{
  	if(id == 472 || id == 473 || id == 493 || id == 484 || id == 430 || id == 454 || id == 453 || id == 452 || id == 446) return true;
  	return false;
}
//==============================================================================
VoziloJeMotor(id)
{
	if(id == 462 || id == 448 || id == 581 || id == 522 || id == 461 || id == 521 || id == 523 || id == 463 || id == 468 || id == 471) return true;
	return false;
}
//==============================================================================
VoziloJeKamion(id)
{
	if(id == 499 || id == 498 || id == 609 || id == 524 || id == 578 || id == 455 || id == 403 || id == 414 || id == 443 || id == 514 || id == 515 || id == 408 || id == 431 || id == 437 || id == 538) return true;
	return false;
}
//==============================================================================
VoziloJeBicikl(id)
{
	if(id == 481 || id == 509 || id == 510) return true;
	return false;
}
//==============================================================================
forward Float:GetDistanceBetweenPlayers(p1,p2);
public Float:GetDistanceBetweenPlayers(p1,p2)
{
	new Float:xa1,Float:ya1,Float:za1,Float:xa2,Float:ya2,Float:za2;
	if(!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
	{
		return -1.00;
	}
	GetPlayerPos(p1,xa1,ya1,za1);
	GetPlayerPos(p2,xa2,ya2,za2);
	return floatsqroot(floatpower(floatabs(floatsub(xa2,xa1)),2)+floatpower(floatabs(floatsub(ya2,ya1)),2)+floatpower(floatabs(floatsub(za2,za1)),2));
}
//==============================================================================
stock SendOrgMessage(playerid,message[])
{
	foreach(Player,i)
	{
		if(PlayerInfo[playerid][pOrgID] == PlayerInfo[i][pOrgID] && PlayerInfo[playerid][pOrgID] != -1 && PlayerInfo[i][pOrgID] != -1)
		{
		    SCM(i,-1,message);
		}
	}
	return 1;
}
//==============================================================================
ShowStats(towho,playerid)
{
	new str2[1300],string[300];
    new plrIP[16];
	new stxt[20];
	if(PlayerInfo[playerid][pSpol] == 1) { stxt = "Musko"; }
	else if(PlayerInfo[playerid][pSpol] == 2) { stxt = "Zensko"; }
	new vip[50];
	if(PlayerInfo[playerid][pVip] >= 1) { format(vip,sizeof(vip),""zelena"Da "bijela"(Level %d)",PlayerInfo[playerid][pVip]); } else { vip = ""crvena"Ne"; }
	new oname[30];
	if(PlayerInfo[playerid][pOrgID] == -1) { format(oname,sizeof(oname),""crvena"Nema"); }
	else { format(oname,sizeof(oname),"%s (ID: %d)",OrgInfo[PlayerInfo[playerid][pOrgID]][oName],PlayerInfo[playerid][pOrgID]); }
	new btxt[40];
	if(PlayerInfo[playerid][pBizzID] == -1) { format(btxt,sizeof(btxt),""crvena"Nema"); }
	else { format(btxt,sizeof(btxt),"%s (ID: %d)",VrstaBiznisa(PlayerInfo[playerid][pBizzID]),PlayerInfo[playerid][pBizzID]); }
    new ktxt[40];
	if(PlayerInfo[playerid][pKucaID] == -1) { format(ktxt,sizeof(ktxt),""crvena"Nema"); }
	else { format(ktxt,sizeof(ktxt),"%s (ID: %d)",VrstaKuce(PlayerInfo[playerid][pKucaID]),PlayerInfo[playerid][pKucaID]); }
	new ptxt[40];
	if(PlayerInfo[playerid][pPosao] == -1) { format(ptxt,sizeof(ptxt),""crvena"Nema"); }
	else { format(ptxt,sizeof(ptxt),"%s (ID: %d)",JobInfo[PlayerInfo[playerid][pPosao]][jName],PlayerInfo[playerid][pPosao]); }
	new vtxt[50];
	if(PlayerInfo[playerid][pVozilo][0] == -1) { format(vtxt,sizeof(vtxt),""crvena"Nema"); }
	else { format(vtxt,sizeof(vtxt),"%s (ID: %d)",GetVehicleName(VoziloInfo[PlayerInfo[playerid][pVozilo][0]][vID]),VoziloInfo[PlayerInfo[playerid][pVozilo][0]][vID]); }
	new vtxt1[50];
	if(PlayerInfo[playerid][pVozilo][1] == -1) { format(vtxt1,sizeof(vtxt1),""crvena"Nema"); }
	else { format(vtxt1,sizeof(vtxt1),"%s (ID: %d)",GetVehicleName(VoziloInfo[PlayerInfo[playerid][pVozilo][1]][vID]),VoziloInfo[PlayerInfo[playerid][pVozilo][1]][vID]); }
	new vtxt2[50];
	if(PlayerInfo[playerid][pVozilo][2] == -1) { format(vtxt2,sizeof(vtxt2),""crvena"Nema"); }
	else { format(vtxt2,sizeof(vtxt2),"%s (ID: %d)",GetVehicleName(VoziloInfo[PlayerInfo[playerid][pVozilo][2]][vID]),VoziloInfo[PlayerInfo[playerid][pVozilo][2]][vID]); }
	new sstxt[40];
	if(PlayerInfo[playerid][pStanID] == -1) { format(sstxt,sizeof(sstxt),""crvena"Nema"); }
	else { format(sstxt,sizeof(sstxt),""zelena"Da "bijela"(ID: %d)",PlayerInfo[playerid][pStanID]); }
	GetPlayerIp(playerid, plrIP, sizeof(plrIP));
	format(str2, sizeof(str2),""plava">> Ime: "plava"%s \n"plava">> "bijela"Level: "plava"%d \n"plava">> "bijela"Respekti: "plava"%d/%d \n"plava">> "bijela"Spol: "plava"%s\n",GetName(playerid),PlayerInfo[playerid][pLevel],PlayerInfo[playerid][pEXP],(PlayerInfo[playerid][pLevel] * 2),stxt);
	format(string, sizeof(string), ""plava">> "bijela"Online sati: "plava"%d \n"plava">> "bijela"IP: "plava"%s \n"plava">> "bijela"Novac: "plava"%d$ \n"plava">> "bijela"Biznis: "plava"%s\n",PlayerInfo[playerid][pSatiOnline],plrIP,GetPlayerMoney(playerid),btxt);
	strcat(str2,string);
	format(string, sizeof(string), ""plava">> "bijela"Novac banka: "plava"%d$ \n"plava">> "bijela"Posao: "plava"%s \n"plava">> "bijela"Kuca: "plava"%s \n"plava">> "bijela"Stan: "plava"%s\n"plava">> "bijela"Cigarete: "plava"%d\n", PlayerInfo[playerid][pBankMoney],ptxt,ktxt,sstxt,PlayerInfo[playerid][pCigarete]);
	strcat(str2,string);
	format(string, sizeof(string), ""plava">> "bijela"Organizacija: "plava"%s \n"plava">> "bijela"Rank: "plava"%d \n"plava">> "bijela"Droga: "plava"%dg \n"plava">> "bijela"Mats: "plava"%dg\n", oname,PlayerInfo[playerid][pRank],PlayerInfo[playerid][pDroga],PlayerInfo[playerid][pMats]);
	strcat(str2,string);
	format(string, sizeof(string), ""plava">> "bijela"Dozvola: "plava"/dozvole \n"plava">> "bijela"Vozilo 1: "plava"%s \n"plava">> "bijela"Vozilo 2: "plava"%s \n"plava">> "bijela"Vozilo 3: "plava"%s\n"plava">> "bijela"Sjeme droge: "plava"%d\n",vtxt,vtxt1,vtxt2,PlayerInfo[playerid][pSjemeDroge]);
	strcat(str2,string);
	format(string, sizeof(string), ""plava">> "bijela"Marame: "plava"%d \n"plava">> "bijela"Mobilni kredit: "plava"%d$ \n"plava">> "bijela"Dinamit: "plava"%d\n",PlayerInfo[playerid][pMarama],PlayerInfo[playerid][pMobilniKredit],PlayerInfo[playerid][pDinamit]);
	strcat(str2,string);
	format(string, sizeof(string), ""plava">> "bijela"Vip: "plava"%s \n"plava">> "bijela"Do isteka vipa: "plava"%d sekundi\n"plava">> "bijela"Placa: "plava"%d$ \n",vip,PlayerInfo[playerid][pVipTime],PlayerInfo[playerid][pPlaca]);
	strcat(str2,string);
	format(string, sizeof(string), ""plava"Datum registracije: "bijela"%d/%d/%d "plava"Vrijeme: "bijela"%d:%d:%d \n",PlayerInfo[playerid][pRegDan],PlayerInfo[playerid][pRegMje],PlayerInfo[playerid][pRegGod],PlayerInfo[playerid][pRegSat],PlayerInfo[playerid][pRegMin],PlayerInfo[playerid][pRegSec]);
	strcat(str2,string);
	ShowPlayerDialog(towho,DIALOG_STATS,DIALOG_STYLE_MSGBOX,""plava""IME" - Stats:",str2,""bijela"Ok","");
	return 1;
}
//==============================================================================
//polaganje
Polaganje(playerid,id)
{
    polaganje[playerid] = -1;
	PolaganjeVrsta[playerid] = -1;
	SetPlayerVirtualWorld(playerid,(playerid+1));
	SetPlayerInterior(playerid,0);
	if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
	{
		DestroyVehicle(PolaganjeVehicle[playerid]);
		PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
	}
	if(id == 0)
	{
		PolaganjeVehicle[playerid] = CreateVehicle(410,2063.0820,-1896.8362,13.2723,0.7066,9,39,100);
		SetGorivo(PolaganjeVehicle[playerid]);
		SetVehicleVirtualWorld(PolaganjeVehicle[playerid], (playerid+1));
		PutPlayerInVehicle(playerid,PolaganjeVehicle[playerid],0);
		SetPlayerCheckpoint(playerid,2057.8354,-1876.7603,13.2728,4.0);
		GameTextForPlayer(playerid,"~g~Idite do mjesta oznacenog na karti!",3500,3);
		AUTOSKOLA(playerid,"Krenuli ste s polaganjem!");
        AUTOSKOLA(playerid,"Vozilo upalite s tipkom 2!");
        AUTOSKOLA(playerid,"Krenite do mjesta oznacenog na mapi!");
		polaganje[playerid] = 0;
		PolaganjeVrsta[playerid] = id;
	}
	else if(id == 1)
	{
		PolaganjeVehicle[playerid] = CreateVehicle(461,2063.0820,-1896.8362,13.2723,0.7066,9,39,100);
		SetGorivo(PolaganjeVehicle[playerid]);
		SetVehicleVirtualWorld(PolaganjeVehicle[playerid], (playerid+1));
		PutPlayerInVehicle(playerid,PolaganjeVehicle[playerid],0);
		SetPlayerCheckpoint(playerid,2057.8354,-1876.7603,13.2728,4.0);
		GameTextForPlayer(playerid,"~g~Idite do mjesta oznacenog na karti!",3500,3);
		AUTOSKOLA(playerid,"Krenuli ste s polaganjem!");
        AUTOSKOLA(playerid,"Vozilo upalite s tipkom 2!");
        AUTOSKOLA(playerid,"Krenite do mjesta oznacenog na mapi!");
		polaganje[playerid] = 0;
		PolaganjeVrsta[playerid] = id;
	}
	else if(id == 2)
	{
		PolaganjeVehicle[playerid] = CreateVehicle(403,2063.0820,-1896.8362,13.2723,0.7066,9,39,100);
		SetGorivo(PolaganjeVehicle[playerid]);
		SetVehicleVirtualWorld(PolaganjeVehicle[playerid], (playerid+1));
		PutPlayerInVehicle(playerid,PolaganjeVehicle[playerid],0);
		SetPlayerCheckpoint(playerid,2057.8354,-1876.7603,13.2728,4.0);
		GameTextForPlayer(playerid,"~g~Idite do mjesta oznacenog na karti!",3500,3);
		AUTOSKOLA(playerid,"Krenuli ste s polaganjem!");
        AUTOSKOLA(playerid,"Vozilo upalite s tipkom 2!");
        AUTOSKOLA(playerid,"Krenite do mjesta oznacenog na mapi!");
		polaganje[playerid] = 0;
		PolaganjeVrsta[playerid] = id;
	}
	return 1;
}
//==============================================================================
RpName(playerid)
{
	new pname[MAX_PLAYER_NAME],underline=0;
    GetPlayerName(playerid, pname, sizeof(pname));
    if(strfind(pname,"[",true) != (-1)) return 0;
    else if(strfind(pname,"]",true) != (-1)) return 0;
    else if(strfind(pname,"$",true) != (-1)) return 0;
    else if(strfind(pname,"(",true) != (-1)) return 0;
    else if(strfind(pname,")",true) != (-1)) return 0;
    else if(strfind(pname,"=",true) != (-1)) return 0;
    else if(strfind(pname,"@",true) != (-1)) return 0;
    else if(strfind(pname,"1",true) != (-1)) return 0;
    else if(strfind(pname,"2",true) != (-1)) return 0;
    else if(strfind(pname,"3",true) != (-1)) return 0;
    else if(strfind(pname,"4",true) != (-1)) return 0;
    else if(strfind(pname,"5",true) != (-1)) return 0;
    else if(strfind(pname,"6",true) != (-1)) return 0;
    else if(strfind(pname,"7",true) != (-1)) return 0;
    else if(strfind(pname,"8",true) != (-1)) return 0;
    else if(strfind(pname,"9",true) != (-1)) return 0;
    new maxname = strlen(pname);
    for(new i=0; i<maxname; i++)
    {
       if(pname[i] == '_') underline ++;
    }
    if(underline != 1) return 0;
    pname[0] = toupper(pname[0]);
    for(new x=1; x<maxname; x++)
    {
        if(pname[x] == '_') pname[x+1] = toupper(pname[x+1]);
        else if(pname[x] != '_' && pname[x-1] != '_') pname[x] = tolower(pname[x]);
    }
	return true;
}
//==============================================================================
EventCount(playerid,bool:freeze)
{
	EventKaunt[playerid] = 3;
	new st = 0;
	if(freeze) { TogglePlayerControllable(playerid,0); st = 1; }
 	eventcounttimer[playerid] = SetTimerEx("eventcount",1000,true,"dd",playerid,st);
	GameTextForPlayer(playerid,"~b~3",1000,3);
	return 1;
}
//==============================================================================
main()
{
	print("\n----------------------------------");
	print(" ProjectX by Vuk ");
	print("----------------------------------\n");
}
//==============================================================================
public OnGameModeInit()
{
	//--------------------------------------------------------------------------
	SetGameModeText(GAME_MODE_TEXT);
	SendRconCommand(RCON_PASSWORD);
	//--------------------------------------------------------------------------
	AddPlayerClass(0, 101.4395, -2111.5193, 36.7996, 269.1425, 0, 0, 0, 0, 0, 0);
	//--------------------------------------------------------------------------
	DisableInteriorEnterExits();
	ShowNameTags(1);
	ShowPlayerMarkers(0);
	EnableStuntBonusForAll(0);
	ManualVehicleEngineAndLights();
	//--------------------------------------------------------------------------
	SetTimer("place",40000,true);
	SetTimer("OnPlayerUpdateEx",1000,true);
	SetTimer("MinuteTimer",60000,true);
	SetTimer("vozila",1000,true);
	//--------------------------------------------------------------------------
	CreateTextDraws();
 	//--------------------------------------------------------------------------
 	SendRconCommand("loadfs mapa");
 	//--------------------------------------------------------------------------
 	LoadBizz();
 	bplaca = false;
 	//--------------------------------------------------------------------------
 	LoadServer();
 	//--------------------------------------------------------------------------
 	new x;
 	for(new t=0;t<MAX_TELEPORTS;t++)
	{
		new strt[20];
	  	format(strt,sizeof(strt),TPATH,t);
	  	if(fexist(strt))
		{
			INI_ParseFile(strt,"LoadTeleport",.bExtra = true,.extra = t);
			x++;
		}
	}
	printf("Ucitano %d teleporta!",x);
 	//--------------------------------------------------------------------------
 	x=0;
 	for(new g=0;g<MAX_GPS;g++)
	{
		new strt[20];
	  	format(strt,sizeof(strt),GPATH,g);
	  	if(fexist(strt))
		{
			INI_ParseFile(strt,"LoadGps",.bExtra = true,.extra = g);
			x++;
		}
	}
	printf("Ucitano %d gps lokacija!",x);
 	//--------------------------------------------------------------------------
	BankaPickup[0] = CreateDynamicPickup(1239, 1, 1454.7629,-1010.1432,26.8438, 0); // banka ulaz
    BankaPickup[1] = CreateDynamicPickup(1239, 1, 653.9196,352.7068,668.6714, 1); // banka izlaz
    BankaPickup[2] = CreateDynamicPickup(1239, 1, 655.5286,360.4723,668.6714, 1); // /banka
    BankaPickup[3] = CreateDynamicPickup(1239, 1, 645.2234,390.9962,668.6772, 1); // /transfer
    BankaPickup[4] = CreateDynamicPickup(1239, 1, 649.3770,390.7099,668.6772, 1); // /otplatikredit
    BankaPickup[5] = CreateDynamicPickup(1239, 1, 653.2974,390.6435,668.6772, 1); // /kredit
    
   	BankaText[0] = Create3DTextLabel(""zelena"[BANKA]\n"bijela"Za ulazak pritisnite '"zelena"F"bijela"' ili '"zelena"ENTER"bijela"'", -1, 1454.7629,-1010.1432,26.8438 , 20.0, 0, 0);
    BankaText[1] = Create3DTextLabel(""zelena"[BANKA]\n\n"bijela"Da upravljate bankovnim racunom upisite "bijela"'"zelena"/banka"bijela"'", -1, 655.5286,360.4723,668.6714 , 20.0, 1, 0);
    BankaText[2] = Create3DTextLabel(""zelena"[BANKA]\n\n"bijela"Da posaljete nekome novac upisite "bijela"'"zelena"/transfer"bijela"'", -1, 645.2234,390.9962,668.6772 , 20.0, 1, 0);
    BankaText[3] = Create3DTextLabel(""zelena"[BANKA]\n\n"bijela"Da otplatite kredit upisite "bijela"'"zelena"/otplatikredit"bijela"'", -1, 649.3770,390.7099,668.6772 , 20.0, 1, 0);
    BankaText[4] = Create3DTextLabel(""zelena"[BANKA]\n\n"bijela"Da podignete kredit upisite "bijela"'"zelena"/kredit"bijela"'", -1, 653.2974,390.6435,668.6772 , 20.0, 1, 0);
    //--------------------------------------------------------------------------
    LoadBankomate();
	//--------------------------------------------------------------------------
	KreirajPoslove();
    //--------------------------------------------------------------------------
	//kamiondzija
	new Vozilo = INVALID_VEHICLE_ID;
	Vozilo = CreateVehicle(515, 2468.7751, -2107.4951, 14.6091, -0.1200, 3, 3, 100); Locked[Vozilo] = 2; Kamion[0] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(515, 2460.5095, -2107.3391, 14.6091, 0.0000, 3, 3, 100); Locked[Vozilo] = 2; Kamion[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(515, 2452.3862, -2107.6785, 14.6091, -0.1200, 3, 3, 100); Locked[Vozilo] = 2; Kamion[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(515, 2475.6367, -2107.4517, 14.6091, 0.0000, 3, 3, 100); Locked[Vozilo] = 2; Kamion[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(515, 2483.7983, -2107.2551, 14.6091, -0.0600, 3, 3, 100); Locked[Vozilo] = 2; Kamion[4] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(515, 2493.7573, -2107.7285, 14.6091, 0.1200, 3, 3, 100); Locked[Vozilo] = 2; Kamion[5] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(515, 2500.1565, -2107.5637, 14.6091, 0.0000, 3, 3, 100); Locked[Vozilo] = 2; Kamion[6] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(515, 2509.2786, -2107.6665, 14.6091, 0.0000, 3, 3, 100); Locked[Vozilo] = 2; Kamion[7] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(515, 2517.3042, -2107.8789, 14.6091, 0.0000, 3, 3, 100); Locked[Vozilo] = 2; Kamion[8] = Vozilo; SetGorivo(Vozilo);
	
	Vozilo = CreateVehicle(584, 2697.5405, -2127.3953, 14.6802, 0.0000, 0, 0, -1); Prikolica[0] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(584, 2692.5400, -2127.3953, 14.6802, 0.0000, 0, 0, -1); Prikolica[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(584, 2687.6382, -2127.3953, 14.6802, 0.0000, 0, 0, -1); Prikolica[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(584, 2682.5828, -2127.3953, 14.6802, 0.0000, 0, 0, -1); Prikolica[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(584, 2677.6284, -2127.3953, 14.6802, 0.0000, 0, 0, -1); Prikolica[4] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(584, 2672.1772, -2127.3953, 14.6802, 0.0000, 0, 0, -1); Prikolica[5] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(584, 2437.9678, -2075.7346, 14.3657, 179.6357, 0, 0, -1); Prikolica[6] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(584, 2448.9429, -2075.2959, 14.3657, 179.6357, 0, 0, -1); Prikolica[7] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(584, 2458.3494, -2075.3206, 14.3657, 179.6357, 0, 0, -1); Prikolica[8] = Vozilo; SetGorivo(Vozilo);
	
	utovar = true;
	//--------------------------------------------------------------------------
	//farmer
	Vozilo = CreateVehicle(532, -369.4301, -1499.7250, 26.5735, 288.0000, 5, 5, 100); Locked[Vozilo] = 2; FarmerVozilo[0] = Vozilo; SetGorivo(Vozilo);//kombajni
	Vozilo = CreateVehicle(532, -380.7776, -1466.3099, 26.5735, 288.0000, 5, 5, 100); Locked[Vozilo] = 2; FarmerVozilo[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(532, -377.5208, -1475.0809, 26.5735, 288.0000, 5, 5, 100); Locked[Vozilo] = 2; FarmerVozilo[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(532, -374.7683, -1483.2540, 26.5735, 288.0000, 5, 5, 100); Locked[Vozilo] = 2; FarmerVozilo[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(532, -372.2101, -1491.4584, 26.5735, 288.0000, 5, 5, 100); Locked[Vozilo] = 2; FarmerVozilo[4] = Vozilo; SetGorivo(Vozilo);
	
	Vozilo = CreateVehicle(531, -367.6626, -1437.3738, 25.3554, 91.4791, 5, 5, 100); Locked[Vozilo] = 2; FarmerVozilo[5] = Vozilo; SetGorivo(Vozilo);//traktori
	Vozilo = CreateVehicle(531, -382.3689, -1453.0104, 25.5269, 3.0821, 5, 5, 100); Locked[Vozilo] = 2; FarmerVozilo[6] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(531, -378.7630, -1453.1431, 25.5269, 3.0821, 5, 5, 100); Locked[Vozilo] = 2; FarmerVozilo[7] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(531, -375.5825, -1451.9375, 25.5269, 3.0821, 5, 5, 100); Locked[Vozilo] = 2; FarmerVozilo[8] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(531, -372.7311, -1450.4548, 25.5269, 3.0821, 5, 5, 100); Locked[Vozilo] = 2; FarmerVozilo[9] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(531, -367.7241, -1443.2452, 25.3554, 91.4791, 5, 5, 100); Locked[Vozilo] = 2; FarmerVozilo[10] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(531, -367.6722, -1440.5316, 25.3554, 91.4791, 5, 5, 100); Locked[Vozilo] = 2; FarmerVozilo[11] = Vozilo; SetGorivo(Vozilo);
	
	Vozilo = CreateVehicle(610, -364.5518, -1437.3503, 24.9435, 93.2529, 5, 5, 100); FarmerPrikolica[0] = Vozilo; SetGorivo(Vozilo);//prikolice
	Vozilo = CreateVehicle(610, -382.2199, -1455.9207, 24.9435, 0.0000, 5, 5, 100); FarmerPrikolica[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(610, -378.6859, -1456.0248, 24.9435, 0.0000, 5, 5, 100); FarmerPrikolica[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(610, -375.5364, -1454.9189, 24.9435, 0.0000, 5, 5, 100); FarmerPrikolica[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(610, -372.6439, -1453.3706, 24.9435, 0.0000, 5, 5, 100); FarmerPrikolica[4] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(610, -364.6688, -1443.2682, 24.9435, 93.2529, 5, 5, 100); FarmerPrikolica[5] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(610, -364.6360, -1440.4580, 24.9435, 93.2529, 5, 5, 100); FarmerPrikolica[6] = Vozilo; SetGorivo(Vozilo);
    new Text3D:fprikolica[sizeof(FarmerPrikolica)];
	new ftxt[10];
	for(new i=0;i<sizeof(FarmerPrikolica);i++)
	{
	    format(ftxt,sizeof(ftxt),"%d",FarmerPrikolica[i]);
	    fprikolica[i] = Create3DTextLabel(ftxt, -1, 0.0, 0.0, 0.0, 20.0, 0, 1 );
	    Attach3DTextLabelToVehicle(fprikolica[i],FarmerPrikolica[i], 0.0, 0.0, 0.0);
	}
	//--------------------------------------------------------------------------
	//gradevinar
	Vozilo = CreateVehicle(524, 1285.3651, -1352.2393, 13.9928, 89.4648, -1, -1, 100); Locked[Vozilo] = 2; GradevinarVozilo[0] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(524, 1306.8306, -1334.8859, 14.0607, 91.4011, -1, -1, 100); Locked[Vozilo] = 2; GradevinarVozilo[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(524, 1306.6812, -1339.2323, 14.0607, 90.6798, -1, -1, 100); Locked[Vozilo] = 2; GradevinarVozilo[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(524, 1285.2394, -1359.9502, 13.9928, 89.4648, -1, -1, 100); Locked[Vozilo] = 2; GradevinarVozilo[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(524, 1285.2394, -1364.3627, 13.9928, 89.4648, -1, -1, 100); Locked[Vozilo] = 2; GradevinarVozilo[4] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(524, 1306.8225, -1343.7056, 14.0607, 88.4486, -1, -1, 100); Locked[Vozilo] = 2; GradevinarVozilo[5] = Vozilo; SetGorivo(Vozilo);
	/*
 	CreateDynamicObject(19380, 1275.36609, -1327.40283, 12.27528,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19380, 1285.89319, -1327.38708, 12.27528,   0.00000, 90.00000, 0.00000);
	CreateDynamicObject(19380, 1293.51038, -1327.49915, 12.27528,   0.00000, 90.00000, 0.00000);
	*/
	gradevinarutovar[0] = false;
	gradevinarutovar[1] = false;
	gradevinarutovar[2] = false;
	//--------------------------------------------------------------------------
	//zavarivac
	ZavarivacPickup[0] = CreateDynamicPickup(1239, 1, 1314.9347,-1346.1732,18.9857, 0);
    ZavarivacPickup[1] = CreateDynamicPickup(1239, 1, 1299.1201,-1358.0764,18.9857, 0);
    ZavarivacPickup[2] = CreateDynamicPickup(1239, 1, 1298.4414,-1370.8756,18.9857, 0);
    ZavarivacPickup[3] = CreateDynamicPickup(1239, 1, 1298.0878,-1383.3872,18.9857, 0);
    
    ZavarivacText[0] = Create3DTextLabel(""roza"[ZAVARIVAC 1]\n"bijela"Za zavariti upisite '"roza"/zavari"bijela"'", -1, 1314.9347,-1346.1732,18.9857 , 20.0, 0, 0);
    ZavarivacText[1] = Create3DTextLabel(""roza"[ZAVARIVAC 2]\n"bijela"Za zavariti upisite '"roza"/zavari"bijela"'", -1, 1299.1201,-1358.0764,18.9857 , 20.0, 0, 0);
    ZavarivacText[2] = Create3DTextLabel(""roza"[ZAVARIVAC 3]\n"bijela"Za zavariti upisite '"roza"/zavari"bijela"'", -1, 1298.4414,-1370.8756,18.9857 , 20.0, 0, 0);
    ZavarivacText[3] = Create3DTextLabel(""roza"[ZAVARIVAC 4]\n"bijela"Za zavariti upisite '"roza"/zavari"bijela"'", -1, 1298.0878,-1383.3872,18.9857 , 20.0, 0, 0);
    //--------------------------------------------------------------------------
	//opstina
   	CreateDynamicPickup(1239, 1, 1123.1215,-2036.8429,69.8936, 0); // opstina ulaz
    CreateDynamicPickup(1239, 1, -829.3412,1432.2792,689.9901, 2); // opstina izlaz
    CreateDynamicPickup(1239, 1, -813.6876,1501.3594,687.2899, 2); //otkaz
    CreateDynamicPickup(1239, 1, -819.5416,1501.3571,687.2899, 2); //poslovi

   	Create3DTextLabel(""zuta"[OPSTINA]\n"bijela"Za ulazak pritisnite '"zuta"F"bijela"' ili '"zuta"ENTER"bijela"'", -1, 1123.1215,-2036.8429,69.8936 , 20.0, 0, 0);
    Create3DTextLabel(""zuta"[OPSTINA]\n\n"bijela"Ukoliko zelite dati otkaz upisite "bijela"'"zuta"/otkaz"bijela"'", -1, -813.6876,1501.3594,687.2899 , 20.0, 2, 0);
    Create3DTextLabel(""zuta"[OPSTINA]\n\n"bijela"Da vidite listu poslova i njihove lokacije upisite "bijela"'"zuta"/poslovi"bijela"'", -1, -819.5416,1501.3571,687.2899 , 20.0, 2, 0);
    //--------------------------------------------------------------------------
    //zlatara
    CreateDynamicPickup(1239, 1, 2793.2649,-1087.4554,30.7188, 0); // zlatara ulaz
    CreateDynamicPickup(1239, 1, 2838.1379,-1118.9884,-79.1271, 3); // zlatara izlaz
    CreateDynamicPickup(1239, 1, 2824.4622,-1070.4570,-78.9915, 3); // prodajzlato
    CreateDynamicPickup(1239, 1, 2836.4536,-1070.2576,-78.9915, 3); // kupizlato
    Create3DTextLabel(""zuta"[ZLATARA]\n"bijela"Za ulazak pritisnite '"zuta"F"bijela"' ili '"zuta"ENTER"bijela"'", -1, 2793.2649,-1087.4554,30.7188, 20.0, 0, 0);
    Create3DTextLabel(""zuta"[ZLATARA]\n\n"bijela"Da prodate zlato upisite "bijela"'"zuta"/prodajzlato"bijela"'", -1, 2824.4622,-1070.4570,-78.9915 , 20.0, 3, 0);
    Create3DTextLabel(""zuta"[ZLATARA]\n\n"bijela"Da kupite zlato upisite "bijela"'"zuta"/kupizlato"bijela"'", -1, 2836.4536,-1070.2576,-78.9915 , 20.0, 3, 0);
    //--------------------------------------------------------------------------
    LoadKuce();
    //--------------------------------------------------------------------------
    new str12[20];
	format(str12,sizeof(str12),"Rekord: %d",ServerInfo[sRekord]);
	TextDrawSetString(IgTextDraws[16],str12);
	Online=0;
	//--------------------------------------------------------------------------
	UpdatePoruke();
	//--------------------------------------------------------------------------
	LoadBenzinske();
	//--------------------------------------------------------------------------
	UcitajVozila();
	//--------------------------------------------------------------------------
	CreateDynamicPickup(1239, 1, 1765.0228,-1761.0403,13.8795, 0); // autosalon ulaz
	CreateDynamicPickup(1239, 1, 1767.7019,-1761.0333,13.8998, 0); // autosalon izlaz
	CreateDynamicPickup(1239, 1, 1781.5028,-1782.7031,13.8998, 0); // autosalon katalog
    CreateDynamicPickup(1239, 1, 1781.9479,-1789.0289,13.8998, 0); // autosalon katalog
    CreateDynamicPickup(1239, 1, 1781.7378,-1797.0691,13.8998, 0); // autosalon katalog
    
    Create3DTextLabel(""crvena"[AUTOSALON]\n"bijela"Za ulazak pritisnite '"zuta"F"bijela"' ili '"zuta"ENTER"bijela"'", -1,1765.0228,-1761.0403,13.8795, 20.0, 0, 0);
    Create3DTextLabel(""crvena"[AUTOSALON]\n\n"bijela"Da kupite vozilo upisite "bijela"'"zuta"/katalog"bijela"'", -1, 1781.5028,-1782.7031,13.8998, 20.0, 0, 0);
    Create3DTextLabel(""crvena"[AUTOSALON]\n\n"bijela"Da kupite vozilo upisite "bijela"'"zuta"/katalog"bijela"'", -1, 1781.9479,-1789.0289,13.8998, 20.0, 0, 0);
    Create3DTextLabel(""crvena"[AUTOSALON]\n\n"bijela"Da kupite vozilo upisite "bijela"'"zuta"/katalog"bijela"'", -1, 1781.7378,-1797.0691,13.8998, 20.0, 0, 0);
    
    Vozilo = CreateVehicle(411,1778.9023,-1749.3735,14.2460,176.9194,3,2,1); SetGorivo(Vozilo,0); Locked[Vozilo] = 1;
	Vozilo = CreateVehicle(429,1770.0701,-1749.5220,14.2252,219.9448,2,3,1); SetGorivo(Vozilo,0); Locked[Vozilo] = 1;
	//--------------------------------------------------------------------------
	CreateDynamicPickup(1239, 1, 2958.9890,-2055.5378,-0.0533, 0);
    Create3DTextLabel(""crvena"[SAJAM]\n\n"bijela"Da prodate brod upisite "bijela"'"zuta"/v sell [slot]"bijela"'", -1, 2958.9890,-2055.5378,-0.0533, 10.0, 0, 0);
    
    CreateDynamicPickup(1239, 1, -2053.2981,-109.8786,35.2944, 0);
    Create3DTextLabel(""crvena"[SAJAM]\n\n"bijela"Da prodate vozilo upisite "bijela"'"zuta"/v sell [slot]"bijela"'", -1, -2053.2981,-109.8786,35.2944, 10.0, 0, 0);
	//--------------------------------------------------------------------------
	KreirajOrganizacije();
	//--------------------------------------------------------------------------
	//the red brigades
	Vozilo = CreateVehicle(560, 1224.4092, -1068.3977, 28.8120, 0.1907, 3, 3, 500); TRB[0] = Vozilo; SetGorivo(Vozilo); Locked[Vozilo] = 2;
	Vozilo = CreateVehicle(560, 1207.0845, -1100.9425, 24.9666, 359.9004, 3, 3, 500); TRB[1] = Vozilo; SetGorivo(Vozilo); Locked[Vozilo] = 2;
	Vozilo = CreateVehicle(560, 1221.3608, -1052.3988, 31.5243, 91.2414, 3, 3, 500); TRB[2] = Vozilo; SetGorivo(Vozilo); Locked[Vozilo] = 2;
	Vozilo = CreateVehicle(470, 1201.5222, -1075.3810, 28.8959, 0.5674, 3, 3, 500); TRB[3] = Vozilo; SetGorivo(Vozilo); Locked[Vozilo] = 2;
	Vozilo = CreateVehicle(470, 1222.4728, -1101.0928, 25.2098, 0.5674, 3, 3, 500); TRB[4] = Vozilo; SetGorivo(Vozilo); Locked[Vozilo] = 2;
	Vozilo = CreateVehicle(470, 1224.4012, -1075.6482, 28.8959, 0.5674, 3, 3, 500); TRB[5] = Vozilo; SetGorivo(Vozilo); Locked[Vozilo] = 2;
	Vozilo = CreateVehicle(560, 1202.3940, -1100.8018, 24.9899, 359.3621, 3, 3, 500); TRB[6] = Vozilo; SetGorivo(Vozilo); Locked[Vozilo] = 2;
	Vozilo = CreateVehicle(560, 1201.7369, -1068.7456, 28.8120, 0.1907, 3, 3, 500); TRB[7] = Vozilo; SetGorivo(Vozilo); Locked[Vozilo] = 2;
	//--------------------------------------------------------------------------
	//the escobar cartel
	Vozilo = CreateVehicle(560, 661.1880, -1290.1294, 13.1656, 178.8438, 6, 6, 500); Locked[Vozilo] = 2; TEC[0] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(560, 661.2159, -1271.6693, 13.1689, 180.4783, 6, 6, 500); Locked[Vozilo] = 2; TEC[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(560, 689.7713, -1231.3042, 15.7033, 117.6046, 6, 6, 500); Locked[Vozilo] = 2; TEC[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(560, 669.1132, -1286.5891, 13.1656, 179.2572, 6, 6, 500); Locked[Vozilo] = 2; TEC[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(560, 669.4547, -1251.0106, 13.4314, 166.2373, 6, 6, 500); Locked[Vozilo] = 2; TEC[4] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(560, 680.0801, -1227.8905, 15.2891, 122.4954, 6, 6, 500); Locked[Vozilo] = 2; TEC[5] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(429, 691.9266, -1221.9406, 16.1299, 118.8042, 6, 6, 500); Locked[Vozilo] = 2; TEC[6] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(429, 702.8887, -1223.2489, 16.7430, 118.8042, 6, 6, 500); Locked[Vozilo] = 2; TEC[7] = Vozilo; SetGorivo(Vozilo);
	//--------------------------------------------------------------------------
	//yakuza
	Vozilo = CreateVehicle(579, 884.3239, -1658.4808, 13.2518, 178.6436, 0, 0, 500); Locked[Vozilo] = 2; yakuza[0] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(579, 884.2721, -1669.1477, 13.3523, 359.0878, 0, 0, 500); Locked[Vozilo] = 2; yakuza[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(522, 874.4588, -1669.3906, 13.1201, 2.7472, 0, 0, 500); Locked[Vozilo] = 2; yakuza[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(522, 874.5701, -1657.6530, 13.1091, 180.8501, 0, 0, 500); Locked[Vozilo] = 2; yakuza[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(451, 888.3269, -1658.3207, 13.2524, 178.7651, 0, 0, 500); Locked[Vozilo] = 2; yakuza[4] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(451, 888.5485, -1669.0535, 13.2579, 357.6991, 0, 0, 500); Locked[Vozilo] = 2; yakuza[5] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(451, 892.8478, -1669.0997, 13.2579, 357.6991, 0, 0, 500); Locked[Vozilo] = 2; yakuza[6] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(451, 892.5311, -1658.2953, 13.2524, 178.7651, 0, 0, 500); Locked[Vozilo] = 2; yakuza[7] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(560, 869.8763, -1669.4064, 13.2523, 359.0878, 0, 0, 500); Locked[Vozilo] = 2; yakuza[8] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(560, 869.8472, -1658.4037, 13.2518, 177.1998, 0, 0, 500); Locked[Vozilo] = 2; yakuza[9] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(560, 879.8367, -1658.3785, 13.2518, 177.1998, 0, 0, 500); Locked[Vozilo] = 2; yakuza[10] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(560, 879.7624, -1669.2584, 13.2523, 359.0878, 0, 0, 500); Locked[Vozilo] = 2; yakuza[11] = Vozilo; SetGorivo(Vozilo);
    //--------------------------------------------------------------------------
    //LCN
	Vozilo = CreateVehicle(560, 1688.6538, -1253.6305, 14.3099, 269.4091, 4, 4, 500); Locked[Vozilo] = 2; lcn[0] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(560, 1688.2802, -1259.6598, 14.3099, 269.4091, 4, 4, 500); Locked[Vozilo] = 2; lcn[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(579, 1689.1207, -1265.4713, 14.5504, 270.3449, 4, 4, 500); Locked[Vozilo] = 2; lcn[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(506, 1673.9200, -1256.1406, 14.4484, 89.9176, 4, 4, 500); Locked[Vozilo] = 2; lcn[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(579, 1689.0919, -1269.4513, 14.5504, 270.3449, 4, 4, 500); Locked[Vozilo] = 2; lcn[4] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(579, 1674.6409, -1269.0415, 14.5504, 89.9176, 4, 4, 500); Locked[Vozilo] = 2; lcn[5] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(579, 1674.2482, -1264.5659, 14.5504, 89.9176, 4, 4, 500); Locked[Vozilo] = 2; lcn[6] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(506, 1674.0331, -1259.8926, 14.4484, 89.9176, 4, 4, 500); Locked[Vozilo] = 2; lcn[7] = Vozilo; SetGorivo(Vozilo);
	//--------------------------------------------------------------------------
	//gsf
	Vozilo = CreateVehicle(467, 2498.4734, -1655.8527, 12.9527, 76.9198, 86, 86, 500); Locked[Vozilo] = 2; gsf[0] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(467, 2486.1614, -1681.9353, 12.9527, 261.3972, 86, 86, 500); Locked[Vozilo] = 2; gsf[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(566, 2497.1880, -1681.8929, 12.9434, 283.5294, 86, 86, 500); Locked[Vozilo] = 2; gsf[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(566, 2470.8569, -1655.4087, 12.9434, 91.8831, 86, 86, 500); Locked[Vozilo] = 2; gsf[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(566, 2475.9314, -1679.5878, 12.9434, 235.2348, 86, 86, 500); Locked[Vozilo] = 2; gsf[4] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(566, 2484.0886, -1655.2781, 12.9434, 87.4427, 86, 86, 500); Locked[Vozilo] = 2; gsf[5] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(467, 2470.3179, -1670.7039, 12.9527, 189.9193, 86, 86, 500); Locked[Vozilo] = 2; gsf[6] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(467, 2508.1897, -1671.7407, 12.9527, 347.1644, 86, 86, 500); Locked[Vozilo] = 2; gsf[7] = Vozilo; SetGorivo(Vozilo);
    //--------------------------------------------------------------------------
    //ballas
	Vozilo = CreateVehicle(483, 2244.3323, -1449.9479, 23.7971, 268.8860, 126, 126, 500); Locked[Vozilo] = 2; ballas[0] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(483, 2232.6702, -1449.7693, 23.7971, 268.8860, 126, 126, 500); Locked[Vozilo] = 2; ballas[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(466, 2233.0798, -1417.5308, 23.5459, 89.7308, 126, 126, 500); Locked[Vozilo] = 2; ballas[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(466, 2267.7959, -1439.2496, 23.5459, 352.2877, 126, 126, 500); Locked[Vozilo] = 2; ballas[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(466, 2257.7458, -1417.4167, 23.5459, 89.7308, 126, 126, 500); Locked[Vozilo] = 2; ballas[4] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(419, 2268.8860, -1429.0096, 23.5459, 354.1307, 126, 126, 500); Locked[Vozilo] = 2; ballas[5] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(483, 2253.1270, -1449.7966, 23.7971, 268.8860, 126, 126, 500); Locked[Vozilo] = 2; ballas[6] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(466, 2241.9541, -1417.5043, 23.5459, 89.7308, 126, 126, 500); Locked[Vozilo] = 2; ballas[7] = Vozilo; SetGorivo(Vozilo);
    //--------------------------------------------------------------------------
    //vagos
	Vozilo = CreateVehicle(466, 1810.1132, -1988.9261, 13.1875, 145.6402, 6, 6, 500); Locked[Vozilo] = 2; vagos[0] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(466, 1792.7515, -2016.2396, 13.1875, 269.6281, 6, 6, 500); Locked[Vozilo] = 2; vagos[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(518, 1817.8792, -2029.4752, 13.1270, 179.4422, 6, 6, 500); Locked[Vozilo] = 2; vagos[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(518, 1796.0503, -1990.8489, 13.1670, 208.8747, 6, 6, 500); Locked[Vozilo] = 2; vagos[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(518, 1828.4738, -2029.1946, 13.1270, 179.4422, 6, 6, 500); Locked[Vozilo] = 2; vagos[4] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(518, 1828.6534, -2020.4119, 13.1270, 179.4422, 6, 6, 500); Locked[Vozilo] = 2; vagos[5] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(518, 1817.7439, -2021.0436, 13.1270, 179.4422, 6, 6, 500); Locked[Vozilo] = 2; vagos[6] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(466, 1792.8209, -2011.9230, 13.1875, 269.6281, 6, 6, 500); Locked[Vozilo] = 2; vagos[7] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(466, 1800.1351, -1988.6528, 13.1875, 210.1177, 6, 6, 500); Locked[Vozilo] = 2; vagos[8] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(466, 1804.8223, -1987.8661, 13.1875, 183.6609, 6, 6, 500); Locked[Vozilo] = 2; vagos[9] = Vozilo; SetGorivo(Vozilo);
    //--------------------------------------------------------------------------
    //artez
	Vozilo = CreateVehicle(533, 2574.7327, -1133.2504, 64.6970, 326.6674, 7, 7, 500); Locked[Vozilo] = 2; artez[0] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(533, 2569.2837, -1133.8046, 64.6970, 326.6674, 7, 7, 500); Locked[Vozilo] = 2; artez[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(547, 2593.7363, -1127.1204, 65.1495, 347.0000, 7, 7, 500); Locked[Vozilo] = 2; artez[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(547, 2579.1763, -1133.2571, 64.9309, 327.7050, 7, 7, 500); Locked[Vozilo] = 2; artez[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(547, 2584.1162, -1132.4016, 64.9309, 328.0000, 7, 7, 500); Locked[Vozilo] = 2; artez[4] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(547, 2605.3213, -1129.0710, 65.1495, 347.0000, 7, 7, 500); Locked[Vozilo] = 2; artez[5] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(547, 2597.4084, -1127.7872, 65.1495, 347.0000, 7, 7, 500); Locked[Vozilo] = 2; artez[6] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(547, 2601.1101, -1128.6122, 65.1495, 347.0000, 7, 7, 500); Locked[Vozilo] = 2; artez[7] = Vozilo; SetGorivo(Vozilo);
    //--------------------------------------------------------------------------
    //policija
    Vozilo = CreateVehicle(497, 1565.9073, -1647.6958, 23.4362, 89.6070, 0, 1, 100); Locked[Vozilo] = 2; policija[0] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(497, 1557.2754, -1670.3748, 23.4362, 91.9310, 0, 1, 100); Locked[Vozilo] = 2; policija[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(596, 1592.6685, -1668.6246, 13.4427, 89.0865, 0, 1, 100); Locked[Vozilo] = 2; policija[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(596, 1551.3188, -1699.0750, 13.4427, 178.8194, 0, 1, 100); Locked[Vozilo] = 2; policija[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(596, 1554.7170, -1699.2096, 13.4427, 178.8194, 0, 1, 100); Locked[Vozilo] = 2; policija[4] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(596, 1558.1558, -1699.4541, 13.4427, 178.8194, 0, 1, 100); Locked[Vozilo] = 2; policija[5] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(599, 1556.1650, -1716.4685, 13.8127, 359.0631, 0, 1, 100); Locked[Vozilo] = 2; policija[6] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(599, 1542.5044, -1715.7463, 13.8127, 359.0631, 0, 1, 100); Locked[Vozilo] = 2; policija[7] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(601, 1580.8044, -1664.8459, 13.4114, 259.1812, 0, 1, 100); Locked[Vozilo] = 2; policija[8] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(601, 1581.0764, -1655.5850, 13.4114, 260.3910, 0, 1, 100); Locked[Vozilo] = 2; policija[9] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(427, 1579.5195, -1680.4395, 13.7294, 265.4347, 0, 1, 100); Locked[Vozilo] = 2; policija[10] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(427, 1580.4786, -1670.3497, 13.7294, 260.7503, 0, 1, 100); Locked[Vozilo] = 2; policija[11] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(427, 1579.5398, -1675.4535, 13.7294, 262.5000, 0, 1, 100); Locked[Vozilo] = 2; policija[12] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(601, 1580.9619, -1660.0358, 13.4114, 260.3910, 0, 1, 100); Locked[Vozilo] = 2; policija[13] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(599, 1546.7034, -1715.8158, 13.8127, 359.0631, 0, 1, 100); Locked[Vozilo] = 2; policija[14] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(599, 1551.2878, -1716.1321, 13.8127, 359.0631, 0, 1, 100); Locked[Vozilo] = 2; policija[15] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(596, 1561.6184, -1699.4529, 13.4427, 178.8194, 0, 1, 100); Locked[Vozilo] = 2; policija[16] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(596, 1593.2032, -1643.3738, 13.4427, 89.0865, 0, 1, 100); Locked[Vozilo] = 2; policija[17] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(596, 1593.2169, -1650.1738, 13.4427, 89.0865, 0, 1, 100); Locked[Vozilo] = 2; policija[18] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(596, 1593.0555, -1656.7305, 13.4427, 89.0865, 0, 1, 100); Locked[Vozilo] = 2; policija[19] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(596, 1592.8857, -1662.8188, 13.4427, 89.0865, 0, 1, 100); Locked[Vozilo] = 2; policija[20] = Vozilo; SetGorivo(Vozilo);

	pdvrata = CreateDynamicObject(1495, 245.42877, 72.52780, 1002.59729,   0.00000, 0.00000, 0.00000);
	pdvratastate = false; 
	Create3DTextLabel(""bijela"Pritisnite '"smeda"H"bijela"' ili '"smeda"C"bijela"'.", -1, 245.42877, 72.52780, 1002.59729 , 20.0, 9, 0);
	rampa = CreateDynamicObject(968, 1539.96008, -1702.42566, 13.30480,   0.00000, 88.00000, 270.00000); 
	rampastate = false;
	Create3DTextLabel(""bijela"Pritisnite '"smeda"H"bijela"' ili '"smeda"C"bijela"'.", -1, 1539.96008, -1702.42566, 13.30480 , 20.0, 0, 0);
	Create3DTextLabel(""smeda"[POLICIJA]\n"bijela"Za odlazak do krova pritisnite '"zelena"F"bijela"' ili '"zelena"ENTER"bijela"'", -1, 246.3414,87.8023,1003.6406 , 5.0, 9, 0);
	CreateDynamicPickup(1239, 1, 246.3414,87.8023,1003.6406, 9);
    Create3DTextLabel(""smeda"[POLICIJA]\n"bijela"Za odlazak u policiju pritisnite '"zelena"F"bijela"' ili '"zelena"ENTER"bijela"'", -1, 1549.5526,-1651.2445,23.3800 , 5.0, 0, 0);
    CreateDynamicPickup(1239, 1, 1549.5526,-1651.2445,23.3800, 0);
    Create3DTextLabel(""smeda"[POLICIJA]\n"bijela"Da uhapsite igraca upisite '"zelena"/uhapsi"bijela"'", -1, 247.2204,86.7935,1003.6406, 5.0, 9, 0);
	CreateDynamicPickup(1239, 1, 247.2204,86.7935,1003.6406, 9);
	Create3DTextLabel(""smeda"[POLICIJA]\n"bijela"Da uzmete duznost upisite '"zelena"/pdduznost"bijela"'.\n\n"bijela"Da uzmete opremu upisite '"zelena"/pdoprema"bijela"'.", -1, 257.0870,76.1152,1003.6406, 10.0, 9, 0);
	CreateDynamicPickup(1239, 1, 257.0870,76.1152,1003.6406, 9);
	Create3DTextLabel(""smeda"[POLICIJA]\n"bijela"Da kupite dozvolu za oruzje upisite '"zelena"/kupidozvoluo"bijela"'.\n"bijela"Cijena: "zelena"200000$", -1, 249.7552,69.3670,1003.6406, 10.0, 9, 0);
	CreateDynamicPickup(1239, 1, 249.7552,69.3670,1003.6406, 9);
	//--------------------------------------------------------------------------
    //autoskola
    Create3DTextLabel(""zelena"[AUTOSKOLA]\n"bijela"Za ulazak pritisnite '"zelena"F"bijela"' ili '"zelena"ENTER"bijela"'.", -1, 2055.9624,-1914.2329,13.5680 , 20.0, 0, 0);
	CreateDynamicPickup(1239, 1, 2055.9624,-1914.2329,13.5680, 0);
	CreateDynamicPickup(1239, 1, -2029.7234,-119.4169,1035.1719, 10);
	Create3DTextLabel(""zelena"[AUTOSKOLA]\n"bijela"Za polaganje upisite '"zelena"/polaganje"bijela"'.", -1, -2033.4346,-117.4143,1035.1719 , 20.0, 10, 0);
	CreateDynamicPickup(1239, 1, -2033.4346,-117.4143,1035.1719, 10);
	//--------------------------------------------------------------------------
	//crno trziste
	CreateActor(67, 2738.55029, 2803.21533, 10.84649,   171.4694);
	CreateActor(67, 2745.29370, 2814.86548, 26.71170,   171.4694);
	CreateActor(67, 2724.06860, 2803.16479, 10.84649,   171.4694);
	Create3DTextLabel(""bijela"Pritisnite '"smeda"H"bijela"' ili '"smeda"C"bijela"'.\n"bijela"Cijena "crvena"20000$", -1, 2731.35522, 2806.04370, 12.47020 , 20.0, 0, 0);
	crnotrzistekapija = CreateDynamicObject(980, 2731.35522, 2806.04370, 12.47020,   0.00000, 0.00000, 178.56200);
    crnotrzistekapijastate = false;
    
    Create3DTextLabel(""smeda"[CRNO TRZISTE]\n"zuta"Da kupite oruzje upisite "bijela"'/ckupioruzje'.",-1,2723.1421,2839.9314,10.8203,5,0,0);
    CreateDynamicPickup(1239, 1, 2723.1421,2839.9314,10.8203, 0);//crno trziste oruzje
    Create3DTextLabel(""smeda"[CRNO TRZISTE]\n"zuta"Da kupite mats upisite "bijela"'/ckupimats'.\n"zuta"Da prodate mats upisite "bijela"'/cprodajmats'.\n"zuta"Da napravite oruzje koristite "bijela"'/cnapravioruzje'.",-1,2722.5085,2849.5295,10.8203,5,0,0);
 	CreateDynamicPickup(1239, 1, 2722.5085,2849.5295,10.8203, 0);//crno trziste za materijale
 	Create3DTextLabel(""smeda"[CRNO TRZISTE]\n"zuta"Da kupite drogu upisite "bijela"'/ckupidrogu'.",-1,2739.4673,2851.0493,10.8203,5,0,0);
 	CreateDynamicPickup(1239, 1, 2739.4673,2851.0493,10.8203, 0);//crno trziste kupovina droge
 	Create3DTextLabel(""smeda"[CRNO TRZISTE]\n"zuta"Da prodate drogu upisite "bijela"'/cprodajdrogu'.",-1,2743.5481,2851.8738,10.8203,5,0,0);
 	CreateDynamicPickup(1239, 1, 2743.5481,2851.8738,10.8203, 0);//crno trziste prodaj drogu
 	Create3DTextLabel(""smeda"[CRNO TRZISTE]\n"zuta"Da kupite sjeme za drogu upisite "bijela"'/ckupisjeme'.\n"zuta"Da kupite dinamit upisite "bijela"'/ckupidinamit'.",-1,2740.1699,2839.8335,10.8203,5,0,0);
 	CreateDynamicPickup(1239, 1, 2740.1699,2839.8335,10.8203, 0);//crno trziste sjeme za drogu
	//--------------------------------------------------------------------------
	LoadRents();
	//--------------------------------------------------------------------------
	KreirajZone();
	zplaca = false;
	//--------------------------------------------------------------------------
	new welcometext[200];
	format(welcometext,sizeof(welcometext),"Dobrodosli na "plava""IME""bijela"!\n"plava"Verzija moda:"bijela" "GAME_MODE_TEXT"\n"bijela"Za pomoc upisite '"plava"/pomoc"bijela"'!");
	Create3DTextLabel(welcometext,-1,164.7789,-1495.7941,12.5958,20,0,1);
	CreateDynamicPickup(18749, 1, 164.7789,-1495.7941,12.5958, 0);
	//--------------------------------------------------------------------------
	//banka pljacka
	Create3DTextLabel(""crvena"Da provalite u sef pritisnite '"smeda"F"crvena"' ili '"smeda"ENTER"crvena"'.",-1,664.3455,384.0997,657.0206,2.0,1,1);
	CreateDynamicPickup(1239, 1, 664.3455,384.0997,657.0206, 1);
	Create3DTextLabel(""crvena"Da raznesete vrata pritisnite upisite '"smeda"/raznesi"crvena"'.",-1,656.7759,413.2963,651.3528,2.0,1,1);
	CreateDynamicPickup(1239, 1, 656.7759,413.2963,651.3528, 1);
    Create3DTextLabel(""crvena"Da otvorite glavna vrata upucajte masine.",-1,644.6853,406.1276,651.3528,2.0,1,1);
	CreateDynamicPickup(1239, 1, 644.6853,406.1276,651.3528, 1);
	Create3DTextLabel(""crvena"Da pokupite novac upisite '"smeda"/pokupi"crvena"'.",-1,644.5079,424.8175,651.3528,2.0,1,1);
	CreateDynamicPickup(1239, 1, 644.5079,424.8175,651.3528, 1);
	Create3DTextLabel(""crvena"Da pokupite novac upisite '"smeda"/pokupi"crvena"'.",-1,647.5455,421.3625,651.3528,2.0,1,1);
	CreateDynamicPickup(1239, 1, 647.5455,421.3625,651.3528, 1);
	Create3DTextLabel(""crvena"Da pokupite novac upisite '"smeda"/pokupi"crvena"'.",-1,652.0234,421.5735,651.3528,2.0,1,1);
	CreateDynamicPickup(1239, 1, 652.0234,421.5735,651.3528, 1);
	Create3DTextLabel(""crvena"Da pokupite novac upisite '"smeda"/pokupi"crvena"'.",-1,665.9907,424.8604,651.3528,2.0,1,1);
	CreateDynamicPickup(1239, 1, 665.9907,424.8604,651.3528, 1);
	
 	sef = CreateDynamicObject(19799, 655.800170, 413.851104, 651.811401, 0.000000, 0.000000, -178.700012);
	sefstate = false;
	
	bankavrata = CreateDynamicObject(19303, 658.511596, 411.794372, 651.572631, 0.000000, 0.000000, 92.199996);
	bankavratastate = false;
	
	masina[0] = CreateObject(19917, 643.866333, 405.646179, 650.282653, 0.000000, 0.000000, 0.000000);
	masina[1] = CreateObject(19917, 643.866333, 405.646179, 651.032470, 0.000000, 0.000000, 0.000000);
	masina[2] = CreateObject(19917, 643.866333, 406.716217, 651.032470, 0.000000, 0.000000, 0.000000);
	masina[3] = CreateObject(19917, 643.866333, 406.716217, 650.342285, 0.000000, 0.000000, 0.000000);
	iskrestate[0] = false;
	iskrestate[1] = false;
	iskrestate[2] = false;
	iskrestate[3] = false;
	novacpljacka[0] = false;
	novacpljacka[1] = false;
	novacpljacka[2] = false;
	novacpljacka[3] = false;
    //--------------------------------------------------------------------------
    //event system
    EventID = -1;
	EventPokrenut = false;
	for(new i = 0; i < sizeof(EventObjekti);i++) { EventObjekti[i] = INVALID_OBJECT_ID; }
	//--------------------------------------------------------------------------
	//royal boys
	Vozilo = CreateVehicle(560, 1248.4523, -825.0884, 83.7124, 153.5999, 30, 30, 500); Locked[Vozilo] = 2; royalboys[0] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(560, 1239.6858, -834.2718, 83.6524, 116.4599, 30, 30, 500); Locked[Vozilo] = 2; royalboys[1] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(560, 1227.2922, -836.8069, 83.7324, 76.0000, 30, 30, 500); Locked[Vozilo] = 2; royalboys[2] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(470, 1249.2982, -803.8043, 83.8130, 0.0000, 30, 30, 500); Locked[Vozilo] = 2; royalboys[3] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(470, 1254.8900, -803.7015, 83.8130, 0.0000, 30, 30, 500); Locked[Vozilo] = 2; royalboys[4] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(579, 1242.8145, -804.0948, 83.9663, 0.0000, 30, 30, 500); Locked[Vozilo] = 2; royalboys[5] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(579, 1242.7845, -812.0159, 83.9663, 0.0000, 30, 30, 500); Locked[Vozilo] = 2; royalboys[6] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(522, 1240.5657, -818.7843, 83.5452, -10.8000, 30, 30, 500); Locked[Vozilo] = 2; royalboys[7] = Vozilo; SetGorivo(Vozilo);
	Vozilo = CreateVehicle(522, 1236.7683, -825.6351, 83.5852, -59.2800, 30, 30, 500); Locked[Vozilo] = 2; royalboys[8] = Vozilo; SetGorivo(Vozilo);
	//--------------------------------------------------------------------------
    LoadStanove();
    //--------------------------------------------------------------------------
	return 1;
}
//==============================================================================
public OnGameModeExit()
{
    //--------------------------------------------------------------------------
 	SendRconCommand("unloadfs mapa");
    //--------------------------------------------------------------------------
    SacuvajServer();
	//--------------------------------------------------------------------------
    SacuvajSveBiznise();
    //--------------------------------------------------------------------------
    SacuvajSveBankomate();
    //--------------------------------------------------------------------------
    SacuvajSveKuce();
    //--------------------------------------------------------------------------
    SacuvajSveBenzinske();
    //--------------------------------------------------------------------------
    SacuvajSvaVozila();
	//--------------------------------------------------------------------------
	SacuvajSveOrganizacije();
	//--------------------------------------------------------------------------
	SacuvajSveRentove();
	//--------------------------------------------------------------------------
    SacuvajSveStanove();
	//--------------------------------------------------------------------------
	return 1;
}
//==============================================================================
public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 101.4395, -2111.5193, 36.7996);
	InterpolateCameraPos(playerid,101.4395, -2111.5193, 36.7996, 162.6619, -1841.9792, 16.9019, 30000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, 101.6731, -2110.5420, 36.6797, 163.2137, -1841.1390, 16.8970, 30000, CAMERA_MOVE);
	return 1;
}
//==============================================================================
public OnPlayerConnect(playerid)
{
	//--------------------------------------------------------------------------
	PlayerInfo[playerid][pPass] = 0; PlayerInfo[playerid][pMoney] = 0;
	PlayerInfo[playerid][pAdmin] = 0; PlayerInfo[playerid][pRegistriran] = false;
	PlayerInfo[playerid][pGodine] = 0; PlayerInfo[playerid][pDrzava] = -1;
	PlayerInfo[playerid][pSpol] = 0; PlayerInfo[playerid][pMail] = 0;
 	PlayerInfo[playerid][pLevel] = 0 ;PlayerInfo[playerid][pSkin] = 0;
 	PlayerInfo[playerid][pBizzID] = -1; PlayerInfo[playerid][pUbizzu] = -1;
 	PlayerInfo[playerid][pGameMaster] = 0; PlayerInfo[playerid][pZatvoren] = false;
    PlayerInfo[playerid][pVrijeme] = 0; PlayerInfo[playerid][pMuted] = false;
    PlayerInfo[playerid][pBankovniRacun] = false; PlayerInfo[playerid][pBankMoney] = 0;
    PlayerInfo[playerid][pImaKredit] = false; PlayerInfo[playerid][pKolicinaKredita] = 0;
    PlayerInfo[playerid][pRegGod] = 0; PlayerInfo[playerid][pRegMje] = 0;
	PlayerInfo[playerid][pRegDan] = 0; PlayerInfo[playerid][pRegSat] = 0;
	PlayerInfo[playerid][pRegMin] = 0; PlayerInfo[playerid][pRegSec] = 0;
	PlayerInfo[playerid][pPosao] = -1; PlayerInfo[playerid][pStaz] = 0;
	PlayerInfo[playerid][pPlaca] = 0; PlayerInfo[playerid][pSpawnType] = 0;
	PlayerInfo[playerid][pZlato] = 0; PlayerInfo[playerid][pTime] = 0;
	PlayerInfo[playerid][pEXP] = 0; PlayerInfo[playerid][pSatiOnline] = 0;
	PlayerInfo[playerid][pRataKredita] = 0; PlayerInfo[playerid][pDroga] = 0;
	PlayerInfo[playerid][pMats] = 0; PlayerInfo[playerid][pKucaID] = -1;
	PlayerInfo[playerid][pUkuci] = -1; PlayerInfo[playerid][pCigarete] = 0;
	PlayerInfo[playerid][pUpaljac] = 0; for(new i=0;i<MAX_SLOTS;i++) { PlayerInfo[playerid][pVozilo][i] = -1; }
    PlayerInfo[playerid][pWeapon0] = 0; PlayerInfo[playerid][pAmmo0] = 0;
    PlayerInfo[playerid][pWeapon1] = 0; PlayerInfo[playerid][pAmmo1] = 0;
    PlayerInfo[playerid][pWeapon2] = 0; PlayerInfo[playerid][pAmmo2] = 0;
    PlayerInfo[playerid][pWeapon3] = 0; PlayerInfo[playerid][pAmmo3] = 0;
    PlayerInfo[playerid][pWeapon4] = 0; PlayerInfo[playerid][pAmmo4] = 0;
    PlayerInfo[playerid][pWeapon5] = 0; PlayerInfo[playerid][pAmmo5] = 0;
    PlayerInfo[playerid][pWeapon6] = 0; PlayerInfo[playerid][pAmmo6] = 0;
    PlayerInfo[playerid][pWeapon7] = 0; PlayerInfo[playerid][pAmmo7] = 0;
    PlayerInfo[playerid][pWeapon8] = 0; PlayerInfo[playerid][pAmmo8] = 0;
    PlayerInfo[playerid][pWeapon9] = 0; PlayerInfo[playerid][pAmmo9] = 0;
    PlayerInfo[playerid][pWeapon10] = 0; PlayerInfo[playerid][pAmmo10] = 0;
    PlayerInfo[playerid][pWeapon11] = 0; PlayerInfo[playerid][pAmmo11] = 0;
    PlayerInfo[playerid][pWeapon12] = 0; PlayerInfo[playerid][pAmmo12] = 0;
    PlayerInfo[playerid][pOrgID] = -1; PlayerInfo[playerid][pRank] = 0;
   	PlayerInfo[playerid][pUorg] = -1; PlayerInfo[playerid][pWL] = 0;
 	strmid(PlayerInfo[playerid][pPrijavio], "Nitko", 0, strlen("Nitko"), MAX_PLAYER_NAME);
	strmid(PlayerInfo[playerid][pZlocin], "Nema", 0, strlen("Nema"), 64);
 	PlayerInfo[playerid][pOruzjeDozvola] = false; PlayerInfo[playerid][pVozackaDozvola] = false;
	PlayerInfo[playerid][pMotorDozvola] = false; PlayerInfo[playerid][pKamionDozvola] = false;
	PlayerInfo[playerid][pBrodDozvola] = false; PlayerInfo[playerid][pLetjeliceDozvola] = false;
	PlayerInfo[playerid][pMobitel] = false; PlayerInfo[playerid][pMobitelUkljucen] = false;
	PlayerInfo[playerid][pMobilniKredit] = 0; PlayerInfo[playerid][pSjemeDroge] = 0;
	PlayerInfo[playerid][pMarama] = 0; PlayerInfo[playerid][pDinamit] = 0;
	PlayerInfo[playerid][pVip] = 0; PlayerInfo[playerid][pVipTime] = 0;
	PlayerInfo[playerid][pUcitavanje] = 5; PlayerInfo[playerid][pChatbubble] = true;
	PlayerInfo[playerid][pVipChat] = true; PlayerInfo[playerid][pGameMasterChat] = true;
	PlayerInfo[playerid][pAdminChat] = true; PlayerInfo[playerid][pGotoSlabijih] = true;
	PlayerInfo[playerid][pGetSlabijih] = true; PlayerInfo[playerid][pKomandeSlabijih] = true;
	PlayerInfo[playerid][pMapTeleport] = false; PlayerInfo[playerid][pUze] = 0;
 	for(new i=0;i<11;i++) { PlayerInfo[playerid][pWeaponSkill][i] = 9; }
 	PlayerInfo[playerid][pStanID] = -1; PlayerInfo[playerid][pUstanu] = -1;
	
 	avozilo[playerid] = -1; EditujeBankomat[playerid] = -1;
	Ulogovan[playerid] = false; pwfail[playerid] = 0;
	AdminDuty[playerid] = false; specID[playerid] = -1;
	specType[playerid] = 0; GameMasterDuty[playerid] = false;
	PolicajacKojiGaVuce[playerid] = -1; ImaLisice[playerid] = false;
	Pitanja[playerid] = -1; GPSON[playerid] = false;
 	Opremljen[playerid] = false; Radi[playerid] = false;
 	PosaoID[playerid] = -1; KamiondzijaCP[playerid] = 0;
 	KamiondzijaPrikolica[playerid] = 0; trailerlocate[playerid] = false;
 	FarmerCP[playerid] = -1; for(new i=0;i<sizeof(FarmerObjekti);i++) { FarmerPlayer[playerid][i] = INVALID_OBJECT_ID; }
 	FarmerState[playerid] = 0; GradevinarCP[playerid] = 0;
 	gradevinarobject[playerid] = INVALID_OBJECT_ID; gradevinarobjects[playerid][0] = INVALID_OBJECT_ID;
 	gradevinarobjects[playerid][1] = INVALID_OBJECT_ID; gradevinarobjects[playerid][2] = INVALID_OBJECT_ID;
    RudarCP[playerid] = 0; Kopanje[playerid] = 0;
    ZavarivacCP[playerid] = 0; Zavarivac[playerid] = 0;
    PlacanjeInfo[playerid][pBiznisID] = -1; PlacanjeInfo[playerid][pPrice] = 0;
    modelvozila[playerid] = 0; connectedspawn[playerid] = true;
    PozvanUOrg[playerid] = false; IdOrgPozvan[playerid] = -1;
    spawned[playerid] = false; AntiCheat[playerid][aArmourHack] =
	AntiCheat[playerid][aHealthHack] = AntiCheat[playerid][aSpeedHack] =
 	AntiCheat[playerid][aJetPackHack] = AntiCheat[playerid][aTeleportHack] = 0;
 	ACX[playerid] = 0.0; ACY[playerid] = 0.0;
 	ACZ[playerid] = 0.0; ACINT[playerid] = 0;
 	ACVW[playerid] = 0; ACNUMB[playerid] = 0;
 	AFK[playerid] = false; koristidrogu[playerid] = false;
 	Ponudio[playerid] = INVALID_PLAYER_ID; Slot[playerid] = -1;
 	Cijena[playerid] = 0; PonudioB[playerid] = INVALID_PLAYER_ID;
 	CijenaB[playerid] = 0; PonudioK[playerid] = INVALID_PLAYER_ID;
 	CijenaK[playerid] = 0; PonudioZ[playerid] = INVALID_PLAYER_ID;
 	CijenaZ[playerid] = 0; KolZ[playerid] = 0;
 	PonudioD[playerid] = INVALID_PLAYER_ID; CijenaD[playerid] = 0;
 	KolD[playerid] = 0; PonudioM[playerid] = INVALID_PLAYER_ID;
 	CijenaM[playerid] = 0; KolM[playerid] = 0;
 	PolicijaDuty[playerid] = false; Tazed[playerid] = false;
 	Tazer[playerid] = false; polaganje[playerid] = -1;
	PolaganjeVrsta[playerid] = -1; PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
	Razgovara[playerid] = -1; Zove[playerid] = -1;
	DrogaInfo[playerid][dObject] = INVALID_OBJECT_ID;
	DrogaInfo[playerid][dX] = DrogaInfo[playerid][dY] =
	DrogaInfo[playerid][dZ] = DrogaInfo[playerid][dRotX] =
	DrogaInfo[playerid][dRotY] = DrogaInfo[playerid][dRotZ] = 0.0;
	DrogaInfo[playerid][dUsed] = false; DrogaInfo[playerid][dIzrasla] = 0;
	Marama[playerid] = false; RentaVozilo[playerid] = false;
	IdRentVozila[playerid] = -1; RentVrijeme[playerid] = 0;
	EditInfo[playerid][eModel] = EditInfo[playerid][eColor1] =
	EditInfo[playerid][eColor2] = EditInfo[playerid][eRespawn] =
	EditInfo[playerid][eID] = 0; dinamitobject[playerid] = INVALID_OBJECT_ID;
	pljacka[playerid] = -1; Vezan[playerid] = false;
	IgracKojiGaVuce[playerid] = -1; streljanaobject[playerid] = INVALID_OBJECT_ID;
 	for(new w=0;w<13;w++) { oldWeapons[playerid][w] = 0; oldAmmo[playerid][w] = 0; }
 	Trenira[playerid] = -1; TreniraState[playerid] = -1;
 	skill[playerid] = true; InEvent[playerid] = false;
 	EventKaunt[playerid] = 0;
	//--------------------------------------------------------------------------
	new ipp[24];
	GetPlayerIp(playerid,ipp,sizeof(ipp));
	strmid(PlayerInfo[playerid][pLastIp], ipp, 0, strlen(ipp), 24);
	//--------------------------------------------------------------------------
	new banfile[50];
	format(banfile,sizeof(banfile),QPATH,GetName(playerid));
	if(fexist(banfile))
	{
	    Ulogovan[playerid] = false;
	    Kickaj(playerid,"Banovani ste!");
	    return 1;
	}
	//--------------------------------------------------------------------------
	format(banfile,sizeof(banfile),SPECNICKPATH,GetName(playerid));
	if(!fexist(banfile))
	{
		if(!RpName(playerid)) return Kickaj(playerid,"Nepravilno ime! Ime mora biti u formatu Ime_Prezime");
	}
	//--------------------------------------------------------------------------
	CreatePlayerTextDraws(playerid);
	//--------------------------------------------------------------------------
	if(fexist(UserPath(playerid)))
	{
	    if(!ServerInfo[sLogin]) return Kickaj(playerid,"Iskljucena prijava! | Pokusajte kasnije!");
  		INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
    	ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,""plava""IME" - Login:",""bijela"Molimo vas upisite svoju lozinku.","Login","Izlaz");
     	ClearChat(playerid);
     	SetTimerEx("loginicp",1500,false,"d",playerid);
 	}
	else
	{
	    if(!ServerInfo[sRegistracija]) return Kickaj(playerid,"Iskljucena prijava! | Pokusajte kasnije!");
	    ClearChat(playerid);
	    SetupRegistration(playerid);
	}
	//--------------------------------------------------------------------------
	PlacaTimer[playerid] = SetTimerEx("placat",1000,true,"d",playerid);
	//--------------------------------------------------------------------------
	Online++;
	if(Online != playerid+1)
	{
	    new p; p=0;
	    foreach(Player,i) { if(!IsPlayerNPC(i)) { p++; } }
		if(Online != p) { Online=p; }
	}
	if(Online > ServerInfo[sRekord])
	{
	    ServerInfo[sRekord] = Online;
	    foreach(Player,i)
	    {
	        ClearChat(i);
	        PlayerPlaySound(i, 5448, 0.0, 0.0, 0.0);
	    }
	    SCMTA(-1,""plava"["TAG"] "zelena"Zahvaljujuemo se svim igracima upravo smo postigli novi rekord!");
		new str[100];
		format(str,sizeof(str),""plava"["TAG"] "zelena"Novi rekord je %d!",ServerInfo[sRekord]);
		SCMTA(-1,str);
		new str12[20];
		format(str12,sizeof(str12),"Rekord: %d",ServerInfo[sRekord]);
		TextDrawSetString(IgTextDraws[16],str12);
		SacuvajServer();
	}
 	new str1[20];
	format(str1,sizeof(str1),"Online: %d",Online);
	TextDrawSetString(IgTextDraws[15],str1);
	//--------------------------------------------------------------------------
	ShowGangZones(playerid,true);
	//--------------------------------------------------------------------------
	new lgg[200];
	if(PlayerInfo[playerid][pLevel] != 0)
	{
		format(lgg,sizeof(lgg),""zelena"[CONNECT]"zuta" | %s[%d] | Level %d | Sati igranja %d | IP: %s",GetName(playerid),playerid,PlayerInfo[playerid][pLevel],PlayerInfo[playerid][pSatiOnline],ipp);
	}
	else
	{
	    format(lgg,sizeof(lgg),""zelena"[CONNECT]"zuta" | %s[%d] | NOVI IGRAC | IP: %s",GetName(playerid),playerid,ipp);
	}
	SendAdminMessage(lgg);
	SendGameMasterMessage(lgg);
	//--------------------------------------------------------------------------
	return 1;
}
//==============================================================================
public OnPlayerDisconnect(playerid, reason)
{
	//--------------------------------------------------------------------------
	if(ImaLisice[playerid])
	{
	    if(PlayerInfo[playerid][pMoney] >= (GetPlayerWL(playerid)*10000))
	    {
	    	PlayerInfo[playerid][pMoney] -= (GetPlayerWL(playerid)*10000);
	    	GivePlayerMoney(playerid,-(GetPlayerWL(playerid)*10000));
		}
		else if(PlayerInfo[playerid][pBankMoney] >= (GetPlayerWL(playerid)*10000))
		{
		    PlayerInfo[playerid][pBankMoney] -= (GetPlayerWL(playerid)*10000);
		}
	}
	//--------------------------------------------------------------------------
	if(Vezan[playerid])
	{
	    if(PlayerInfo[playerid][pMoney] >= 20000)
	    {
	    	PlayerInfo[playerid][pMoney] -= 20000;
	    	GivePlayerMoney(playerid,-20000);
		}
		else if(PlayerInfo[playerid][pBankMoney] >= 20000)
		{
		    PlayerInfo[playerid][pBankMoney] -= 20000;
		}
	}
	//--------------------------------------------------------------------------
	if(Trenira[playerid] != -1)
	{
 		DestroyPlayerObject(playerid,streljanaobject[playerid]);
 		streljanaobject[playerid] = INVALID_OBJECT_ID;
   		Trenira[playerid] = -1;
   		ResetPlayerWeapons(playerid);
		for(new i=0;i<13;i++)
		{
		    GivePlayerWeapon(playerid,oldWeapons[playerid][i],oldAmmo[playerid][i]);
  			oldWeapons[playerid][i] = 0;
	    	oldAmmo[playerid][i] = 0;
		}
		TreniraState[playerid] = -1;
	}
	//--------------------------------------------------------------------------
 	if(InEvent[playerid])
	{
	    for(new i=0;i<13;i++)
		{
		    GivePlayerWeapon(playerid,oldWeapons[playerid][i],oldAmmo[playerid][i]);
		    oldWeapons[playerid][i] = 0;
		    oldAmmo[playerid][i] = 0;
		}
		DisablePlayerRaceCheckpoint(playerid);
		DisablePlayerCheckpoint(playerid);
		InEvent[playerid] = false;
	}
	//--------------------------------------------------------------------------
	if(Ulogovan[playerid]) { SacuvajIgraca(playerid); }
	//--------------------------------------------------------------------------
	if(avozilo[playerid] != -1) { DestroyVehicle(avozilo[playerid]); avozilo[playerid] = -1; }
    //--------------------------------------------------------------------------
    for(new i=0;i<MAX_PITANJA;i++)
	{
	    if(AskInfo[i][aUse])
	    {
	        if(!strcmp(AskInfo[i][aPostavio],GetName(playerid),false))
	        {
	            AskInfo[i][aUse] = false;
	            strmid(AskInfo[i][aPostavio], "~n~", 0, strlen("~n~"), 24);
             	strmid(AskInfo[i][aPitanje], "~n~", 0, strlen("~n~"), 50);
             	AskInfo[i][aPostavioID] = -1;
	        }
	    }
	}
	//--------------------------------------------------------------------------
	Radi[playerid] = false;
	if(IsValidObject(gradevinarobject[playerid])) { DestroyObject(gradevinarobject[playerid]); }
	if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][0])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][0]); }
    if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][1])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][1]); }
    if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][2])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][2]); }
    //--------------------------------------------------------------------------
    for(new i=0;i<sizeof(FarmerObjekti);i++)
	{
		if(IsValidPlayerObject(playerid, FarmerPlayer[playerid][i])) { DestroyPlayerObject(playerid,FarmerPlayer[playerid][i]); }
		FarmerPlayer[playerid][i] = INVALID_OBJECT_ID;
	}
	//--------------------------------------------------------------------------
	if(KamiondzijaPrikolica[playerid] != 0) { SetVehicleToRespawn(KamiondzijaPrikolica[playerid]); }
	//--------------------------------------------------------------------------
	KillTimer(RudarTimer[playerid]);
	if(IsPlayerAttachedObjectSlotUsed(playerid, RUDAR_SLOT)) { RemovePlayerAttachedObject(playerid, RUDAR_SLOT); }
    //--------------------------------------------------------------------------
    KillTimer(ZavarivacTimer[playerid]);
	if(IsPlayerAttachedObjectSlotUsed(playerid, ZAVARIVAC_SLOT)) { RemovePlayerAttachedObject(playerid, ZAVARIVAC_SLOT); }
	if(IsPlayerAttachedObjectSlotUsed(playerid, ZAVARIVAC1_SLOT)) { RemovePlayerAttachedObject(playerid, ZAVARIVAC1_SLOT); }
    //--------------------------------------------------------------------------
    KillTimer(PlacaTimer[playerid]);
	//--------------------------------------------------------------------------
	for(new i=0;i<sizeof(IgTextDraws);i++) { TextDrawHideForPlayer(playerid,IgTextDraws[i]); }
	//--------------------------------------------------------------------------
	PlayerTextDrawHide(playerid,BankaTD[playerid]);
	PlayerTextDrawHide(playerid,ZlatoTD[playerid]);
	//--------------------------------------------------------------------------
	Online--;
	new p; p=0;
	foreach(Player,i) { if(!IsPlayerNPC(i)) { p++; } }
	if(Online != p) { Online=p; }
	if(Online > ServerInfo[sRekord])
	{
	    ServerInfo[sRekord] = Online;
	    foreach(Player,i)
	    {
	        ClearChat(i);
	        PlayerPlaySound(i, 5448, 0.0, 0.0, 0.0);
	    }
	    SCMTA(-1,""plava"["TAG"] "zelena"Zahvaljujuemo se svim igracima upravo smo postigli novi rekord!");
		new str[100];
		format(str,sizeof(str),""plava"["TAG"] "zelena"Novi rekord je %d!",ServerInfo[sRekord]);
		SCMTA(-1,str);
		new str12[20];
		format(str12,sizeof(str12),"Rekord: %d",ServerInfo[sRekord]);
		TextDrawSetString(IgTextDraws[16],str12);
		SacuvajServer();
	}
 	new str1[20];
	format(str1,sizeof(str1),"Online: %d",Online);
	TextDrawSetString(IgTextDraws[15],str1);
	//--------------------------------------------------------------------------
	if(polaganje[playerid] != -1)
	{
		polaganje[playerid] = -1;
		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
		{
			DestroyVehicle(PolaganjeVehicle[playerid]);
			PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
		}
		PolaganjeVrsta[playerid] = -1;
		DisablePlayerCheckpoint(playerid);
	}
	//--------------------------------------------------------------------------
	if(Zove[playerid] != -1)
	{
		Zove[playerid] = -1;
		if(IsPlayerAttachedObjectSlotUsed(playerid, MOBITEL_SLOT)) { RemovePlayerAttachedObject(playerid, MOBITEL_SLOT); }
		KillTimer(CallTimer[playerid]);
	}
	if(Razgovara[playerid] != -1)
	{
	    SCM(Razgovara[playerid], -1, ""zelena"Igrac s kojim ste pricali je izasao sa servera!");
	    SetPlayerSpecialAction(Razgovara[playerid], SPECIAL_ACTION_STOPUSECELLPHONE);
	    if(IsPlayerAttachedObjectSlotUsed(Razgovara[playerid], MOBITEL_SLOT)) { RemovePlayerAttachedObject(Razgovara[playerid], MOBITEL_SLOT); }
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	    if(IsPlayerAttachedObjectSlotUsed(playerid, MOBITEL_SLOT)) { RemovePlayerAttachedObject(playerid, MOBITEL_SLOT); }
	    Razgovara[Razgovara[playerid]] = -1;
		Razgovara[playerid] = -1;
		KillTimer(MobitelCijenaRazgovora[playerid]);
		KillTimer(MobitelCijenaRazgovora[Razgovara[playerid]]);
	}
	//--------------------------------------------------------------------------
	if(DrogaInfo[playerid][dUsed])
	{
 		DestroyDynamicObject(DrogaInfo[playerid][dObject]);
		DrogaInfo[playerid][dObject] = INVALID_OBJECT_ID;
		DrogaInfo[playerid][dX] = DrogaInfo[playerid][dY] =
		DrogaInfo[playerid][dZ] = DrogaInfo[playerid][dRotX] =
		DrogaInfo[playerid][dRotY] = DrogaInfo[playerid][dRotZ] = 0.0;
		DrogaInfo[playerid][dUsed] = false; DrogaInfo[playerid][dIzrasla] = 0;
		if(DrogaInfo[playerid][dIzrasla] != 5) { KillTimer(DrogaTimer[playerid]); }
		Delete3DTextLabel(DrogaText[playerid]);
	}
	//--------------------------------------------------------------------------
	if(IsPlayerAttachedObjectSlotUsed(playerid, MARAMA_SLOT)) { RemovePlayerAttachedObject(playerid,MARAMA_SLOT); Marama[playerid] = false; }
	//--------------------------------------------------------------------------
	if(RentaVozilo[playerid])
	{
	    SetVehicleToRespawn(IdRentVozila[playerid]);
		VoziloRentano[IdRentVozila[playerid]] = false;
		RentaVozilo[playerid] = false;
		IdRentVozila[playerid] = -1;
		RentVrijeme[playerid] = 0;
		KillTimer(RentTimer[playerid]);
	}
	//--------------------------------------------------------------------------
	ShowGangZones(playerid,false);
	//--------------------------------------------------------------------------
	if(dinamitobject[playerid] != INVALID_OBJECT_ID) { DestroyDynamicObject(dinamitobject[playerid]); dinamitobject[playerid] = INVALID_OBJECT_ID; }
	//--------------------------------------------------------------------------
	if(pljacka[playerid] != -1) { pljacka[playerid] = -1; KillTimer(pljackatimer[playerid]); }
	//--------------------------------------------------------------------------
	return 1;
}
//==============================================================================
public OnPlayerSpawn(playerid)
{
    //--------------------------------------------------------------------------
    SetCameraBehindPlayer(playerid);
    //--------------------------------------------------------------------------
    for(new i=0;i<sizeof(reg);i++) { TextDrawHideForPlayer(playerid,reg[i]); }
	for(new i=0;i<sizeof(regp);i++) { PlayerTextDrawHide(playerid,regp[i][playerid]); }
	//--------------------------------------------------------------------------
    if(PlayerInfo[playerid][pOrgID] != -1)
	{
	    if(PlayerInfo[playerid][pRank] == 1) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin1]); }
		else if(PlayerInfo[playerid][pRank] == 2) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin2]);  }
        else if(PlayerInfo[playerid][pRank] == 3) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin3]);  }
        else if(PlayerInfo[playerid][pRank] == 4) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin4]);  }
        else if(PlayerInfo[playerid][pRank] == 5) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin5]);  }
        else if(PlayerInfo[playerid][pRank] == 6) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin6]);  }
	}
	else
	{
		SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
	}
	//--------------------------------------------------------------------------
	PlayerInfo[playerid][pUbizzu] = -1;
	PlayerInfo[playerid][pUkuci] = -1;
	PlayerInfo[playerid][pUorg] = -1;
	PlayerInfo[playerid][pUstanu] = -1;
	//--------------------------------------------------------------------------
	if(PlayerInfo[playerid][pZatvoren])
	{
		SetPlayerPos(playerid,268.4124,78.2123,1001.0391);
		SetPlayerVirtualWorld(playerid,9);
		SetPlayerInterior(playerid,6);
		PlayerInfo[playerid][pUorg] = POLICIJA;
		Freeze(playerid);
		ZatvorTimer[playerid] = SetTimerEx("zatvor",1000,true,"d",playerid);
	}
	else if(PlayerInfo[playerid][pSpawnType] == 0)
	{
		if(ParanBroj(GetPlayerID(GetName(playerid))))
		{
		    SetPlayerPos(playerid,159.1441,-1504.2161,12.5958);
			SetPlayerFacingAngle(playerid,309.9638);
			SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid,0);
		}
		else
		{
		    SetPlayerPos(playerid,154.8985,-1499.4607,12.5958);
			SetPlayerFacingAngle(playerid,308.7103);
			SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid,0);
		}
	}
	else if(PlayerInfo[playerid][pSpawnType] == 1)
	{
		if(PlayerInfo[playerid][pBizzID] != -1)
		{
		    new id = PlayerInfo[playerid][pBizzID];
			SetPlayerPos(playerid,BiznisInfo[id][bIzlazX], BiznisInfo[id][bIzlazY], BiznisInfo[id][bIzlazZ]);
			SetPlayerVirtualWorld(playerid,BiznisInfo[id][bVW]);
			SetPlayerInterior(playerid,BiznisInfo[id][bInterior]);
			PlayerInfo[playerid][pUbizzu] = id;
			Freeze(playerid);
			if(BiznisInfo[id][bVrsta] == SHOP) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); }
			else if(BiznisInfo[id][bVrsta] == SEX_SHOP) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); }
			else if(BiznisInfo[id][bVrsta] == AMMUNATION) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za treniranje weapon skilla koristite "zuta"'/trenirajskill'"zelena"."); }
			else if(BiznisInfo[id][bVrsta] == KLADIONICA) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kladionica'"zelena"."); }
			else if(BiznisInfo[id][bVrsta] == BINCO) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); }
			else if(BiznisInfo[id][bVrsta] == BAR) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); }
			else if(BiznisInfo[id][bVrsta] == DISCO) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); }
   			else if(BiznisInfo[id][bVrsta] == PIZZA) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); }
      		else if(BiznisInfo[id][bVrsta] == POSTA) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/uplati'"zelena"."); }
		}
		else
		{
		    PlayerInfo[playerid][pSpawnType] = 0;
		    if(ParanBroj(GetPlayerID(GetName(playerid))))
			{
			    SetPlayerPos(playerid,159.1441,-1504.2161,12.5958);
				SetPlayerFacingAngle(playerid,309.9638);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
			else
			{
			    SetPlayerPos(playerid,154.8985,-1499.4607,12.5958);
				SetPlayerFacingAngle(playerid,308.7103);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
		}
	}
	else if(PlayerInfo[playerid][pSpawnType] == 2)
	{
		if(PlayerInfo[playerid][pKucaID] != -1)
		{
		    new id = PlayerInfo[playerid][pKucaID];
			SetPlayerPos(playerid,KucaInfo[id][kIzlazX], KucaInfo[id][kIzlazY], KucaInfo[id][kIzlazZ]);
			SetPlayerVirtualWorld(playerid,KucaInfo[id][kVW]);
			SetPlayerInterior(playerid,KucaInfo[id][kInterior]);
			PlayerInfo[playerid][pUkuci] = id;
			Freeze(playerid);
		}
		else
		{
		    PlayerInfo[playerid][pSpawnType] = 0;
		    if(ParanBroj(GetPlayerID(GetName(playerid))))
			{
			    SetPlayerPos(playerid,159.1441,-1504.2161,12.5958);
				SetPlayerFacingAngle(playerid,309.9638);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
			else
			{
			    SetPlayerPos(playerid,154.8985,-1499.4607,12.5958);
				SetPlayerFacingAngle(playerid,308.7103);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
		}
	}
	else if(PlayerInfo[playerid][pSpawnType] == 3)
	{
		if(PlayerInfo[playerid][pOrgID] != -1)
		{
		    new id = PlayerInfo[playerid][pOrgID];
			SetPlayerPos(playerid,OrgInfo[id][oIzlazX], OrgInfo[id][oIzlazY], OrgInfo[id][oIzlazZ]);
			SetPlayerFacingAngle(playerid,OrgInfo[id][oIzlazAZ]);
			SetPlayerVirtualWorld(playerid,OrgInfo[id][oVW]);
			SetPlayerInterior(playerid,OrgInfo[id][oInt]);
			PlayerInfo[playerid][pUorg] = id;
			Freeze(playerid);
		}
		else
		{
		    PlayerInfo[playerid][pSpawnType] = 0;
		    if(ParanBroj(GetPlayerID(GetName(playerid))))
			{
			    SetPlayerPos(playerid,159.1441,-1504.2161,12.5958);
				SetPlayerFacingAngle(playerid,309.9638);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
			else
			{
			    SetPlayerPos(playerid,154.8985,-1499.4607,12.5958);
				SetPlayerFacingAngle(playerid,308.7103);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
		}
	}
	else if(PlayerInfo[playerid][pSpawnType] == 4)
	{
		if(PlayerInfo[playerid][pStanID] != -1)
		{
		    new id = PlayerInfo[playerid][pStanID];
			SetPlayerPos(playerid,StanInfo[id][sIzlazX], StanInfo[id][sIzlazY], StanInfo[id][sIzlazZ]);
			SetPlayerVirtualWorld(playerid,StanInfo[id][sVW]);
			SetPlayerInterior(playerid,StanInfo[id][sInterior]);
			PlayerInfo[playerid][pUstanu] = id;
			Freeze(playerid);
		}
		else
		{
		    PlayerInfo[playerid][pSpawnType] = 0;
		    if(ParanBroj(GetPlayerID(GetName(playerid))))
			{
			    SetPlayerPos(playerid,159.1441,-1504.2161,12.5958);
				SetPlayerFacingAngle(playerid,309.9638);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
			else
			{
			    SetPlayerPos(playerid,154.8985,-1499.4607,12.5958);
				SetPlayerFacingAngle(playerid,308.7103);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			}
		}
	}
	//--------------------------------------------------------------------------
	ClearChat(playerid,30);
	new str[200];
	SCM(playerid,-1,""plava"----------------------------------------------------");
	format(str,sizeof(str),""plava"%s "bijela"dobrodosli na "plava""IME""bijela"!",GetName(playerid));
	SCM(playerid,-1,str);
	format(str,sizeof(str),""plava"Verzija moda: "bijela""GAME_MODE_TEXT"");
	SCM(playerid,-1,str);
	new mje,god,dan,sat,minu,sec;
	getdate(god,mje,dan);
	gettime(sat,minu,sec);
    format(str,sizeof(str),""bijela"Danas je "plava"%02d/%02d/%d",dan,mje,god);
	SCM(playerid,-1,str);
	format(str,sizeof(str),""bijela"Trenutno je "plava"%02d:%02d:%02d",sat,minu,sec);
	SCM(playerid,-1,str);
	format(str,sizeof(str),""plava"Novac u dzepu: "bijela"%d$",PlayerInfo[playerid][pMoney]);
	SCM(playerid,-1,str);
	format(str,sizeof(str),""plava"Novac u banci: "bijela"%d$",PlayerInfo[playerid][pBankMoney]);
	SCM(playerid,-1,str);
	SCM(playerid,-1,""plava"----------------------------------------------------");
	//--------------------------------------------------------------------------
	UpdateBankaZlatoTD(playerid);
	//--------------------------------------------------------------------------
	for(new i=0;i<sizeof(IgTextDraws);i++) { TextDrawShowForPlayer(playerid,IgTextDraws[i]); }
	//--------------------------------------------------------------------------
	PlayerTextDrawShow(playerid,BankaTD[playerid]);
	PlayerTextDrawShow(playerid,ZlatoTD[playerid]);
	//--------------------------------------------------------------------------
	if(connectedspawn[playerid])
	{
		GivePlayerWeapon(playerid,PlayerInfo[playerid][pWeapon0],PlayerInfo[playerid][pAmmo0]);
		GivePlayerWeapon(playerid,PlayerInfo[playerid][pWeapon1],PlayerInfo[playerid][pAmmo1]);
		GivePlayerWeapon(playerid,PlayerInfo[playerid][pWeapon2],PlayerInfo[playerid][pAmmo2]);
		GivePlayerWeapon(playerid,PlayerInfo[playerid][pWeapon3],PlayerInfo[playerid][pAmmo3]);
		GivePlayerWeapon(playerid,PlayerInfo[playerid][pWeapon4],PlayerInfo[playerid][pAmmo4]);
		GivePlayerWeapon(playerid,PlayerInfo[playerid][pWeapon5],PlayerInfo[playerid][pAmmo5]);
		GivePlayerWeapon(playerid,PlayerInfo[playerid][pWeapon6],PlayerInfo[playerid][pAmmo6]);
		GivePlayerWeapon(playerid,PlayerInfo[playerid][pWeapon7],PlayerInfo[playerid][pAmmo7]);
		GivePlayerWeapon(playerid,PlayerInfo[playerid][pWeapon8],PlayerInfo[playerid][pAmmo8]);
		GivePlayerWeapon(playerid,PlayerInfo[playerid][pWeapon9],PlayerInfo[playerid][pAmmo9]);
		GivePlayerWeapon(playerid,PlayerInfo[playerid][pWeapon10],PlayerInfo[playerid][pAmmo10]);
		GivePlayerWeapon(playerid,PlayerInfo[playerid][pWeapon11],PlayerInfo[playerid][pAmmo11]);
		GivePlayerWeapon(playerid,PlayerInfo[playerid][pWeapon12],PlayerInfo[playerid][pAmmo12]);
		connectedspawn[playerid] = false;
	}
	//--------------------------------------------------------------------------
	spawned[playerid] = true;
	//--------------------------------------------------------------------------
	ACNUMB[playerid] = 0;
 	AFK[playerid] = false;
	//--------------------------------------------------------------------------
	if(PlayerInfo[playerid][pWL] >= 1)
	{
		format(str,sizeof(str),""crvena"Prijavio:"plava" %s "crvena"| Zlocin: "plava"%s "crvena"| WantedLevel: "plava"%d"crvena" |",PlayerInfo[playerid][pPrijavio],PlayerInfo[playerid][pZlocin],PlayerInfo[playerid][pWL]);
		SCM(playerid,-1,str);
	}
	UpdateWlPanel(playerid);
	//--------------------------------------------------------------------------
	for(new i=0;i<11;i++) { SetPlayerSkillLevel(playerid, i, PlayerInfo[playerid][pWeaponSkill][i]); }
	//--------------------------------------------------------------------------
	if(Ulogovan[playerid]) { SacuvajIgraca(playerid); }
    //--------------------------------------------------------------------------
    if(InEvent[playerid])
	{
	    for(new i=0;i<13;i++)
		{
		    GivePlayerWeapon(playerid,oldWeapons[playerid][i],oldAmmo[playerid][i]);
		    oldWeapons[playerid][i] = 0;
		    oldAmmo[playerid][i] = 0;
		}
		DisablePlayerRaceCheckpoint(playerid);
		DisablePlayerCheckpoint(playerid);
		InEvent[playerid] = false;
	}
	//--------------------------------------------------------------------------
	return 1;
}
//==============================================================================
public OnPlayerDeath(playerid, killerid, reason)
{
	//--------------------------------------------------------------------------
    AdminDuty[playerid] = false;
    GameMasterDuty[playerid] = false;
    //--------------------------------------------------------------------------
    PolicajacKojiGaVuce[playerid] = -1;
	ImaLisice[playerid] = false;
	Vezan[playerid] = false;
	IgracKojiGaVuce[playerid] = -1;
	PolicijaDuty[playerid] = false;
	Tazed[playerid] = false;
	Tazer[playerid] = false;
	if(IsPlayerAttachedObjectSlotUsed(playerid, LISICE_SLOT)) { RemovePlayerAttachedObject(playerid, LISICE_SLOT); }
    //--------------------------------------------------------------------------
    if(GPSON[playerid]) { GPSON[playerid] = false; DisablePlayerCheckpoint(playerid); }
    //--------------------------------------------------------------------------
    DisablePlayerCheckpoint(playerid);
    Opremljen[playerid] = false;
    KamiondzijaCP[playerid] = 0;
    if(KamiondzijaPrikolica[playerid] != 0) { SetVehicleToRespawn(KamiondzijaPrikolica[playerid]); }
	KamiondzijaPrikolica[playerid] = 0;
	Radi[playerid] = false;
	//--------------------------------------------------------------------------
	for(new i=0;i<sizeof(FarmerObjekti);i++)
	{
		if(IsValidPlayerObject(playerid, FarmerPlayer[playerid][i])) { DestroyPlayerObject(playerid,FarmerPlayer[playerid][i]); }
		FarmerPlayer[playerid][i] = INVALID_OBJECT_ID;
	}
	FarmerState[playerid] = 0;
	FarmerCP[playerid] = -1;
	//--------------------------------------------------------------------------
	if(IsValidObject(gradevinarobject[playerid])) { DestroyObject(gradevinarobject[playerid]); }
	if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][0])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][0]); }
    if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][1])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][1]); }
    if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][2])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][2]); }
	GradevinarCP[playerid] = 0;
	//--------------------------------------------------------------------------
	RudarCP[playerid] = 0;
	Kopanje[playerid] = 0;
	if(IsPlayerAttachedObjectSlotUsed(playerid, RUDAR_SLOT)) { RemovePlayerAttachedObject(playerid, RUDAR_SLOT); }
    //--------------------------------------------------------------------------
    ZavarivacCP[playerid] = 0;
	Zavarivac[playerid] = 0;
	if(IsPlayerAttachedObjectSlotUsed(playerid, ZAVARIVAC_SLOT)) { RemovePlayerAttachedObject(playerid, ZAVARIVAC_SLOT); }
	if(IsPlayerAttachedObjectSlotUsed(playerid, ZAVARIVAC1_SLOT)) { RemovePlayerAttachedObject(playerid, ZAVARIVAC1_SLOT); }
	//--------------------------------------------------------------------------
 	PlayerInfo[playerid][pUbizzu] = -1;
	PlayerInfo[playerid][pUkuci] = -1;
	PlayerInfo[playerid][pUorg] = -1;
	PlayerInfo[playerid][pUstanu] = -1;
	//--------------------------------------------------------------------------
	for(new i=0;i<sizeof(IgTextDraws);i++) { TextDrawHideForPlayer(playerid,IgTextDraws[i]); }
	//--------------------------------------------------------------------------
	PlayerTextDrawHide(playerid,BankaTD[playerid]);
	PlayerTextDrawHide(playerid,ZlatoTD[playerid]);
	//--------------------------------------------------------------------------
	ShowBrzinomjer(playerid,false);
	//--------------------------------------------------------------------------
	KillTimer(updateg[playerid]);
	//--------------------------------------------------------------------------
	spawned[playerid] = false;
	//--------------------------------------------------------------------------
	koristidrogu[playerid] = false;
	//--------------------------------------------------------------------------
	if(killerid != INVALID_PLAYER_ID)
	{
		if(PlayerInfo[killerid][pOrgID] != POLICIJA && !PlayerInfo[killerid][pZatvoren] && !AdminDuty[killerid] && !InEvent[playerid]) { PostaviZlocin(killerid,"Nepoznato","Ubojstvo",4); if(GameMasterDuty[killerid]) { GameMasterDuty[killerid] = false; } }
		foreach(Player,i)
		{
			if(PlayerInfo[i][pAdmin] >= 1)
			{
			    SendDeathMessageToPlayer(i, killerid, playerid, reason);
			}
		}
	}
	//--------------------------------------------------------------------------
	if(polaganje[playerid] != -1)
	{
		polaganje[playerid] = -1;
		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
		{
			DestroyVehicle(PolaganjeVehicle[playerid]);
			PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
		}
		PolaganjeVrsta[playerid] = -1;
		DisablePlayerCheckpoint(playerid);
	}
	//--------------------------------------------------------------------------
	if(Zove[playerid] != -1)
	{
		Zove[playerid] = -1;
		if(IsPlayerAttachedObjectSlotUsed(playerid, MOBITEL_SLOT)) { RemovePlayerAttachedObject(playerid, MOBITEL_SLOT); }
		KillTimer(CallTimer[playerid]);
	}
	if(Razgovara[playerid] != -1)
	{
	    SCM(Razgovara[playerid], -1, ""zelena"Igrac s kojim ste pricali je umro!");
	    SetPlayerSpecialAction(Razgovara[playerid], SPECIAL_ACTION_STOPUSECELLPHONE);
	    if(IsPlayerAttachedObjectSlotUsed(Razgovara[playerid], MOBITEL_SLOT)) { RemovePlayerAttachedObject(Razgovara[playerid], MOBITEL_SLOT); }
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	    if(IsPlayerAttachedObjectSlotUsed(playerid, MOBITEL_SLOT)) { RemovePlayerAttachedObject(playerid, MOBITEL_SLOT); }
	    Razgovara[Razgovara[playerid]] = -1;
		Razgovara[playerid] = -1;
		KillTimer(MobitelCijenaRazgovora[playerid]);
		KillTimer(MobitelCijenaRazgovora[Razgovara[playerid]]);
	}
	//--------------------------------------------------------------------------
	if(IsPlayerAttachedObjectSlotUsed(playerid, MARAMA_SLOT)) { RemovePlayerAttachedObject(playerid,MARAMA_SLOT); Marama[playerid] = false; }
	//--------------------------------------------------------------------------
	if(dinamitobject[playerid] != INVALID_OBJECT_ID) { DestroyDynamicObject(dinamitobject[playerid]); dinamitobject[playerid] = INVALID_OBJECT_ID; }
	//--------------------------------------------------------------------------
	if(pljacka[playerid] != -1) { pljacka[playerid] = -1; KillTimer(pljackatimer[playerid]); }
	//--------------------------------------------------------------------------
	ResetPlayerWeapons(playerid);
	//--------------------------------------------------------------------------
	if(Trenira[playerid] != -1)
	{
 		DestroyPlayerObject(playerid,streljanaobject[playerid]);
		streljanaobject[playerid] = INVALID_OBJECT_ID;
   		Trenira[playerid] = -1;
   		ResetPlayerWeapons(playerid);
		for(new i=0;i<13;i++)
		{
  			oldWeapons[playerid][i] = 0;
	    	oldAmmo[playerid][i] = 0;
		}
		TreniraState[playerid] = -1;
	}
	//--------------------------------------------------------------------------
	if(GetPlayerWL(playerid) >= 1)
	{
	    if(PlayerInfo[playerid][pMoney] >= (GetPlayerWL(playerid)*10000))
	    {
	    	PlayerInfo[playerid][pMoney] -= (GetPlayerWL(playerid)*10000);
	    	GivePlayerMoney(playerid,-(GetPlayerWL(playerid)*10000));
	    	OcistiDosije(playerid);
	    	new str[100];
			format(str,sizeof(str),""crvena"Umrjeli ste sa wanted levelom i izgubili %d$!",(GetPlayerWL(playerid)*10000));
			INFO(playerid,str);
		}
		else if(PlayerInfo[playerid][pBankMoney] >= (GetPlayerWL(playerid)*10000))
		{
		    PlayerInfo[playerid][pBankMoney] -= (GetPlayerWL(playerid)*10000);
		    OcistiDosije(playerid);
		    new str[100];
			format(str,sizeof(str),""crvena"Umrjeli ste sa wanted levelom i izgubili %d$!",(GetPlayerWL(playerid)*10000));
			INFO(playerid,str);
		}
	}
	//--------------------------------------------------------------------------
	return 1;
}
//==============================================================================
public OnPlayerText(playerid, text[])
{
    if(Ulogovan[playerid] && !PlayerInfo[playerid][pMuted])
	{
	    if(Razgovara[playerid] != -1)
		{
		    new string[128];
			format(string, sizeof(string), ""zelena"| Mobitel | | Ja | "bijela"%s",text);
			SCM(playerid, -1, string);
			new str[400];
			new pnm[MAX_PLAYER_NAME];
			if(Marama[playerid]) { format(pnm,sizeof(pnm),"Stranac"); } else { format(pnm,sizeof(pnm),"%s",GetName(playerid)); }
			format(str,sizeof(str),""siva"%s(%d)(NA MOBITELU): "bijela"%s",pnm,playerid,text);
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			foreach(Player,i)
			{
			    if(Ulogovan[i] && IsPlayerInRangeOfPoint(i,10.0,x,y,z) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && GetPlayerInterior(i) == GetPlayerInterior(playerid)
			    && PlayerInfo[playerid][pUbizzu] == PlayerInfo[i][pUbizzu] && PlayerInfo[playerid][pUkuci] == PlayerInfo[i][pUkuci] && PlayerInfo[playerid][pUorg] == PlayerInfo[i][pUorg] && PlayerInfo[playerid][pUstanu] == PlayerInfo[i][pUstanu] &&  playerid != i)
			    {
			        SCM(i,GetPlayerColor(playerid),str);
			    }
			}
			format(string, sizeof(string), ""zuta"| Mobitel | | %s | "bijela"%s", pnm, text);
			SCM(Razgovara[playerid], -1, string);
			format(str,sizeof(str),""siva"%s(%d)(MOBITEL): "bijela"%s",pnm,playerid,text);
			GetPlayerPos(Razgovara[playerid],x,y,z);
			foreach(Player,i)
			{
			    if(Ulogovan[i] && IsPlayerInRangeOfPoint(i,5.0,x,y,z) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && GetPlayerInterior(i) == GetPlayerInterior(playerid)
			    && PlayerInfo[playerid][pUbizzu] == PlayerInfo[i][pUbizzu] && PlayerInfo[playerid][pUkuci] == PlayerInfo[i][pUkuci] && PlayerInfo[playerid][pUorg] == PlayerInfo[i][pUorg] && PlayerInfo[playerid][pUstanu] == PlayerInfo[i][pUstanu] && i!=Razgovara[playerid])
			    {
			        SCM(i,-1,str);
			    }
			}
			return 0;
		}
		else
		{
			new str[400];
			new pnm[MAX_PLAYER_NAME];
			if(Marama[playerid]) { format(pnm,sizeof(pnm),"Stranac"); } else { format(pnm,sizeof(pnm),"%s",GetName(playerid)); }
			format(str,sizeof(str),"%s(%d): "bijela"%s",pnm,playerid,text);
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			foreach(Player,i)
			{
			    if(Ulogovan[i] && IsPlayerInRangeOfPoint(i,20.0,x,y,z) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && GetPlayerInterior(i) == GetPlayerInterior(playerid)
			    && PlayerInfo[playerid][pUbizzu] == PlayerInfo[i][pUbizzu] && PlayerInfo[playerid][pUkuci] == PlayerInfo[i][pUkuci] && PlayerInfo[playerid][pUorg] == PlayerInfo[i][pUorg] && PlayerInfo[playerid][pUstanu] == PlayerInfo[i][pUstanu])
			    {
			        SCM(i,GetPlayerColor(playerid),str);
			    }
			}
		}
	}
	return 0;
}
//==============================================================================
CMD:spodesavanja(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new str[1000],str1[60];
	new txt[24];
	//--------------------------------------------------------------------------
	format(str,sizeof(str),"Opcija\tStanje\n");
    //--------------------------------------------------------------------------
	if(ServerInfo[sRegistracija]) { txt = ""zelena"ON"; }
	else if(!ServerInfo[sRegistracija]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Registracija\t%s\n",txt);
	strcat(str,str1);
    //--------------------------------------------------------------------------
	if(ServerInfo[sLogin]) { txt = ""zelena"ON"; }
	else if(!ServerInfo[sLogin]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Prijava\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(dupliexp) { txt = ""zelena"ON"; }
	else if(!dupliexp) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Dupli EXP\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(ServerInfo[sBiznisPlace]) { txt = ""zelena"ON"; }
	else if(!ServerInfo[sBiznisPlace]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Place za biznise\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(ServerInfo[sSalon]) { txt = ""zelena"ON"; }
	else if(!ServerInfo[sSalon]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Salon za vozila\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(ServerInfo[sSajam]) { txt = ""zelena"ON"; }
	else if(!ServerInfo[sSajam]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Sajam\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	format(str1,sizeof(str1),""bijela"Rent Cijena 1min\t%d$\n",ServerInfo[sRentCijena]);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(ServerInfo[sZauzimanjeZona]) { txt = ""zelena"ON"; }
	else if(!ServerInfo[sZauzimanjeZona]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Zauzimanje zona\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(ServerInfo[sZonaPlace]) { txt = ""zelena"ON"; }
	else if(!ServerInfo[sZonaPlace]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Place za zone\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	ShowPlayerDialog(playerid,DIALOG_PODESAVANJA,DIALOG_STYLE_TABLIST_HEADERS,""plava""IME" - Podesavanja",str,"Izaberi","Odustani");
	return 1;
}
//==============================================================================
CMD:kreirajbiznis(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] <= 5) return ERROR(playerid,"Niste ovlasteni!");
    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new vrsta;
	if(sscanf(params,"d",vrsta))
	{
		USAGE(playerid,"/kreirajbiznis [Vrsta]");
		INFO(playerid,"Vrste: 0:Shop | 1:Motel | 2: Sex shop | 3:Ammunation");
		INFO(playerid,"Vrste: 4:Kladionica | 5:Binco | 6:Bar");
		INFO(playerid,"Vrste: 7:Zero | 8:Disco | 9:Picerija");
		INFO(playerid,"Vrste: 10:Posta");
		return 1;
	}
	if(vrsta < 0 || vrsta > 10) return ERROR(playerid,"Pogresna vrsta!");
    new id = -1;
	for(new i=0;i<MAX_BIZZ;i++)
	{
	    new str11[20];
	    format(str11,sizeof(str11),BPATH,i);
	    if(!fexist(str11))
	    {
	        id = i;
	        break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Kreirali ste previse biznisa!");
	BiznisInfo[id][bOwned] = false;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	BiznisInfo[id][bUlazX] = x;
	BiznisInfo[id][bUlazY] = y;
	BiznisInfo[id][bUlazZ] = z;
	BiznisInfo[id][bVW] = id;
	new str[MAX_PLAYER_NAME];
    if(vrsta == 0)
	{
    	BiznisInfo[id][bIzlazX] = -26.691598;
		BiznisInfo[id][bIzlazY] = -55.714897;
		BiznisInfo[id][bIzlazZ] = 1003.546875;
		BiznisInfo[id][bInterior] = 6;
		format(str,sizeof(str),"24/7 Shop");
		strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
		BiznisInfo[id][bVrsta] = 0;
		BiznisInfo[id][bLevel] = 10;
		BiznisInfo[id][bPrice] = 1200000;
	}
	else if(vrsta == 1)
	{
    	BiznisInfo[id][bIzlazX] = 2215.454833;
		BiznisInfo[id][bIzlazY] = -1147.475585;
		BiznisInfo[id][bIzlazZ] = 1025.796875;
		BiznisInfo[id][bInterior] = 15;
		format(str,sizeof(str),"Motel");
		strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
		BiznisInfo[id][bVrsta] = 1;
		BiznisInfo[id][bLevel] = 6;
		BiznisInfo[id][bPrice] = 600000;
	}
	else if(vrsta == 2)
	{
    	BiznisInfo[id][bIzlazX] = -100.0767;
		BiznisInfo[id][bIzlazY] = -23.8304;
		BiznisInfo[id][bIzlazZ] = 1000.7188;
		BiznisInfo[id][bInterior] = 3;
		format(str,sizeof(str),"Sex shop");
		strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
		BiznisInfo[id][bVrsta] = 2;
		BiznisInfo[id][bLevel] = 8;
		BiznisInfo[id][bPrice] = 810000;
	}
	else if(vrsta == 3)
	{
	    BiznisInfo[id][bVrsta] = 3;
	    BiznisInfo[id][bIzlazX] = 286.148986;
	    BiznisInfo[id][bIzlazY] = -40.644397;
	    BiznisInfo[id][bIzlazZ] = 1001.515625;
		BiznisInfo[id][bInterior] = 1;
	    format(str, sizeof(str), "Ammunation");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
	    BiznisInfo[id][bLevel] = 12;
		BiznisInfo[id][bPrice] = 2500000;

	}
	else if(vrsta == 4)
	{
        BiznisInfo[id][bVrsta] = 4;
		BiznisInfo[id][bIzlazX] = 834.665588;
		BiznisInfo[id][bIzlazY] = 7.424740;
		BiznisInfo[id][bIzlazZ] = 1004.187011;
		BiznisInfo[id][bInterior] = 3;
	    format(str, sizeof(str), "Kladionica");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
	    BiznisInfo[id][bLevel] = 7;
		BiznisInfo[id][bPrice] = 690000;

	}
	else if(vrsta == 5)
	{
	    BiznisInfo[id][bVrsta] = 5;
	    BiznisInfo[id][bIzlazX] = 207.737991;
	    BiznisInfo[id][bIzlazY] = -109.019996;
	    BiznisInfo[id][bIzlazZ] = 1005.132812;
		BiznisInfo[id][bInterior] = 15;
	    format(str, sizeof(str), "Binco");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
	    BiznisInfo[id][bLevel] = 5;
		BiznisInfo[id][bPrice] = 560000;

	}
    else if(vrsta == 6)
	{
	    BiznisInfo[id][bVrsta] = 6;
	    BiznisInfo[id][bIzlazX] = 501.980987;
	    BiznisInfo[id][bIzlazY] = -69.150199;
	    BiznisInfo[id][bIzlazZ] = 998.757812;
		BiznisInfo[id][bInterior] = 11;
	    format(str, sizeof(str), "Bar");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
	    BiznisInfo[id][bLevel] = 9;
		BiznisInfo[id][bPrice] = 930000;
	}
 	else if(vrsta == 7)
	{
	    BiznisInfo[id][bVrsta] = 7;
	    BiznisInfo[id][bIzlazX] = -2240.468505;
	    BiznisInfo[id][bIzlazY] = 137.060440;
	    BiznisInfo[id][bIzlazZ] = 1035.414062;
		BiznisInfo[id][bInterior] = 6;
	    format(str, sizeof(str), "Zero shop");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
	    BiznisInfo[id][bLevel] = 7;
		BiznisInfo[id][bPrice] = 735000;
	}
	else if(vrsta == 8)
	{
	    BiznisInfo[id][bVrsta] = 8;
	    BiznisInfo[id][bIzlazX] = 493.390991;
	    BiznisInfo[id][bIzlazY] = -22.722799;
	    BiznisInfo[id][bIzlazZ] = 1000.679687;
		BiznisInfo[id][bInterior] = 17;
	    format(str, sizeof(str), "Disco");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
	    BiznisInfo[id][bLevel] = 9;
		BiznisInfo[id][bPrice] = 990000;
	}
	else if(vrsta == 9)
	{
	    BiznisInfo[id][bVrsta] = 9;
	    BiznisInfo[id][bIzlazX] = 372.3433;
	    BiznisInfo[id][bIzlazY] = -133.1018;
	    BiznisInfo[id][bIzlazZ] = 1001.4922;
		BiznisInfo[id][bInterior] = 5;
	    format(str, sizeof(str), "Picerija");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
	    BiznisInfo[id][bLevel] = 8;
		BiznisInfo[id][bPrice] = 810000;
	}
	else if(vrsta == 10)
	{
	    BiznisInfo[id][bVrsta] = 10; 
	    BiznisInfo[id][bIzlazX] = 971.4832; 
	    BiznisInfo[id][bIzlazY] = -1347.4653;
	    BiznisInfo[id][bIzlazZ] = -42.1611;
		BiznisInfo[id][bInterior] = 0;
	    format(str, sizeof(str), "Posta");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
	    BiznisInfo[id][bLevel] = 6;
		BiznisInfo[id][bPrice] = 700000;
	}
	new str3[200];
    format(str3,sizeof(str3),""plava"Biznis na prodaju!\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\nVrsta: %s\n"plava"Da kupite biznis upisite "bijela"'/kupibiznis'",BiznisInfo[id][bName],BiznisInfo[id][bLevel],BiznisInfo[id][bPrice],VrstaBiznisa(id));
	bText[id] = Create3DTextLabel(str3, -1, BiznisInfo[id][bUlazX], BiznisInfo[id][bUlazY], BiznisInfo[id][bUlazZ], 20.0, 0, 0);
	BiznisInfo[id][bUnutraPic] = CreateDynamicPickup(1239, 1, BiznisInfo[id][bIzlazX], BiznisInfo[id][bIzlazY], BiznisInfo[id][bIzlazZ], BiznisInfo[id][bVW]);
	BiznisInfo[id][bIzvanPic] = CreateDynamicPickup(1272, 1, BiznisInfo[id][bUlazX], BiznisInfo[id][bUlazY], BiznisInfo[id][bUlazZ], -1);
	SacuvajBiznis(id);
	return 1;
}
//==============================================================================
CMD:izbrisibiznis(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new id;
	if(sscanf(params,"d",id)) return USAGE(playerid,"/izbrisibiznis [Id]");
    new str2[20];
    format(str2,sizeof(str2),BPATH,id);
	if(!fexist(str2))
	{
	    ERROR(playerid,"Taj biznis ne postoji!");
	}
	else
	{
	 	BiznisInfo[id][bOwned] = false;
	 	BiznisInfo[id][bUlazX] = 0.0;
		BiznisInfo[id][bUlazY] = 0.0;
		BiznisInfo[id][bUlazZ] = 0.0;
		BiznisInfo[id][bVW] = 0;
		BiznisInfo[id][bIzlazX] = 0.0;
		BiznisInfo[id][bIzlazY] = 0.0;
		BiznisInfo[id][bIzlazZ] = 0.0;
		BiznisInfo[id][bInterior] = 0;
		strmid(BiznisInfo[id][bName], "~n~", 0, strlen("~n~"), MAX_PLAYER_NAME);
		BiznisInfo[id][bVrsta] = 0;
		BiznisInfo[id][bLevel] = 0;
		BiznisInfo[id][bPrice] = 0;
		BiznisInfo[id][bMoney] = 0;
		DestroyDynamicPickup(BiznisInfo[id][bUnutraPic]);
		DestroyDynamicPickup(BiznisInfo[id][bIzvanPic]);
		Delete3DTextLabel(bText[id]);
	 	fremove(str2);
	 	INFO(playerid,"Uspjesno ste obrisali biznis!");
	}
	return 1;
}
//==============================================================================
CMD:getbiznisid(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(GetBiznis(playerid) == -1) return ERROR(playerid,"Niste kod ulaza u niti jedan biznis!");
	new str[50];
	format(str,sizeof(str),""zuta"Vi ste kod biznisa %d",GetBiznis(playerid));
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:portdobiznisa(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 1) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new id;
	if(sscanf(params,"d",id)) return USAGE(playerid,"/portdobiznisa [Id]");
 	new str[50];
    format(str,sizeof(str),BPATH,id);
	if(!fexist(str)) return ERROR(playerid,"Taj biznis ne postoji!");
	PlayerInfo[playerid][pUbizzu] = -1;
	PlayerInfo[playerid][pUkuci] = -1;
	PlayerInfo[playerid][pUorg] = -1;
	PlayerInfo[playerid][pUstanu] = -1;
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid,BiznisInfo[id][bUlazX], BiznisInfo[id][bUlazY], BiznisInfo[id][bUlazZ]);
	Freeze(playerid);
	format(str,sizeof(str),""zuta"Portali ste se do biznisa! ID:%d",id);
	INFO(playerid,str);
	return 1;
}
//==============================================================================
CMD:kreirajbiznisex(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] <= 5) return ERROR(playerid,"Niste ovlasteni!");
	new level,price,vrsta;
	if(sscanf(params,"ddd",level,price,vrsta))
	{
		USAGE(playerid,"/kreirajbiznis [level][cijena][vrsta]");
		INFO(playerid,"Vrste: 0:Shop | 1:Motel | 2: Sex shop | 3:Ammunation");
		INFO(playerid,"Vrste: 4:Kladionica | 5:Binco | 6:Bar");
		INFO(playerid,"Vrste: 7:Zero | 8:Disco | 9:Picerija");
		INFO(playerid,"Vrste: 10:Posta");
		return 1;
	}
	if(price < 1 || level < 1) return ERROR(playerid,"Cijena ili level nesmiju biti manji od 1!");
	if(vrsta < 0 || vrsta > 10) return ERROR(playerid,"Pogresna vrsta!");
    new id=-1;
	for(new i=0;i<MAX_BIZZ;i++)
	{
	    new str11[20];
	    format(str11,sizeof(str11),BPATH,i);
	    if(!fexist(str11))
	    {
	        id = i;
	        break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Kreirali ste previse biznisa!");
	BiznisInfo[id][bOwned] = false;
	BiznisInfo[id][bLevel] = level;
	BiznisInfo[id][bPrice] = price;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	BiznisInfo[id][bUlazX] = x;
	BiznisInfo[id][bUlazY] = y;
	BiznisInfo[id][bUlazZ] = z;
	BiznisInfo[id][bVW] = id;
	new str[MAX_PLAYER_NAME];
    if(vrsta == 0)
	{
    	BiznisInfo[id][bIzlazX] = -26.691598;
		BiznisInfo[id][bIzlazY] = -55.714897;
		BiznisInfo[id][bIzlazZ] = 1003.546875;
		BiznisInfo[id][bInterior] = 6;
		format(str,sizeof(str),"24/7 Shop");
		strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
		BiznisInfo[id][bVrsta] = 0;
	}
	else if(vrsta == 1)
	{
    	BiznisInfo[id][bIzlazX] = 2215.454833;
		BiznisInfo[id][bIzlazY] = -1147.475585;
		BiznisInfo[id][bIzlazZ] = 1025.796875;
		BiznisInfo[id][bInterior] = 15;
		format(str,sizeof(str),"Motel");
		strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
		BiznisInfo[id][bVrsta] = 1;
	}
	else if(vrsta == 2)
	{
    	BiznisInfo[id][bIzlazX] = -100.0767;
		BiznisInfo[id][bIzlazY] = -23.8304;
		BiznisInfo[id][bIzlazZ] = 1000.7188;
		BiznisInfo[id][bInterior] = 3;
		format(str,sizeof(str),"Sex shop");
		strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
		BiznisInfo[id][bVrsta] = 1;
	}
	else if(vrsta == 3)
	{
	    BiznisInfo[id][bVrsta] = 3;
	    BiznisInfo[id][bIzlazX] = 286.148986;
	    BiznisInfo[id][bIzlazY] = -40.644397;
	    BiznisInfo[id][bIzlazZ] = 1001.515625;
		BiznisInfo[id][bInterior] = 1;
	    format(str, sizeof(str), "Ammunation");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);

	}
	else if(vrsta == 4)
	{
        BiznisInfo[id][bVrsta] = 4;
		BiznisInfo[id][bIzlazX] = 834.665588;
		BiznisInfo[id][bIzlazY] = 7.424740;
		BiznisInfo[id][bIzlazZ] = 1004.187011;
		BiznisInfo[id][bInterior] = 3;
	    format(str, sizeof(str), "Kladionica");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);

	}
	else if(vrsta == 5)
	{
	    BiznisInfo[id][bVrsta] = 5;
	    BiznisInfo[id][bIzlazX] = 207.737991;
	    BiznisInfo[id][bIzlazY] = -109.019996;
	    BiznisInfo[id][bIzlazZ] = 1005.132812;
		BiznisInfo[id][bInterior] = 15;
	    format(str, sizeof(str), "Binco");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);

	}
    else if(vrsta == 6)
	{
	    BiznisInfo[id][bVrsta] = 6;
	    BiznisInfo[id][bIzlazX] = 501.980987;
	    BiznisInfo[id][bIzlazY] = -69.150199;
	    BiznisInfo[id][bIzlazZ] = 998.757812;
		BiznisInfo[id][bInterior] = 11;
	    format(str, sizeof(str), "Bar");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
	}
 	else if(vrsta == 7)
	{
	    BiznisInfo[id][bVrsta] = 7;
	    BiznisInfo[id][bIzlazX] = -2240.468505;
	    BiznisInfo[id][bIzlazY] = 137.060440;
	    BiznisInfo[id][bIzlazZ] = 1035.414062;
		BiznisInfo[id][bInterior] = 6;
	    format(str, sizeof(str), "Zero shop");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
	}
	else if(vrsta == 8)
	{
	    BiznisInfo[id][bVrsta] = 14;
	    BiznisInfo[id][bIzlazX] = 493.390991;
	    BiznisInfo[id][bIzlazY] = -22.722799;
	    BiznisInfo[id][bIzlazZ] = 1000.679687;
		BiznisInfo[id][bInterior] = 17;
	    format(str, sizeof(str), "Disco");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
	}
	else if(vrsta == 9)
	{
	    BiznisInfo[id][bVrsta] = 16;
	    BiznisInfo[id][bIzlazX] = 372.3433;
	    BiznisInfo[id][bIzlazY] = -133.1018;
	    BiznisInfo[id][bIzlazZ] = 1001.4922;
		BiznisInfo[id][bInterior] = 5;
	    format(str, sizeof(str), "Picerija");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
	}
	else if(vrsta == 10)
	{
	    BiznisInfo[id][bVrsta] = 17;
	    BiznisInfo[id][bIzlazX] = 2315.952880;
	    BiznisInfo[id][bIzlazY] = -1.618174;
	    BiznisInfo[id][bIzlazZ] = 26.742187;
		BiznisInfo[id][bInterior] = 0;
	    format(str, sizeof(str), "Posta");
	    strmid(BiznisInfo[id][bName], str, 0, strlen(str), MAX_PLAYER_NAME);
	}
	new str3[200];
    format(str3,sizeof(str3),""plava"Biznis na prodaju!\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\nVrsta: %s\n"plava"Da kupite biznis upisite "bijela"'/kupibiznis'",BiznisInfo[id][bName],BiznisInfo[id][bLevel],BiznisInfo[id][bPrice],VrstaBiznisa(id));
	bText[id] = Create3DTextLabel(str3, -1, BiznisInfo[id][bUlazX], BiznisInfo[id][bUlazY], BiznisInfo[id][bUlazZ], 20.0, 0, 0);
	BiznisInfo[id][bUnutraPic] = CreateDynamicPickup(1239, 1, BiznisInfo[id][bIzlazX], BiznisInfo[id][bIzlazY], BiznisInfo[id][bIzlazZ], BiznisInfo[id][bVW]);
	BiznisInfo[id][bIzvanPic] = CreateDynamicPickup(1272, 1, BiznisInfo[id][bUlazX], BiznisInfo[id][bUlazY], BiznisInfo[id][bUlazZ], -1);
	SacuvajBiznis(id);
	return 1;
}
//==============================================================================
CMD:kupibiznis(playerid,params[])
{
    #pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pBizzID] != -1) return ERROR(playerid,"Vec si vlasnik nekog biznisa!");
	new id = GetBiznis(playerid);
	if(id == -1) return ERROR(playerid,"Nisi u blizni biznisa!");
	if(BiznisInfo[id][bOwned]) return ERROR(playerid,"Ovaj biznis nije na prodaju!");
	if(GetPlayerMoney(playerid) < BiznisInfo[id][bPrice]) return ERROR(playerid,"Nemate dovoljno novca!");
	if(PlayerInfo[playerid][pLevel] < BiznisInfo[id][bLevel]) return ERROR(playerid,"Nemaze dovoljan level!");
	BiznisInfo[id][bOwned] = true;
	BiznisInfo[id][bOwnerName] = RemoveUnderLine(GetName(playerid));
	BiznisLP(id);
	BiznisInfo[id][bLocked] = false;
	PlayerInfo[playerid][pMoney] -= BiznisInfo[id][bPrice];
	GivePlayerMoney(playerid,-BiznisInfo[id][bPrice]);
	PlayerInfo[playerid][pBizzID] = id;
	SacuvajBiznis(id);
	SacuvajIgraca(playerid);
	ClearChat(playerid);
	INFO(playerid,"Uspjesno ste kupili biznis!");
	INFO(playerid,"Za upravljanje biznisa koristite "zuta"'/biznis'");
	return 1;
}
//==============================================================================
CMD:biznis(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pBizzID] == -1) return ERROR(playerid,"Nemate biznis!");
	if(PlayerInfo[playerid][pBizzID] != GetBiznis(playerid)) return ERROR(playerid,"Nisi kod svog biznisa!");
	ShowPlayerDialog(playerid,DIALOG_BIZNIS,DIALOG_STYLE_LIST,""plava""IME" - Biznis:",""zelena"Otkljucaj"bijela"/"crvena"Zakljucaj\n"bijela"Prodaj drzavi\n"plava"Informacije\n"bijela"Promijeni ime\n"plava"Ostavi/uzmi","Izaberi","Odustani");
    Aktivnost(playerid,"upravlja biznisom.");
	return 1;
}
//==============================================================================
CMD:help(playerid,params[])
{
	#pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(!spawned[playerid]) return ERROR(playerid,"Niste spawnovani!");
	new str[500];
	format(str,sizeof(str),""bijela"Komande za biznis\n"plava"Komande za banku\n"bijela"Komande za posao\n"plava"Komande za kucu\n"bijela"Komande za vozila\n"plava"Komande za admine\n"bijela"Komande za GameMastere\n"plava"Osnovne komande\n"bijela"Komande za organizaciju\n"plava"Komande za dozvole\n"bijela"Komande za mobitel\n"plava"Komande za crno trziste\n"bijela"Komande za vipove\n"plava"Komande za stan");
	ShowPlayerDialog(playerid,DIALOG_HELP,DIALOG_STYLE_LIST,""plava""IME" - Help",str,"Dalje","Odustani");
	return 1;
}
//==============================================================================
CMD:ah(playerid,params[]) return cmd_help(playerid,params);
//==============================================================================
CMD:aduty(playerid, params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(!spawned[playerid]) return ERROR(playerid,"Niste spawnovani!");
	if(PlayerInfo[playerid][pAdmin] <= 0) return ERROR(playerid,"Niste ovlasteni!");
	if(PlayerInfo[playerid][pZatvoren]) return ERROR(playerid,"U zatvoru ste!"); 
	if(Radi[playerid]) return ERROR(playerid,"Radite!");
	if(GetPlayerWL(playerid) >= 1) return ERROR(playerid,"Imate wanted levele!");
    if(PolicijaDuty[playerid]) return ERROR(playerid,"Na policijskoj duznosti ste!");
    if(polaganje[playerid] != -1) return ERROR(playerid,"Polazete!");
    if(Trenira[playerid] != -1) return ERROR(playerid,"Trenirate skill!");
	new string[256];
	if(!AdminDuty[playerid])
	{
		format(string,sizeof(string),""zuta"(( "bijela"Administrator %s je na duznosti "zuta"))",GetName(playerid));
		SendAdminMessage(string);
		SendGameMasterMessage(string);
		AdminDuty[playerid] = true;
		SetPlayerArmour(playerid, 99.0);
		SetPlayerHealth(playerid, 99.0);
	}
	else if(AdminDuty[playerid])
	{
		SetPlayerArmour(playerid, 0);
		SetPlayerHealth(playerid, 99.0);
		format(string,sizeof(string),""zuta"(( "bijela"Administrator %s vise nije na duznosti "zuta"))",GetName(playerid));
		SendAdminMessage(string);
		SendGameMasterMessage(string);
		AdminDuty[playerid] = false;
		if(avozilo[playerid] != -1) { DestroyVehicle(avozilo[playerid]); avozilo[playerid] = -1; }
	}
	return 1;
}
//==============================================================================
CMD:specon(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new id;
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 3)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "u", id)) return USAGE(playerid,"/specon [Id]");
		if(!IsPlayerConnected(id)) return ERROR(playerid,"Igrac nije u igri!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) && !PlayerInfo[id][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[id][pGameMaster]) && !PlayerInfo[id][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		TogglePlayerSpectating(playerid, 1); PlayerSpectatePlayer(playerid, id);
		SetPlayerInterior(playerid, GetPlayerInterior(id));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(id));
		specID[playerid] = id; specType[playerid] = 1;
		//SetTimerEx("spectimer",1000,true,"d",playerid);
	}
	else return ERROR(playerid,"Niste ovlasteni!");
	return 1;
}
//==============================================================================
CMD:specoff(playerid, params[])
{
	#pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 3)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		TogglePlayerSpectating(playerid, 0); SetPlayerHealth(playerid, 99.0);
		specID[playerid] = INVALID_PLAYER_ID;
		specType[playerid] = 0;
	}
	else return ERROR(playerid,"Niste ovlasteni!");
	return 1;
}
//==============================================================================
CMD:count(playerid, params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
		new vr;
		if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params,"d",vr)) return USAGE(playerid,"/count [1 - 10 sekundi]");
		if(countaktiviran) return ERROR(playerid,"Brojanje je vec zapoceto");
		if(vr > 10 || vr <= 0) return ERROR(playerid,"MAX 10 | MINIMUM 1!");
		CountTimer = SetTimer("Count",1000,true);
		countvrijeme = vr; countaktiviran = true;
		INFO(playerid,"Brojanje zapoceto!");
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:apopravi(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
  		if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u vozilu");
		RepairVehicle(GetPlayerVehicleID(playerid));
		INFO(playerid,"Vozilo popravljeno");
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:vipfix(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pVip] >= 1 || PlayerInfo[playerid][pAdmin] >= 4)
	{
		if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u vozilu");
		RepairVehicle(GetPlayerVehicleID(playerid));
		INFO(playerid,"Vozilo popravljeno");
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:cc(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1  || PlayerInfo[playerid][pGameMaster] >= 1)
	{
    	if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
  		foreach(Player,i) { ClearChat(i); }
        new str[100];
        if(PlayerInfo[playerid][pAdmin] >= 1) { format(str,sizeof(str),""zuta"Admin %s je ocistio chat!",GetName(playerid)); }
        else { format(str,sizeof(str),""zelena"GameMaster %s je ocistio chat!",GetName(playerid)); }
		SCMTA(-1,str);
	}
	else return ERROR(playerid,"Niste ovlasteni");
	return 1;
}
//==============================================================================
CMD:kick(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
		new string[150],targetid, razlog[48];
		if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "us[48]", targetid, razlog)) return USAGE(playerid,"/kick [Id/ime][Razlog]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(PlayerInfo[targetid][pAdmin] > PlayerInfo[playerid][pAdmin]) return ERROR(playerid,"Ne mozete kikovati tog igraca!");
		if(!strcmp("Vuk_Emerik",GetName(targetid),true)) return ERROR(playerid,"Ne mozete kickovati tog igraca!");
        if(PlayerInfo[playerid][pAdmin] >= 1)
		{ format(string,sizeof(string),""crvena"[KICK] Admin %s je kikovao igraca %s (Razlog: %s).",GetName(playerid),GetName(targetid),razlog); }
		else { format(string,sizeof(string),""crvena"[KICK] GameMaster %s je kikovao igraca %s (Razlog: %s).",GetName(playerid),GetName(targetid),razlog); }
		SCMTA(-1,string);
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{ format(string,sizeof(string),""zuta"Kikovani ste od strane admina "bijela"%s | "zuta"Razlog: "bijela"%s",GetName(playerid),razlog); }
		else { format(string,sizeof(string),""zuta"Kikovani ste od strane gamemastera "bijela"%s | "zuta"Razlog: "bijela"%s",GetName(playerid),razlog); }
		SCM(targetid,-1,string);
		new string1[256];
		format(string1,sizeof(string1),""crvena"Kikovali ste igraca "bijela"%s | "crvena"Razlog: "bijela"%s",GetName(targetid),razlog);
		SCM(playerid,-1,string1);
		Kickaj(targetid," ");
		new lgg[200];
		format(lgg,sizeof(lgg),"[KICK] | Admin %s | Igraca %s | Razlog %s |",GetName(playerid),GetName(targetid),razlog);
		Log(ADMIN_LOG,lgg);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:goto(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new str[128], targetid;
	new Float:x,Float:y,Float:z;
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "u", targetid)) return USAGE(playerid,"/goto [Id/ime]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pGotoSlabijih]) return ERROR(playerid,"Igrac je iskljucio teleport slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pGotoSlabijih]) return ERROR(playerid,"Igrac je iskljucio teleport slabijih!");
		GetPlayerPos(targetid, x, y, z);
		if(GetPlayerState(playerid) == 2)
		{
			new vid = GetPlayerVehicleID(playerid);
			SetVehiclePos(vid, x, y+4, z);
		}
		else
		{
			SetPlayerPos(playerid,x,y+2, z);
		}
		Freeze(playerid);
		SetPlayerInterior(playerid, GetPlayerInterior(targetid));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
		PlayerInfo[playerid][pUbizzu] = PlayerInfo[targetid][pUbizzu];
		PlayerInfo[playerid][pUkuci] = PlayerInfo[targetid][pUkuci];
		PlayerInfo[playerid][pUorg] = PlayerInfo[targetid][pUorg];
		PlayerInfo[playerid][pUstanu] = PlayerInfo[targetid][pUstanu];
		format(str, sizeof(str),""zuta"Teleportovao si se do igraca %s.",GetName(targetid));
		SCM(playerid, -1, str);
		if(PlayerInfo[playerid][pAdmin] >= 1) { format(str, sizeof(str),""zuta"Admin %s se teleportovao do tebe.",GetName(playerid)); }
		else { format(str, sizeof(str),""zelena"GameMaster %s se teleportovao do tebe.",GetName(playerid)); }
		SCM(targetid, -1, str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:slap(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
		new targetid,razlog[48];
		new Float:health,string[130];
		new Float:x,Float:y,Float:z;
		if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "us[48]", targetid,razlog)) return USAGE(playerid,"/slap [Id/ime][razlog]");
	    if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	    if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if(PlayerInfo[targetid][pZatvoren]) return SCM(playerid, -1, ""crvena"Igrac je u zatvoru");
        if(ImaLisice[targetid]) return ERROR(playerid,"Igrac ima lisice");
        if(Vezan[targetid]) return ERROR(playerid,"Igrac je vezan");
        if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		GetPlayerPos(targetid, x, y, z);
		if(PlayerInfo[playerid][pAdmin] >= 1) { format(string,sizeof(string),""zuta"Admin %s vas je osamario | Razlog: "bijela"%s!",GetName(playerid),razlog); }
		else { format(string,sizeof(string),""zelena"GameMaster %s vas je osamario | Razlog: "bijela"%s!",GetName(playerid),razlog); }
		SCM(targetid,-1,string);
		format(string,sizeof(string),""zuta"Osamarili ste "bijela"%s-a | "zuta"Razlog: "bijela"%s!",GetName(targetid),razlog);
		SCM(playerid,-1,string);
		SetPlayerPos(targetid, x, y, z+4.0);
		GetPlayerHealth(targetid,health);
		SetPlayerHealth(targetid,health-5);
		new lgg[200];
		format(lgg,sizeof(lgg),"[SLAP] | Admin %s | Igraca %s | Razlog %s |",GetName(playerid),GetName(targetid),razlog);
		Log(ADMIN_LOG,lgg);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:freeze(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new string[128], str2[128], id;
    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 2)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "u", id)) return USAGE(playerid,"/freeze [Id/ime]");
        if(!IsPlayerConnected(id)) return ERROR(playerid,"Igrac nije u igri!");
        if(!spawned[id]) return ERROR(playerid,"Igrac nije spawnovan!");
        if((PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) && !PlayerInfo[id][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[id][pGameMaster]) && !PlayerInfo[id][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		format(string, sizeof(string), ""zuta"Frezovali ste igraca %s-a!",GetName(id));
		SCM(playerid, -1, string);
		if(PlayerInfo[playerid][pAdmin] >= 1) { format(str2, sizeof(str2), ""zuta"Admin %s vas je freezovao!",GetName(playerid)); }
		else { format(str2, sizeof(str2), ""zelena"GameMaster %s vas je freezovao!",GetName(playerid)); }
		SCM(id, -1, str2);
		TogglePlayerControllable(id, false);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:unfreeze(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new string[128], str2[128], igrac;
    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "u", igrac)) return USAGE(playerid,"/unfreeze [Id/ime]");
        if(!IsPlayerConnected(igrac)) return ERROR(playerid,"Igrac nije u igri!");
        if(!spawned[igrac]) return ERROR(playerid,"Igrac nije spawnovan!");
		format(string, sizeof(string), ""zuta"Unfrezovali ste igraca %s-a!",GetName(igrac));
		SCM(playerid, -1, string);
		if(PlayerInfo[playerid][pAdmin] >= 1) { format(str2, sizeof(str2), ""zuta"Admin %s vas je unfreezovao!",GetName(playerid)); }
		else { format(str2, sizeof(str2), ""zelena"GameMaster %s vas je unfreezovao!",GetName(playerid)); }
		SCM(igrac, -1, str2);
		TogglePlayerControllable(igrac, true);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:rtc(playerid, params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Morate bitii u vozilu!");
		SetVehicleToRespawn(GetPlayerVehicleID(playerid));
		INFO(playerid,"Respawnovali ste vozilo!");
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:mlista(playerid, params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		new id = 0, string[100],str[250];
		foreach(Player,i)
		{
		    if(IsPlayerConnected(i))
		    {
				if(PlayerInfo[i][pMuted])
				{
					format(string,sizeof(string), "\n"plava"| Ime: "bijela"%s "plava"| ID: "bijela"%d "plava"|", GetName(i), i);
					format(str,sizeof(str),"%s%s",str,string);
					id++;
				}
			}
		}
		if(id == 0) return ERROR(playerid,"Nema mutiranih igraca!");
		ShowPlayerDialog(playerid,DIALOG_MUTE_LISTA,DIALOG_STYLE_MSGBOX,""zuta"Mutirani igraci:",str,""bijela"Ok","");
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:ajail(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
		new targetid, vrijemee, razlog[64];
		if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "uds[64]", targetid, vrijemee, razlog)) return USAGE(playerid,"/ajail [Id/Ime][Vrijeme/Min][Razlog]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igru!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if(PlayerInfo[targetid][pAdmin] > PlayerInfo[playerid][pAdmin]) return ERROR(playerid,"Ne mozete jailat tog igraca!");
		if(PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) return ERROR(playerid,"Ne mozete tog igraca!");
		if(!strcmp("Vuk_Emerik",GetName(targetid),true)) return ERROR(playerid,"Ne mozete jailat tog igraca!");
		SetPlayerSpecialAction(targetid,SPECIAL_ACTION_NONE);
	 	new time = vrijemee*60;
		PlayerInfo[targetid][pZatvoren] = true;
		PlayerInfo[targetid][pVrijeme] = time;
		if(IsPlayerAttachedObjectSlotUsed(playerid, LISICE_SLOT)) { RemovePlayerAttachedObject(playerid, LISICE_SLOT); }
        AdminDuty[targetid] = false;
        GameMasterDuty[targetid] = false;
        PolicijaDuty[targetid] = false;
        InEvent[targetid] = false;
        SetPlayerPos(targetid,268.4124,78.2123,1001.0391);
		SetPlayerVirtualWorld(targetid,9);
		SetPlayerInterior(targetid,6);
		PlayerInfo[targetid][pUorg] = POLICIJA;
		Freeze(targetid);
		GameTextForPlayer(targetid,"~r~JAILED",5000,3);
		ZatvorTimer[targetid] = SetTimerEx("zatvor",1000,true,"d",targetid);
		ResetPlayerWeapons(targetid);
		SacuvajIgraca(targetid);
		new str[256];
		format(str, sizeof(str), ""zuta"Zatvorili ste igraca %s u zatvor na %d minuta!.", GetName(targetid),vrijemee);
		SCM(playerid, -1, str);
		if(PlayerInfo[playerid][pAdmin] >= 1) { format(str, sizeof(str), ""crvena"[JAIL] Admin %s vas je zatvorio na %d minuta.", GetName(playerid), vrijemee); }
		else { format(str, sizeof(str), ""crvena"[JAIL] "zelena" GameMaster %s vas je zatvorio na %d minuta.", GetName(playerid), vrijemee); }
		SCM(targetid, -1, str);
		format(str, sizeof(str), ""crvena"[JAIL]: "bijela"Razlog: %s.", razlog);
		SCM(targetid, -1, str);
		format(str, sizeof(str), ""crvena"[JAIL] "zuta"| Admin %s | Igraca %s | Vrijeme %d | Razlog %s |", GetName(playerid),GetName(targetid),vrijemee,razlog);
		SendAdminMessage(str);
		OcistiDosije(targetid);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:akill(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new targetid,str[128];
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "u", targetid)) return USAGE(playerid,"/kill [Id/Ime]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		SetPlayerHealth(targetid,0);
		format(str,sizeof(str),""crvena"[KILL] Admin %s vas je ubio!",GetName(playerid));
		SCM(targetid,-1,str);
		format(str,sizeof(str),""zuta"Ubili ste igraca %s!",GetName(targetid));
		SCM(playerid,-1,str);
		format(str,sizeof(str),""crvena"[KILL] "zuta"| Admin %s | Igraca %s |",GetName(playerid),GetName(targetid));
        SendAdminMessage(str);
		SetPlayerWantedLevel(targetid, 0);
		OcistiDosije(targetid);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:gethere(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new str[128], targetid;
	new Float:x,Float:y,Float:z;
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 2)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "u", targetid)) return USAGE(playerid,"/gethere [Id/ime]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(PlayerInfo[targetid][pZatvoren]) return ERROR(playerid,"Igrac je u zatvoru!");
		if(InEvent[targetid]) return ERROR(playerid,"Igrac je u eventu!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pGetSlabijih]) return ERROR(playerid,"Igrac je iskljucio teleport slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pGetSlabijih]) return ERROR(playerid,"Igrac je iskljucio teleport slabijih!");
		GetPlayerPos(playerid, x, y, z);
		SetPlayerPos(targetid,x,y+2, z);
		Freeze(targetid);
		SetPlayerInterior(targetid, GetPlayerInterior(playerid));
		SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
		PlayerInfo[targetid][pUbizzu] = PlayerInfo[playerid][pUbizzu];
        PlayerInfo[targetid][pUkuci] = PlayerInfo[playerid][pUkuci];
        PlayerInfo[targetid][pUorg] = PlayerInfo[playerid][pUorg];
        PlayerInfo[targetid][pUstanu] = PlayerInfo[playerid][pUstanu];
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{ format(str, sizeof(str),""zuta"Admin %s te teleportovao do sebe.",GetName(playerid)); }
		else { format(str, sizeof(str),""zelena"GameMaster %s te teleportovao do sebe.",GetName(playerid)); }
		SCM(targetid, -1, str);
		format(str, sizeof(str),""zuta"Teleportovali ste igraca %s do sebe.",GetName(targetid));
		SCM(playerid, -1, str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:sethp(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new targetid,Float:hp;
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params,"uf",targetid,hp)) return USAGE(playerid,"/sethp [Id/ime][Hp]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(InEvent[targetid]) return ERROR(playerid,"Igrac je u eventu!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if(hp > 99.0) return 1;
		SetPlayerHealth(targetid, hp);
		new str[150];
		format(str, sizeof(str),""zuta"Admin %s vam je postavio hp na %f.",GetName(playerid),hp);
		SCM(targetid, -1, str);
		format(str, sizeof(str),""zuta"Igracu %s si postavio hp na %f.",GetName(targetid),hp);
		SCM(playerid, -1, str);
		format(str, sizeof(str),""crvena"[HP] "zuta"| Admin %s | Igracu %s | Na %f |",GetName(playerid),GetName(targetid),hp);
        SendAdminMessage(str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:setarmour(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		new targetid,Float:hp;
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params,"uf",targetid,hp)) return USAGE(playerid,"/setarmour [Id/ime][Armour]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(InEvent[targetid]) return ERROR(playerid,"Igrac je u eventu!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if(hp > 99.0) return 1;
		SetPlayerArmour(targetid, hp);
		new str[150];
		format(str, sizeof(str),""zuta"Admin %s vam je postavio armour na %f.",GetName(playerid),hp);
		SCM(targetid, -1, str);
		format(str, sizeof(str),""zuta"Igracu %s si postavio armour na %f.",GetName(targetid),hp);
		SCM(playerid, -1, str);
		format(str, sizeof(str),""crvena"[ARMOUR] "zuta"| Admin %s | Igracu %s | Na %f |",GetName(playerid),GetName(targetid),hp);
        SendAdminMessage(str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:avozilo(playerid, params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
	    if(avozilo[playerid] != -1)
	    {
	        DestroyVehicle(avozilo[playerid]);
	        avozilo[playerid] = -1;
	        if(PlayerInfo[playerid][pAdmin] >= 1) { SCM(playerid,-1,""zuta"Vase admin vozilo je unisteno!"); }
	        else { SCM(playerid,-1,""zelena"Vase gamemaster vozilo je unisteno!"); }
	    }
	    else
	    {
            ShowPlayerDialog(playerid, DIALOG_AVOZILO, DIALOG_STYLE_PREVIEW_MODEL, "~b~"IME" - AVOZILO:","579\tHuntley\n560\tSultan\n521\tFCR-900\n567\tSavanna\n418\tMoonbeam", "Izaberi", "Odustani");
		}
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:a(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
  		if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
		new msg[200];
		if(sscanf(params,"s[200]",msg)) return USAGE(playerid,"/a [Poruka]");
		new str[300];
		format(str, sizeof(str),""bijela"["crvena"A"bijela"] (( "zuta"Admin level %d "bijela"|"crvena"%s[%d]: "bijela"%s ))",PlayerInfo[playerid][pAdmin],GetName(playerid),playerid,msg);
        foreach(Player,i)
		{
	 		if(PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAdminChat])
			{
	  			SCM(i,-1,str);
			}
		}
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:ao(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 3)
	{
  		if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
  		if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
		new msg[200];
		if(sscanf(params,"s[200]",msg)) return USAGE(playerid,"/ao [Poruka]");
		new str[300];
		if(PlayerInfo[playerid][pAdmin] >= 1)
	 	{ format(str, sizeof(str),""bijela"[OOC] (( "crvena"Admin %s: "bijela"%s ))",GetName(playerid),msg); }
	 	else { format(str, sizeof(str),""bijela"[OOC] (( "zelena"GameMaster %s: "bijela"%s ))",GetName(playerid),msg); }
        SCMTA(-1,str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:nitro(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 2)
	{
  		if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
	 	INFO(playerid,"Nitro dodat!");
	}
	else
	{
		 ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:ban(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new string[256],targetid, razlog[48];
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "us[48]", targetid, razlog)) return USAGE(playerid,"/ban [Id/ime][Razlog]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(PlayerInfo[targetid][pAdmin] > PlayerInfo[playerid][pAdmin]) return ERROR(playerid,"Ne mozete banovati tog igraca!");
		if(!strcmp("Vuk_Emerik",GetName(targetid),true)) return ERROR(playerid,"Ne mozete banovati tog igraca!");
		format(string,sizeof(string),""crvena"[BAN] Admin %s je banovao igraca %s (Razlog: %s).",GetName(playerid),GetName(targetid),razlog);
		SCMTA(-1,string);
		format(string,sizeof(string),""zuta"Banovani ste od strane admina "bijela"%s | "zuta"Razlog: "bijela"%s",GetName(playerid),razlog);
		SCM(targetid,-1,string);
		new string1[256];
		format(string1,sizeof(string1),""crvena"Banovali ste igraca "bijela"%s | "crvena"Razlog: "bijela"%s",GetName(targetid),razlog);
		SCM(playerid,-1,string1);
		Kickaj(targetid," ");
		new plrIP[24];
		GetPlayerIp(playerid, plrIP, sizeof(plrIP));
		new banfile[50];
		format(banfile,sizeof(banfile),QPATH,GetName(targetid));
  		new File:ban = fopen(banfile, io_write);
	    fwrite(ban, "[BAN]\n");
	    new fll[128];
		format(fll,64,"Admin %s\n", GetName(playerid));
	    fwrite(ban,fll);
		format(fll,128,"Razlog %s\n", razlog);
	    fwrite(ban,fll);
		format(fll,128,"Ip %s\n", plrIP);
	    fwrite(ban,fll);
	    fclose(ban);
	    new lgg[200];
		format(lgg,sizeof(lgg),"[BAN] | Admin %s | Igraca %s | Razlog %s |",GetName(playerid),GetName(targetid),razlog);
		Log(ADMIN_LOG,lgg);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:pm(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
  		if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
 		if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
 		new msg[60],id;
		if(sscanf(params,"us[60]",id,msg)) return USAGE(playerid,"/pm [Id/Ime][Poruka]");
		if(!IsPlayerConnected(id)) return ERROR(playerid,"Igrac nije u igri!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[id][pAdmin]) && !PlayerInfo[id][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[id][pGameMaster]) && !PlayerInfo[id][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		new str[100];
        if(PlayerInfo[playerid][pAdmin] >= 1)
	 	{ format(str, sizeof(str),""zuta"[PM] Admin %s | %s |",GetName(playerid),msg); }
		else { format(str, sizeof(str),""zelena"[PM] GameMaster %s | %s |",GetName(playerid),msg); }
		SCM(id,-1,str);
        format(str, sizeof(str),""zuta"Poslali ste poruku igracu %s.(%s)",GetName(id),msg);
        SCM(playerid,-1,str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:jlista(playerid, params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		new id = 0, string[150],str[250];
		foreach(Player,i)
		{
		    if(IsPlayerConnected(i))
		    {
				if(PlayerInfo[i][pZatvoren])
				{
					format(string,sizeof(string), "\n"plava"| Ime: "bijela"%s "plava"| ID: "bijela"%d "plava"| Vrijeme: "bijela"%d "plava"|", GetName(i), i, PlayerInfo[i][pVrijeme]);
					format(str,sizeof(str),"%s%s",str,string);
					id++;
				}
			}
		}
		if(id == 0) return ERROR(playerid,"Nema zatvorenih igraca!");
		ShowPlayerDialog(playerid,DIALOG_JAIL_LISTA,DIALOG_STYLE_MSGBOX,""zuta"Zatvoreni igraci:",str,""bijela"Ok","");
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:port(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1 || PlayerInfo[playerid][pVip] >= 1)
	{
		if(PlayerInfo[playerid][pZatvoren]) return ERROR(playerid,"U zatvoru ste!");
		if(Radi[playerid]) return ERROR(playerid,"Radite!");
		if(GetPlayerWL(playerid) >= 1) return ERROR(playerid,"Imate wanted levele!");
	    if(polaganje[playerid] != -1) return ERROR(playerid,"Polazete!");
	    if(Trenira[playerid] != -1) return ERROR(playerid,"Trenirate skill!");
	    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	    {
	    	if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		}
		new str[1000];
		for(new i=0;i<MAX_TELEPORTS;i++)
		{
	      	new str1[20];
	    	format(str1,sizeof(str1),TPATH,i);
			if(fexist(str1))
			{
			    format(str,sizeof(str),"%s"plava"[%d] "bijela"%s\n",str,i,TeleportInfo[i][tName]);
			}
            else
			{
			    format(str,sizeof(str),"%s"plava"[%d] "crvena"NEMA\n",str,i);
			}
		}
		ShowPlayerDialog(playerid,DIALOG_TELEPORT,DIALOG_STYLE_LIST,""zuta""IME" - Teleport",str,""bijela"TELEPORT",""bijela"ODUSTANI");
	}
	return 1;
}
//==============================================================================
CMD:kreirajteleport(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new id,name[24];
	if(sscanf(params,"ds[24]",id,name)) return USAGE(playerid,"/kreirajteleport [Id][Ime]");
    new str2[20];
    format(str2,sizeof(str2),TPATH,id);
	if(!fexist(str2) && id < MAX_TELEPORTS && id >= 0)
	{
	    new Float:x,Float:y,Float:z,Float:az;
	    GetPlayerPos(playerid,x,y,z);
	 	GetPlayerFacingAngle(playerid,az);
	 	TeleportInfo[id][tX] = x;
	 	TeleportInfo[id][tY] = y;
	 	TeleportInfo[id][tZ] = z;
	 	TeleportInfo[id][tAZ] = az;
	 	TeleportInfo[id][tInt] = GetPlayerInterior(playerid);
	 	TeleportInfo[id][tVW] = GetPlayerVirtualWorld(playerid);
	 	strmid(TeleportInfo[id][tName], name, 0, strlen(name), MAX_PLAYER_NAME);
	 	SacuvajTeleport(id);
	 	INFO(playerid,"Uspjesno ste kreirali teleport!");
	}
	else
	{
		ERROR(playerid,"Taj id se vec koristi!");
	}
	return 1;
}
//==============================================================================
CMD:izbrisiteleport(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new id;
	if(sscanf(params,"d",id)) return USAGE(playerid,"/izbrisiteleport [Id]");
    new str2[20];
    format(str2,sizeof(str2),TPATH,id);
	if(!fexist(str2))
	{
	    ERROR(playerid,"Taj id ne postoji!");
	}
	else
	{
	 	TeleportInfo[id][tX] = 0.0;
	 	TeleportInfo[id][tY] = 0.0;
	 	TeleportInfo[id][tZ] = 0.0;
	 	TeleportInfo[id][tAZ] = 0.0;
	 	TeleportInfo[id][tInt] = 0;
	 	TeleportInfo[id][tVW] = 0;
	 	strmid(TeleportInfo[id][tName], "~n~", 0, strlen("~n~"), MAX_PLAYER_NAME);
	 	fremove(str2);
	}
	return 1;
}
//==============================================================================
CMD:mute(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 2 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
		new targetid, razlog[64];
		if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "us[64]", targetid, razlog)) return USAGE(playerid,"/mute [Id/Ime][Razlog]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
		if(PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) return ERROR(playerid,"Ne mozete tog igraca!");
		if(PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) return ERROR(playerid,"Ne mozete tog igraca!");
		PlayerInfo[targetid][pMuted] = true;
		SacuvajIgraca(targetid);
		new str[256];
		format(str, sizeof(str), ""zuta"Mutirali ste igraca %s. Razlog %s!.", GetName(targetid),razlog);
		SCM(playerid, -1, str);
		if(PlayerInfo[playerid][pAdmin] >= 2)
		{ format(str, sizeof(str), ""crvena"[MUTE] Admin %s vas je mutirao!", GetName(playerid)); }
		else { format(str, sizeof(str), ""zelena"[MUTE] GameMaster %s vas je mutirao!", GetName(playerid)); }
		SCM(targetid, -1, str);
		format(str, sizeof(str), ""crvena"[MUTE]: "bijela"Razlog: %s.", razlog);
		SCM(targetid, -1, str);
		format(str, sizeof(str), ""crvena"[MUTE] "zuta"| Admin %s | Igraca %s | Razlog %s |", GetName(playerid),GetName(targetid),razlog);
		SendAdminMessage(str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:astats(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new targetid;
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "u", targetid)) return USAGE(playerid,"/astats [Id/Ime]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		ShowStats(playerid,targetid); 
		new str[150];
		format(str, sizeof(str), ""zuta"Gledate stats igraca %s!.", GetName(targetid));
		SCM(playerid, -1, str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:offban(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		new targetid[24], razlog[48];
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "s[24]s[48]", targetid, razlog)) return USAGE(playerid,"/offban [Ime_Prezime][Razlog]");
		new id=-1;
		foreach(Player,i)
		{
		    if(IsPlayerConnected(i))
		    {
			    if(!strcmp(GetName(i),targetid,true))
			    {
			        id=i;
			    }
			}
		}
		if(id != -1) return ERROR(playerid,"Taj igrac trenutno igra!");
		if(!strcmp("Vuk_Emerik",targetid,true)) return ERROR(playerid,"Ne mozete banovati tog igraca!");
		new str[50];
		format(str,sizeof(str),PATH,targetid);
		if(!fexist(str)) return ERROR(playerid,"Taj igrac ne postoji!");
		new string1[256];
		format(string1,sizeof(string1),""crvena"Banovali ste igraca "bijela"%s | "crvena"Razlog: "bijela"%s",targetid,razlog);
		SCM(playerid,-1,string1);
		format(string1,sizeof(string1),""crvena"[OFFBAN] "zuta"| Admin %s | Igraca %s | Razlog %s |",GetName(playerid),targetid,razlog);
	    SendAdminMessage(string1);
		new banfile[50];
		format(banfile,sizeof(banfile),QPATH,targetid);
  		new File:ban = fopen(banfile, io_write);
	    fwrite(ban, "[BAN]\n");
	    new fl[64];
		format(fl,64,"Admin %s\n", GetName(playerid));
	    fwrite(ban,fl);
	    new fll[128];
		format(fll,128,"Razlog %s\n", razlog);
	    fwrite(ban,fll);
	    fclose(ban);
	    new lgg[200];
		format(lgg,sizeof(lgg),"[OFFBAN] | Admin %s | Igraca %s | Razlog %s |",GetName(playerid),targetid,razlog);
		Log(ADMIN_LOG,lgg);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:rac(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 2 || PlayerInfo[playerid][pGameMaster] >= 3)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(respawn == 1) return ERROR(playerid,"Netko je vec pokreno respawn!");
		new str[150]; respawn = 1;
		if(PlayerInfo[playerid][pAdmin] >= 2)
		{
			format(str,sizeof str, ""zuta"Admin %s je pokrenuo respawn svih vozila!", GetName(playerid));
			SCMTA(-1, str);
			SCMTA(-1, ""zuta"Sva vozila ce bit respawnovana za 20 sekundi!");
			SCMTA(-1, ""zuta"Da sacuvate vozilo udite u njega!");
		}
		else
		{
		    format(str,sizeof str, ""zelena"GameMaster %s je pokrenuo respawn svih vozila!", GetName(playerid));
			SCMTA(-1, str);
			SCMTA(-1, ""zelena"Sva vozila ce bit respawnovana za 20 sekundi!");
			SCMTA(-1, ""zelena"Da sacuvate vozilo udite u njega!");
		}
		SetTimer("respawntimer", 20000, false);
    }
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:uvozilo(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		new id,sjediste;
		if(sscanf(params,"dd",id,sjediste)) return USAGE(playerid,"/uvozilo [ID][Sjediste]");
		PutPlayerInVehicle(playerid,id,sjediste);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:getvozilo(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		new id;
		if(sscanf(params,"d",id)) return USAGE(playerid,"/getvozilo [ID]");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		SetVehiclePos(id,x,y,z);
	}
	else
	{
 		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:gotopos(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		new Float:x,Float:y,Float:z,interior,vw;
		if(sscanf(params,"fffdd",x,y,z,interior,vw)) return USAGE(playerid,"/gotopos [X][Y][Z][Interior][VirtualWorld]");
		SetPlayerPos(playerid,x,y,z);
		Freeze(playerid);
		SetPlayerInterior(playerid,interior);
		SetPlayerVirtualWorld(playerid,vw);
		PlayerInfo[playerid][pUbizzu] = -1;
		PlayerInfo[playerid][pUkuci] = -1;
		PlayerInfo[playerid][pUorg] = -1;
		PlayerInfo[playerid][pUstanu] = -1;
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:unmute(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		new targetid;
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "u", targetid)) return USAGE(playerid,"/unmute [Id/Ime]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
		PlayerInfo[targetid][pMuted] = false;
		SacuvajIgraca(targetid);
		new str[256];
		format(str, sizeof(str), ""zuta"Unutirali ste igraca %s.", GetName(targetid));
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""crvena"[UNMUTE] Admin %s vas je unmutirao!", GetName(playerid));
		SCM(targetid, -1, str);
		format(str, sizeof(str), ""crvena"[UNMUTE] "zuta"| Admin %s | Igraca %s |", GetName(playerid),GetName(targetid));
		SendAdminMessage(str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:bojavozila(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
  		if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u vozilu!");
		new color1,color2;
		if(sscanf(params,"dd",color1,color2)) return USAGE(playerid,"/bojavozila [Boja 1][Boja 2]");
        ChangeVehicleColor(GetPlayerVehicleID(playerid), color1, color2);
        INFO(playerid,"Uspjesno ste promjenili boju vozila!");
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:aocistidosije(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		new targetid;
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "u", targetid)) return USAGE(playerid,"/aocistidosije [Id/Ime]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
		if(PlayerInfo[targetid][pWL] < 1) return ERROR(playerid,"Igrac nema wanted level!");
		new str[256];
		format(str, sizeof(str), ""zuta"Ocistili ste dosije igracu %s", GetName(targetid));
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""crvena"[DOSIJE] Admin %s vam je ocistio dosije!", GetName(playerid));
		SCM(targetid, -1, str);
		format(str, sizeof(str), ""crvena"[OCISTIO DOSIJE] "zuta"| Admin %s | Igraca %s |", GetName(playerid),GetName(targetid));
		SendAdminMessage(str);
		OcistiDosije(targetid); 
		SacuvajIgraca(targetid);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:veh(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] >= 5)
    {
		new vehid;
		if(sscanf(params,"d",vehid)) return USAGE(playerid,"/veh [vehicleid]");
		if(vehid < 401 || vehid > 611) return ERROR(playerid,"Pogresan id vozila!");
		if(avozilo[playerid] != -1)
	    {
	        DestroyVehicle(avozilo[playerid]);
	        avozilo[playerid] = -1;
	        INFO(playerid,"Vase admin vozilo je unisteno!");
	    }
	    else
	    {
			new Float:x,Float:y,Float:z,Float:az;
			GetPlayerPos(playerid,x,y,z);
			GetPlayerFacingAngle(playerid,az);
			avozilo[playerid] = CreateVehicle(vehid,x,y,z,az,1,1,100);
			SetGorivo(avozilo[playerid]);
			PutPlayerInVehicle(playerid,avozilo[playerid],0);
		}
	}
	return 1;
}
//==============================================================================
CMD:setskin(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		new targetid,id;
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "ud", targetid, id)) return USAGE(playerid,"/setskin [Id/Ime][Skin id]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if(id < 0 || id > 311) return ERROR(playerid,"Pogresan id skina!");
		if(PlayerInfo[targetid][pOrgID] != -1)
		{
		    if(PlayerInfo[targetid][pRank] == 1) { SetPlayerSkin(targetid,OrgInfo[PlayerInfo[targetid][pOrgID]][oRankSkin1]); }
			else if(PlayerInfo[targetid][pRank] == 2) { SetPlayerSkin(targetid,OrgInfo[PlayerInfo[targetid][pOrgID]][oRankSkin2]);  }
	        else if(PlayerInfo[targetid][pRank] == 3) { SetPlayerSkin(targetid,OrgInfo[PlayerInfo[targetid][pOrgID]][oRankSkin3]);  }
	        else if(PlayerInfo[targetid][pRank] == 4) { SetPlayerSkin(targetid,OrgInfo[PlayerInfo[targetid][pOrgID]][oRankSkin4]);  }
	        else if(PlayerInfo[targetid][pRank] == 5) { SetPlayerSkin(targetid,OrgInfo[PlayerInfo[targetid][pOrgID]][oRankSkin5]);  }
	        else if(PlayerInfo[targetid][pRank] == 6) { SetPlayerSkin(targetid,OrgInfo[PlayerInfo[targetid][pOrgID]][oRankSkin6]);  }
		}
		else
		{
			SetPlayerSkin(targetid,id);
		}
		PlayerInfo[targetid][pSkin] = id;
		SacuvajIgraca(targetid);
		new str[256];
		format(str, sizeof(str), ""zuta"Promijenili ste skin igracu %s na %d!", GetName(targetid),id);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""crvena"[SKIN] Admin %s vam je promjenio skin!", GetName(playerid));
		SCM(targetid, -1, str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:unban(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
		new targetid[24];
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "s[24]", targetid)) return USAGE(playerid,"/unban [Ime_Prezime]");
		new str[50];
		format(str,sizeof(str),QPATH,targetid);
		if(!fexist(str)) return ERROR(playerid,"Taj igrac nije banan!");
		new string1[256];
		format(string1,sizeof(string1),""crvena"Unbanovali ste igraca "bijela"%s",targetid);
		SCM(playerid,-1,string1);
		format(string1,sizeof(string1),""crvena"[UNBAN] "zuta"| Admin %s | Igraca %s |",GetName(playerid),targetid);
	    SendAdminMessage(string1);
        fremove(str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}

//==============================================================================
CMD:anapuni(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u vozilu!");
        SetGorivo(GetPlayerVehicleID(playerid));
        INFO(playerid,"Uspjesno ste napunili vozilo!");
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:jetpack(playerid, params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 4) return ERROR(playerid,"Niste ovlasteni");
    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
	{
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	}
	else
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
		INFO(playerid,"Uzeli ste jetpack!");
	}
	return 1;
}
//==============================================================================
CMD:adozvole(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
		new targetid, info[24], dozv;
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "us[24]d", targetid, info,dozv)) return USAGE(playerid,"/adozvole [Id/Ime][Daj/Oduzmi][Broj]"), INFO(playerid,"0 - Oruzje | 1 - Vozacka | 2 - Motor | 3 - Kamion | 4 - Brod | 5 - Letjelice");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		new str[256];
		if(!strcmp("Daj",info,true) && !strcmp("daj",info,true))
		{
		    if(dozv == 0)
		    {
		        PlayerInfo[targetid][pOruzjeDozvola] = true;
		        format(str, sizeof(str), ""zuta"Dali ste dozvolu za oruzje igracu %s.", GetName(targetid));
				SCM(playerid, -1, str);
				format(str, sizeof(str), ""bijela"Admin %s vam je dao dozvolu za oruzje!", GetName(playerid));
				SCM(targetid, -1, str);
		    }
		    else if(dozv == 1)
		    {
		        PlayerInfo[targetid][pVozackaDozvola] = true;
		        format(str, sizeof(str), ""zuta"Dali ste vozacku dozvolu igracu %s.", GetName(targetid));
				SCM(playerid, -1, str);
				format(str, sizeof(str), ""bijela"Admin %s vam je dao vozacku dozvolu!", GetName(playerid));
				SCM(targetid, -1, str);
		    }
		    else if(dozv == 2)
		    {
		        PlayerInfo[targetid][pMotorDozvola] = true;
		        format(str, sizeof(str), ""zuta"Dali ste dozvolu za motor igracu %s.", GetName(targetid));
				SCM(playerid, -1, str);
				format(str, sizeof(str), ""bijela"Admin %s vam je dao dozvolu za motor!", GetName(playerid));
				SCM(targetid, -1, str);
		    }
		    else if(dozv == 3)
		    {
		        PlayerInfo[targetid][pKamionDozvola] = true;
		        format(str, sizeof(str), ""zuta"Dali ste dozvolu za kamion igracu %s.", GetName(targetid));
				SCM(playerid, -1, str);
				format(str, sizeof(str), ""bijela"Admin %s vam je dao dozvolu za kamion!", GetName(playerid));
				SCM(targetid, -1, str);
		    }
		    else if(dozv == 4)
		    {
		        PlayerInfo[targetid][pBrodDozvola] = true;
		        format(str, sizeof(str), ""zuta"Dali ste dozvolu za brod igracu %s.", GetName(targetid));
				SCM(playerid, -1, str);
				format(str, sizeof(str), ""bijela"Admin %s vam je dao dozvolu za brod!", GetName(playerid));
				SCM(targetid, -1, str);
		    }
		    else if(dozv == 5)
		    {
		        PlayerInfo[targetid][pLetjeliceDozvola] = true;
		        format(str, sizeof(str), ""zuta"Dali ste dozvolu za letjelice igracu %s.", GetName(targetid));
				SCM(playerid, -1, str);
				format(str, sizeof(str), ""bijela"Admin %s vam je dao dozvolu za letjelice!", GetName(playerid));
				SCM(targetid, -1, str);
		    }
		    else return USAGE(playerid,"/adozvole [Id/Ime][Daj/Oduzmi][Broj]"), INFO(playerid,"0 - Oruzje | 1 - Vozacka | 2 - Motor | 3 - Kamion | 4 - Brod | 5 - Letjelice");
		}
		else if(!strcmp("Oduzmi",info,true) && !strcmp("oduzmi",info,true))
		{
            if(dozv == 0)
		    {
		        PlayerInfo[targetid][pOruzjeDozvola] = false;
		        format(str, sizeof(str), ""zuta"Oduzeli ste dozvolu za oruzje igracu %s.", GetName(targetid));
				SCM(playerid, -1, str);
				format(str, sizeof(str), ""bijela"Admin %s vam je oduzeo dozvolu za oruzje!", GetName(playerid));
				SCM(targetid, -1, str);
		    }
		    else if(dozv == 1)
		    {
		        PlayerInfo[targetid][pVozackaDozvola] = false;
		        format(str, sizeof(str), ""zuta"Oduzeli ste vozacku dozvolu igracu %s.", GetName(targetid));
				SCM(playerid, -1, str);
				format(str, sizeof(str), ""bijela"Admin %s vam je oduzeo vozacku dozvolu!", GetName(playerid));
				SCM(targetid, -1, str);
		    }
		    else if(dozv == 2)
		    {
		        PlayerInfo[targetid][pMotorDozvola] = false;
		        format(str, sizeof(str), ""zuta"Oduzeli ste dozvolu za motor igracu %s.", GetName(targetid));
				SCM(playerid, -1, str);
				format(str, sizeof(str), ""bijela"Admin %s vam je oduzeo dozvolu za motor!", GetName(playerid));
				SCM(targetid, -1, str);
		    }
		    else if(dozv == 3)
		    {
		        PlayerInfo[targetid][pKamionDozvola] = false;
		        format(str, sizeof(str), ""zuta"Oduzeli ste dozvolu za kamion igracu %s.", GetName(targetid));
				SCM(playerid, -1, str);
				format(str, sizeof(str), ""bijela"Admin %s vam je oduzeo dozvolu za kamion!", GetName(playerid));
				SCM(targetid, -1, str);
		    }
		    else if(dozv == 4)
		    {
		        PlayerInfo[targetid][pBrodDozvola] = false;
		        format(str, sizeof(str), ""zuta"Oduzeli ste dozvolu za brod igracu %s.", GetName(targetid));
				SCM(playerid, -1, str);
				format(str, sizeof(str), ""bijela"Admin %s vam je oduzeo dozvolu za brod!", GetName(playerid));
				SCM(targetid, -1, str);
		    }
		    else if(dozv == 5)
		    {
		        PlayerInfo[targetid][pLetjeliceDozvola] = false;
		        format(str, sizeof(str), ""zuta"Oduzeli ste dozvolu za letjelice igracu %s.", GetName(targetid));
				SCM(playerid, -1, str);
				format(str, sizeof(str), ""bijela"Admin %s vam je oduzeo dozvolu za letjelice!", GetName(playerid));
				SCM(targetid, -1, str);
		    }
		    else return USAGE(playerid,"/adozvole [Id/Ime][Daj/Oduzmi][Broj]"), INFO(playerid,"0 - Oruzje | 1 - Vozacka | 2 - Motor | 3 - Kamion | 4 - Brod | 5 - Letjelice");
		}
		else return USAGE(playerid,"/adozvole [Id/Ime][Daj/Oduzmi][Broj]"), INFO(playerid,"0 - Oruzje | 1 - Vozacka | 2 - Motor | 3 - Kamion | 4 - Brod | 5 - Letjelice");
		SacuvajIgraca(targetid);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni!");
	}
	return 1;
}
//==============================================================================
CMD:adajsvima(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		new broj;
		if(sscanf(params, "d",broj)) return USAGE(playerid,"/adajsvima [Broj]"), INFO(playerid,"0 - Level(+1) | 1 - Novac(+10000$) | 2 - EXP(+1)");
        if(broj == 0)
        {
            foreach(Player,i)
            {
                PlayerInfo[i][pLevel]++;
                SacuvajIgraca(i);
                SCM(i,-1,"Admin je svima dao leveup!");
				SetPlayerScore(i,PlayerInfo[i][pLevel]);
            }
        }
        else if(broj == 1)
        {
            foreach(Player,i)
            {
               GivePlayerMoney(i,10000);
               PlayerInfo[i][pMoney] += 10000;
               SacuvajIgraca(i);
               SCM(i,-1,"Admin je svima dao 10000$!");
            }
        }
        else if(broj == 2)
        {
            foreach(Player,i)
            {
            	PlayerInfo[i][pEXP]++;
            	SacuvajIgraca(i);
             	SCM(i,-1,"Admin je dao svima jedan respekt!");
            }
        }
        else return USAGE(playerid,"/adajsvima [Broj]"), INFO(playerid,"0 - Level(+1) | 1 - Novac(+10000$) | 2 - EXP(+1)");
	}
	return 1;
}
//==============================================================================
CMD:sacuvajigrace(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
	    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	    foreach(Player,i)
	    {
	        if(IsPlayerConnected(i))
	        {
	            if(Ulogovan[i]) {	SacuvajIgraca(i); }
	        }
	    }
	    SCMTA(-1,""zuta"Admin je sacuvao statistike svih igraca!");
	}
	return 1;
}
//==============================================================================
CMD:unjail(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
		new targetid;
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "u", targetid)) return USAGE(playerid,"/unjail [Id/Ime]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if(!PlayerInfo[targetid][pZatvoren]) return ERROR(playerid,"Taj igrac nije zatvoren!");
        AdminDuty[targetid] = false;
        PolicijaDuty[playerid] = false;
        GameMasterDuty[playerid] = false;
		GameTextForPlayer(targetid,"~r~UNJAILED",5000,3);
		PlayerInfo[targetid][pZatvoren] = false;
        PlayerInfo[targetid][pVrijeme] = 0;
	    SetPlayerPos(playerid,244.3357,67.8510,1003.6406);
		SetPlayerVirtualWorld(playerid,9);
		SetPlayerInterior(playerid,6);
		PlayerInfo[playerid][pUorg] = POLICIJA;
		Freeze(playerid);
	    KillTimer(ZatvorTimer[targetid]);
		SacuvajIgraca(targetid);
		new str[256];
		format(str, sizeof(str), ""zuta"Oslobodili ste igraca %s iz zatvora!.", GetName(targetid));
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""bijela"[UNJAIL] Admin %s vas je pustio iz zatvora.", GetName(playerid));
		SCM(targetid, -1, str);
		format(str, sizeof(str), ""crvena"[UNJAIL] "zuta"| Admin %s | Igraca %s |", GetName(playerid),GetName(targetid));
		SendAdminMessage(str);
		OcistiDosije(targetid);
	 	ResetPlayerWeapons(targetid);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:postaviadmina(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(PlayerInfo[playerid][pAdmin] >= 6)
	{
	    new targetid,level;
		if(sscanf(params,"ud",targetid,level))
		{
	 		USAGE(playerid,"/postaviadmina [Id/Ime][Level]!");
			return 1;
		}
		if(level < 0 || level > 6) return 1;
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(!strcmp("Vuk_Emerik",GetName(targetid),true)) return ERROR(playerid,"Ne mozete mu skinuti admina!");
		if(PlayerInfo[targetid][pGameMaster] >= 1) return ERROR(playerid,"Igrac je gamemaster!");
		new str[100];
	 	PlayerInfo[targetid][pAdmin] = level;
	 	ShowPlayerDialog(targetid,DIALOG_PROMOTION,DIALOG_STYLE_MSGBOX,""plava""IME" - Admin:",""zuta"Cestitamo na dobitku admina!\n"crvena"Nadamo se da nas necete iznevjeriti!","Ok","");
	    format(str,sizeof(str),""plava"Admin %s vam je postavio admina level %d.",GetName(playerid),level);
	    SCM(targetid,-1,str);
	    format(str,sizeof(str),""crvena"[ADMIN] "zuta"| Admin %s | Igracu %s | Level %d",GetName(playerid),GetName(targetid),level);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[ADMIN] | Admin %s | Igracu %s | Level %d |",GetName(playerid),GetName(targetid),level);
		Log(ADMIN_LOG,lgg);
		AdminDuty[targetid] = false;
	}
	return 1;
}
//==============================================================================
CMD:dpostaviadmina(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 5) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
	    new targetid,level;
		if(sscanf(params,"ud",targetid,level))
		{
	 		USAGE(playerid,"/dpostaviadmina [Id/Ime][Level]!");
			return 1;
		}
		if(level < 0 || level > 4) return 1;
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(!strcmp("Vuk_Emerik",GetName(targetid),true)) return ERROR(playerid,"Ne mozete mu skinuti admina!");
		if(PlayerInfo[playerid][pAdmin] <= PlayerInfo[targetid][pAdmin]) return ERROR(playerid,"Ne mozete tom adminu!");
		if(PlayerInfo[targetid][pGameMaster] >= 1) return ERROR(playerid,"Igrac je gamemaster!");
		new str[100];
	 	PlayerInfo[targetid][pAdmin] = level;
	 	ShowPlayerDialog(targetid,DIALOG_PROMOTION,DIALOG_STYLE_MSGBOX,""plava""IME" - Admin:",""zuta"Cestitamo na dobitku admina!\n"crvena"Nadamo se da nas necete iznevjeriti!","Ok","");
	    format(str,sizeof(str),""plava"Admin %s vam je postavio admina level %d.",GetName(playerid),level);
	    SCM(targetid,-1,str);
	    format(str,sizeof(str),""crvena"[ADMIN] "zuta"| Admin %s | Igracu %s | Level %d",GetName(playerid),GetName(targetid),level);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[ADMIN] | Admin %s | Igracu %s | Level %d |",GetName(playerid),GetName(targetid),level);
		Log(ADMIN_LOG,lgg);
		AdminDuty[targetid] = false;
	}
	return 1;
}
//==============================================================================
CMD:postavigamemastera(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 6)
	{
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		new targetid,level;
		if(sscanf(params,"ud",targetid,level))
		{
			USAGE(playerid,"/postavigamemastera [Id/Ime][Level]!");
			return 1;
		}
		if(level < 0 || level > 3) return ERROR(playerid,"Pogresan level!");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		new str[100];
	 	PlayerInfo[targetid][pGameMaster] = level;
	 	ShowPlayerDialog(targetid,DIALOG_PROMOTION,DIALOG_STYLE_MSGBOX,""plava""IME" - GameMaster:",""zelena"Cestitamo na dobitku gamemastera!\n"crvena"Nadamo se da nas necete iznevjeriti!","Ok","");
	    format(str,sizeof(str),""plava"Admin %s vam je postavio gamemaster level %d.",GetName(playerid),level);
	    SCM(targetid,-1,str);
	    if(PlayerInfo[targetid][pAdmin] >= 1) { INFO(playerid,"Postavili ste gamemastera adminu! Admina mu skinite rucno."); }
	    format(str,sizeof(str),""crvena"[GAMEMASTER] "zuta"| Admin %s | Igracu %s | Level %d",GetName(playerid),GetName(targetid),level);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[GM] | Admin %s | Igracu %s | Level %d |",GetName(playerid),GetName(targetid),level);
		Log(ADMIN_LOG,lgg);
		GameMasterDuty[targetid] = false;
		return 1;
	}
	else if(PlayerInfo[playerid][pGameMaster] >= 3)
	{
	    if(!GameMasterDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		new targetid,level;
		if(sscanf(params,"ud",targetid,level))
		{
			USAGE(playerid,"/postavigamemastera [Id/Ime][Level]!");
			return 1;
		}
		if(level < 0 || level > 2) return ERROR(playerid,"Pogresan level!");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(PlayerInfo[targetid][pAdmin] >= 1) return ERROR(playerid,"Igrac je admin!");
		if(PlayerInfo[targetid][pGameMaster] >= PlayerInfo[playerid][pGameMaster]) return ERROR(playerid,"Ne mozete njemu!");
		new str[100];
	 	PlayerInfo[targetid][pGameMaster] = level;
	    format(str,sizeof(str),""plava"GameMaster %s vam je postavio gamemaster level %d.",GetName(playerid),level);
	    SCM(targetid,-1,str);
	    format(str,sizeof(str),""zelena"[GAMEMASTER] "zuta"| GameMaster %s | Igracu %s | Level %d",GetName(playerid),GetName(targetid),level);
		SendAdminMessage(str);
		SendGameMasterMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[GM] | GameMaster %s | Igracu %s | Level %d |",GetName(playerid),GetName(targetid),level);
		Log(ADMIN_LOG,lgg);
		GameMasterDuty[targetid] = false;
		return 1;
	}
	else return ERROR(playerid,"Niste ovlasteni!");
}
//==============================================================================
CMD:givemoney(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new targetid,kolicina;
	if(sscanf(params,"ud",targetid,kolicina)) return USAGE(playerid,"/givemoney [Id/Ime][Kolicina]!");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
	new str[100];
 	PlayerInfo[targetid][pMoney] += kolicina;
 	GivePlayerMoney(targetid,kolicina);
    format(str,sizeof(str),""plava"Admin %s vam je dao %d$.",GetName(playerid),kolicina);
    SCM(targetid,-1,str);
    format(str,sizeof(str),""crvena"[GIVE MONEY] "zuta"| Admin %s | Igracu %s | Kolicina %d",GetName(playerid),GetName(targetid),kolicina);
	SendAdminMessage(str);
	new lgg[200];
	format(lgg,sizeof(lgg),"[GIVE-MONEY] | Admin %s | Igracu %s | Kolicina %d |",GetName(playerid),GetName(targetid),kolicina);
	Log(ADMIN_LOG,lgg);
	return 1;
}
//==============================================================================
CMD:setmoney(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new targetid,kolicina;
	if(sscanf(params,"ud",targetid,kolicina)) return USAGE(playerid,"/setmoney [Id/Ime][Kolicina]!");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
	new str[100];
	ResetPlayerMoney(targetid);
 	PlayerInfo[targetid][pMoney] = kolicina;
 	GivePlayerMoney(targetid,kolicina);
    format(str,sizeof(str),""plava"Admin %s vam je postavio %d$.",GetName(playerid),kolicina);
    SCM(targetid,-1,str);
    format(str,sizeof(str),""crvena"[SET MONEY] "zuta"| Admin %s | Igracu %s | Kolicina %d",GetName(playerid),GetName(targetid),kolicina);
	SendAdminMessage(str);
	new lgg[200];
	format(lgg,sizeof(lgg),"[SET-MONEY] | Admin %s | Igracu %s | Kolicina %d |",GetName(playerid),GetName(targetid),kolicina);
	Log(ADMIN_LOG,lgg);
	return 1;
}
//==============================================================================
CMD:setstats(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new id, broj, na;
	if(sscanf(params, "udd", id, broj, na))
	{
		USAGE(playerid,"/setstats [Id/Ime][Broj][Kolicina]!");
		INFO(playerid,"| 1. Level | 2. Respekti | 3. Banka novac | 4. Sati Igranja |");
		INFO(playerid,"| 5. Droga | 6. Mats | 7. Posao | 8. Staz | 9. Sjeme droge");
		INFO(playerid,"| 10. Biznis id | 11. Kuca id | 12. Dinamit | 13. Stan id");
		return 1;
	}
	if(!IsPlayerConnected(id)) return ERROR(playerid,"Igrac nije u igri!");
	new str[200];
	if(broj == 1)
	{
		PlayerInfo[id][pLevel] = na;
		SetPlayerScore(id, na);
		SacuvajIgraca(id);
		format(str, sizeof(str), ""zuta"Igracu %s ste podesili level na %d.", GetName(id),na);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio level na %d.", GetName(playerid),na);
		SCM(id, -1, str);
		format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Level %d |", GetName(playerid),GetName(id),na);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Level %d |",GetName(playerid),GetName(id),na);
		Log(ADMIN_LOG,lgg);
	}
	else if(broj == 2)
	{
		PlayerInfo[id][pEXP] = na;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""zuta"Igracu %s ste podesili respekte na %d.", GetName(id),na);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio respekte na %d.", GetName(playerid),na);
		SCM(id, -1, str);
		format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Respekt %d |", GetName(playerid),GetName(id),na);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Respekti %d |",GetName(playerid),GetName(id),na);
		Log(ADMIN_LOG,lgg);
	}
	else if(broj == 3)
	{
		PlayerInfo[id][pBankMoney] = na;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""zuta"Igracu %s ste podesili bankovni novac na %d$.", GetName(id),na);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio bankovni novac na %d$.", GetName(playerid),na);
		SCM(id, -1, str);
		format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Bank novac %d$ |", GetName(playerid),GetName(id),na);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Banka novac %d |",GetName(playerid),GetName(id),na);
		Log(ADMIN_LOG,lgg);
		UpdateBankaZlatoTD(id);
	}
	else if(broj == 4)
	{
		PlayerInfo[id][pSatiOnline] = na;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""zuta"Igracu %s ste podesili sate igranja na %d.", GetName(id),na);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio sate igranja na %d.", GetName(playerid),na);
		SCM(id, -1, str);
		format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Sati igranja %d |", GetName(playerid),GetName(id),na);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Sati online %d |",GetName(playerid),GetName(id),na);
		Log(ADMIN_LOG,lgg);
	}
	else if(broj == 5)
	{
		PlayerInfo[id][pDroga] = na;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""zuta"Igracu %s ste podesili drogu na %dg.", GetName(id),na);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio drogu na %dg.", GetName(playerid),na);
		SCM(id, -1, str);
		format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Droga %dg |", GetName(playerid),GetName(id),na);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Droga %d |",GetName(playerid),GetName(id),na);
		Log(ADMIN_LOG,lgg);
	}
	else if(broj == 6)
	{
		PlayerInfo[id][pMats] = na;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""zuta"Igracu %s ste podesili mats na %dg.", GetName(id),na);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio mats na %dg.", GetName(playerid),na);
		SCM(id, -1, str);
		format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Mats %dg |", GetName(playerid),GetName(id),na);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Mats %d |",GetName(playerid),GetName(id),na);
		Log(ADMIN_LOG,lgg);
	}
	else if(broj == 7)
	{
	    if(na >= MAX_JOBS || na < -1) return ERROR(playerid,"Taj posao ne postoji!");
	    if(Radi[id]) return ERROR(playerid,"Igrac radi!");
	    if(Opremljen[id]) return ERROR(playerid,"Igrac ima opremu!");
		PlayerInfo[id][pPosao] = na;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""zuta"Igracu %s ste podesili posao %s.", GetName(id),JobInfo[PlayerInfo[id][pPosao]][jName]);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio posao %s.", GetName(playerid),JobInfo[PlayerInfo[id][pPosao]][jName]);
		SCM(id, -1, str);
		format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Posao %s |", GetName(playerid),GetName(id),JobInfo[PlayerInfo[id][pPosao]][jName]);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Posao %d |",GetName(playerid),GetName(id),na);
		Log(ADMIN_LOG,lgg);
	}
	else if(broj == 8)
	{
		PlayerInfo[id][pStaz] = na;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""zuta"Igracu %s ste podesili staz na %d.", GetName(id),na);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio staz na %d.", GetName(playerid),na);
		SCM(id, -1, str);
		format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Staz %d |", GetName(playerid),GetName(id),na);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Staz %d |",GetName(playerid),GetName(id),na);
		Log(ADMIN_LOG,lgg);
	}
	else if(broj == 9)
	{
		PlayerInfo[id][pSjemeDroge] = na;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""zuta"Igracu %s ste podesili sjeme droge na %d.", GetName(id),na);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio sjeme droge na %d.", GetName(playerid),na);
		SCM(id, -1, str);
		format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Sjeme droge %d |", GetName(playerid),GetName(id),na);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Sjeme droge %d |",GetName(playerid),GetName(id),na);
		Log(ADMIN_LOG,lgg);
	}
	else if(broj == 10)
	{
	    if(na == -1)
	    {
	        if(PlayerInfo[id][pBizzID] != -1)
	        {
	            new i = PlayerInfo[id][pBizzID];
	            BiznisInfo[i][bOwned] = false;
				strmid(BiznisInfo[i][bOwnerName], "Drzava", 0, strlen("Drzava"), MAX_PLAYER_NAME);
				BiznisLP(i);
				BiznisInfo[i][bLocked] = false;
				PlayerInfo[id][pBizzID] = -1;
				SacuvajBiznis(i);
				SacuvajIgraca(id);
	        }
			PlayerInfo[id][pBizzID] = na;
			SacuvajIgraca(id);
			format(str, sizeof(str), ""zuta"Igracu %s ste podesili biznis id na %d.", GetName(id),na);
			SCM(playerid, -1, str);
			format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio biznis id na %d.", GetName(playerid),na);
			SCM(id, -1, str);
			format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Id biznisa %d |", GetName(playerid),GetName(id),na);
			SendAdminMessage(str);
			new lgg[200];
			format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Id biznisa %d |",GetName(playerid),GetName(id),na);
			Log(ADMIN_LOG,lgg);
		}
		else
		{
            if(PlayerInfo[id][pBizzID] != -1) return ERROR(playerid,"Igrac je vlasnik nekog biznisa!");
            if(BiznisInfo[na][bOwned]) return ERROR(playerid,"Biznis ima vlasnika!");
            new i = na;
            BiznisInfo[i][bOwned] = true;
			BiznisInfo[i][bOwnerName] = RemoveUnderLine(GetName(id));
			BiznisLP(i);
			BiznisInfo[i][bLocked] = false;
			PlayerInfo[id][pBizzID] = na;
			SacuvajBiznis(i);
			SacuvajIgraca(id);
			format(str, sizeof(str), ""zuta"Igracu %s ste podesili biznis id na %d.", GetName(id),na);
			SCM(playerid, -1, str);
			format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio biznis id na %d.", GetName(playerid),na);
			SCM(id, -1, str);
			format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Id biznisa %d |", GetName(playerid),GetName(id),na);
			SendAdminMessage(str);
			new lgg[200];
			format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Id biznisa %d |",GetName(playerid),GetName(id),na);
			Log(ADMIN_LOG,lgg);
		}
		
	}
	else if(broj == 11)
	{
		if(na == -1)
	    {
	        if(PlayerInfo[id][pKucaID] != -1)
	        {
	            new i = PlayerInfo[id][pKucaID];
	            KucaInfo[i][kOwned] = false;
				strmid(KucaInfo[i][kOwnerName], "Drzava", 0, strlen("Drzava"), MAX_PLAYER_NAME);
				KucaLP(i);
				KucaInfo[i][kLocked] = false;
				PlayerInfo[id][pKucaID] = -1;
				SacuvajKucu(i);
				SacuvajIgraca(id);
	        }
			PlayerInfo[id][pKucaID] = na;
			SacuvajIgraca(id);
			format(str, sizeof(str), ""zuta"Igracu %s ste podesili kuca id na %d.", GetName(id),na);
			SCM(playerid, -1, str);
			format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio kuca id na %d.", GetName(playerid),na);
			SCM(id, -1, str);
			format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Id kuce %d |", GetName(playerid),GetName(id),na);
			SendAdminMessage(str);
			new lgg[200];
			format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Id kuce %d |",GetName(playerid),GetName(id),na);
			Log(ADMIN_LOG,lgg);
		}
		else
		{
            if(PlayerInfo[id][pKucaID] != -1) return ERROR(playerid,"Igrac je vlasnik neke kuce!");
            if(KucaInfo[na][kOwned]) return ERROR(playerid,"Kuca ima vlasnika!");
            new i = na;
            KucaInfo[i][kOwned] = true;
			KucaInfo[i][kOwnerName] = RemoveUnderLine(GetName(id));
			KucaLP(i);
			KucaInfo[i][kLocked] = false;
			PlayerInfo[id][pKucaID] = na;
			SacuvajKucu(i);
			SacuvajIgraca(id);
			format(str, sizeof(str), ""zuta"Igracu %s ste podesili kuca id na %d.", GetName(id),na);
			SCM(playerid, -1, str);
			format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio kuca id na %d.", GetName(playerid),na);
			SCM(id, -1, str);
			format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Id kuce %d |", GetName(playerid),GetName(id),na);
			SendAdminMessage(str);
			new lgg[200];
			format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Id kuce %d |",GetName(playerid),GetName(id),na);
			Log(ADMIN_LOG,lgg);
		}
	}
	else if(broj == 12)
	{
		PlayerInfo[id][pDinamit] = na;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""zuta"Igracu %s ste podesili dinamit na %d.", GetName(id),na);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio dinamit na %d", GetName(playerid),na);
		SCM(id, -1, str);
		format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Dinamit %d |", GetName(playerid),GetName(id),na);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Dinamit %d |",GetName(playerid),GetName(id),na);
		Log(ADMIN_LOG,lgg);
	}
	else if(broj == 13)
	{
		if(na == -1)
	    {
	        if(PlayerInfo[id][pStanID] != -1)
	        {
	            new i = PlayerInfo[id][pStanID];
	            StanInfo[i][sOwned] = false;
				strmid(StanInfo[i][sOwnerName], "Drzava", 0, strlen("Drzava"), MAX_PLAYER_NAME);
				StanLP(i);
				StanInfo[i][sLocked] = false;
				PlayerInfo[id][pKucaID] = -1;
				SacuvajStan(i);
				SacuvajIgraca(id);
	        }
			PlayerInfo[id][pStanID] = na;
			SacuvajIgraca(id);
			format(str, sizeof(str), ""zuta"Igracu %s ste podesili stan id na %d.", GetName(id),na);
			SCM(playerid, -1, str);
			format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio stan id na %d.", GetName(playerid),na);
			SCM(id, -1, str);
			format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Id stana %d |", GetName(playerid),GetName(id),na);
			SendAdminMessage(str);
			new lgg[200];
			format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Id stana %d |",GetName(playerid),GetName(id),na);
			Log(ADMIN_LOG,lgg);
		}
		else
		{
            if(PlayerInfo[id][pStanID] != -1) return ERROR(playerid,"Igrac je vlasnik nekog stana!");
            if(StanInfo[na][sOwned]) return ERROR(playerid,"Stan ima vlasnika!");
            new i = na;
            StanInfo[i][sOwned] = true;
			StanInfo[i][sOwnerName] = RemoveUnderLine(GetName(id));
			StanLP(i);
			StanInfo[i][sLocked] = false;
			PlayerInfo[id][pStanID] = na;
			SacuvajStan(i);
			SacuvajIgraca(id);
			format(str, sizeof(str), ""zuta"Igracu %s ste podesili stan id na %d.", GetName(id),na);
			SCM(playerid, -1, str);
			format(str, sizeof(str), ""bijela"[STATS] Admin %s vam je postavio stan id na %d.", GetName(playerid),na);
			SCM(id, -1, str);
			format(str, sizeof(str), ""crvena"[STATS] "zuta"| Admin %s | Igraca %s | Id stana %d |", GetName(playerid),GetName(id),na);
			SendAdminMessage(str);
			new lgg[200];
			format(lgg,sizeof(lgg),"[STATS] | Admin %s | Igracu %s | Id stana %d |",GetName(playerid),GetName(id),na);
			Log(ADMIN_LOG,lgg);
		}
	}
	else return USAGE(playerid,"/setstats [Id/Ime][Broj][Kolicina]!");
	return 1;
}
//==============================================================================
CMD:gmduty(playerid, params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pGameMaster] == 0) return ERROR(playerid,"Niste ovlasteni!");
	if(PlayerInfo[playerid][pZatvoren]) return ERROR(playerid,"U zatvoru ste!");
	if(Radi[playerid]) return ERROR(playerid,"Radite!");
	if(GetPlayerWL(playerid) >= 1) return ERROR(playerid,"Imate wanted levele!");
    if(PolicijaDuty[playerid]) return ERROR(playerid,"Na policijskoj duznosti ste!");
    if(polaganje[playerid] != -1) return ERROR(playerid,"Polazete!");
    if(Trenira[playerid] != -1) return ERROR(playerid,"Trenirate skill!");
    if(PlayerInfo[playerid][pGameMaster] < 3) {
		if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!"); }
	new string[256];
	if(!GameMasterDuty[playerid])
	{
		format(string,sizeof(string),""zelena"(( "bijela"GameMaster %s je na duznosti "zelena"))",GetName(playerid));
		SendAdminMessage(string);
		SendGameMasterMessage(string);
		GameMasterDuty[playerid] = true;
		SetPlayerArmour(playerid, 99.0);
		SetPlayerHealth(playerid, 99.0);
	}
	else if(GameMasterDuty[playerid])
	{
		SetPlayerArmour(playerid, 0);
		SetPlayerHealth(playerid, 99.0);
		format(string,sizeof(string),""zelena"(( "bijela"GameMaster %s vise nije na duznosti "zelena"))",GetName(playerid));
		SendAdminMessage(string);
		SendGameMasterMessage(string);
		GameMasterDuty[playerid] = false;
		if(avozilo[playerid] != -1) { DestroyVehicle(avozilo[playerid]); avozilo[playerid] = -1; }
	}
	return 1;
}
//==============================================================================
CMD:askq(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new pitanje[50];
	if(sscanf(params,"s[50]",pitanje)) return USAGE(playerid,"Koristi: /askq [Pitanje]");
	new id=-1;
	for(new i=0;i<MAX_PITANJA;i++)
	{
	    if(!AskInfo[i][aUse])
	    {
			id = i;
			break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Sva pitanja su popunjena! Pokusajte kasnije.");
	AskInfo[id][aUse] = true;
	new str[50];
	format(str,sizeof(str),"%s",GetName(playerid));
	strmid(AskInfo[id][aPostavio], str, 0, strlen(str), 24);
	format(str,sizeof(str),"%s",pitanje);
	strmid(AskInfo[id][aPitanje], str, 0, strlen(str), 50);
	AskInfo[id][aPostavioID] = playerid;
	SendAdminMessage(""crvena"[PITANJE] "zuta"Imate novo pitanje! (/pitanja)");
    SendGameMasterMessage(""crvena"[PITANJE] "zelena"Imate novo pitanje! (/pitanja)");
	new str1[150];
	format(str1,sizeof(str1),""plava"Uspjesno si postavio pitanje koje glasi "bijela"%s.",pitanje);
	SCM(playerid,-1,str1);
	return 1;
}
CMD:pitaj(playerid,params[]) return cmd_askq(playerid,params);
//==============================================================================
CMD:pitanja(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
		if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		if(Pitanja[playerid] != -1) return SCM(playerid,-1,""zuta"Upisite /arefresh!");
		new str1[1000],str[200],str2[30];
		for(new i=0;i<MAX_PITANJA;i++)
		{
		    if(AskInfo[i][aUse])
		    {
		        format(str2,sizeof(str2),"%s",AskInfo[i][aPitanje]); 
		        if(strlen(AskInfo[i][aPitanje]) <= 30) {
		        	format(str,sizeof(str),""zuta"[%d] "bijela"%s[%d] ( %s )\n",i,AskInfo[i][aPostavio],AskInfo[i][aPostavioID],str2);
				}else{ format(str,sizeof(str),""zuta"[%d] "bijela"%s[%d] ( %s... )\n",i,AskInfo[i][aPostavio],AskInfo[i][aPostavioID],str2); }
				strcat(str1,str);
			}
		    else
		    {
		        format(str,sizeof(str),""zuta"[%d] "bijela"PRAZNO\n",i);
		        strcat(str1,str);
			}
		}
		ShowPlayerDialog(playerid,DIALOG_PITANJA,DIALOG_STYLE_LIST,""bijela"Pitanja:",str1,""bijela"Odgovori",""bijela"Odustani");
	}
	return 1;
}

CMD:pp(playerid,params[]) return cmd_pitanja(playerid,params);
CMD:questions(playerid,params[]) return cmd_pitanja(playerid,params);
CMD:report(playerid,params[]) return ERROR(playerid,"Trenutno ne radi! Koristite /askq");
CMD:arefresh(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
		Pitanja[playerid] = -1;
		INFO(playerid,"Vasa pitanja su osvjezena!");
	}
	else return 1;
	return 1;
}
//==============================================================================
CMD:gps(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(Radi[playerid]) return ERROR(playerid,"Radite!");
    if(GPSON[playerid]) return ERROR(playerid,"Vec imate ukljucen gps!");
    if(polaganje[playerid] != -1) return ERROR(playerid,"Imate ukljuceno polaganje!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new str[700];
	for(new i=0;i<MAX_GPS;i++)
	{
		new str1[20];
 		format(str1,sizeof(str1),GPATH,i);
		if(fexist(str1))
		{
		    format(str,sizeof(str),"%s"plava"[%d] "bijela"%s\n",str,i,GpsInfo[i][tName]);
		}
		else
		{
		    format(str,sizeof(str),"%s"plava"[%d] "crvena"NEMA\n",str,i);
		}
	}
	ShowPlayerDialog(playerid,DIALOG_GPS,DIALOG_STYLE_LIST,""plava""IME" - GPS:",str,""plava"Postavi",""plava"Odustani");
	return 1;
}
//==============================================================================
CMD:gpsoff(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(GPSON[playerid])
	{
	    DisablePlayerCheckpoint(playerid);
	    GameTextForPlayer(playerid,"~g~Iskljucili ste GPS!",3,3000);
	    GPSON[playerid] = false;
	}
	else return ERROR(playerid,"Nemate ukljucen GPS!");
	return 1;
}
//==============================================================================
CMD:kreirajgps(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new id,name[24];
	if(sscanf(params,"ds[24]",id,name)) return USAGE(playerid,"/kreirajgps [Id][Ime]");
    new str2[20];
    format(str2,sizeof(str2),GPATH,id);
	if(!fexist(str2) && id < MAX_GPS && id >= 0)
	{
	    new Float:x,Float:y,Float:z,Float:az;
	    GetPlayerPos(playerid,x,y,z);
	 	GetPlayerFacingAngle(playerid,az);
	 	GpsInfo[id][tX] = x;
	 	GpsInfo[id][tY] = y;
	 	GpsInfo[id][tZ] = z;
	 	strmid(GpsInfo[id][tName], name, 0, strlen(name), MAX_PLAYER_NAME);
	 	SacuvajGps(id);
	 	INFO(playerid,"Uspjesno ste kreirali gps!");
	}
	else
	{
	    ERROR(playerid,"Taj id se vec koristi!");
	}
	return 1;
}
//==============================================================================
CMD:izbrisigps(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new id;
	if(sscanf(params,"d",id)) return USAGE(playerid,"/izbrisigps [Id]");
    new str2[20];
    format(str2,sizeof(str2),GPATH,id);
	if(!fexist(str2))
	{
	    ERROR(playerid,"Taj id ne postoji!");
	}
	else
	{
	 	GpsInfo[id][tX] = 0.0;
	 	GpsInfo[id][tY] = 0.0;
	 	GpsInfo[id][tZ] = 0.0;
	 	strmid(GpsInfo[id][tName], "~n~", 0, strlen("~n~"), MAX_PLAYER_NAME);
	 	fremove(str2);
	}
	return 1;
}
//==============================================================================
CMD:staff(playerid, params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new id = 0, string[150],str[1000];
	format(string,sizeof(string), "\n"zelena"Admini i gamemasteri na duznosti:");
	format(string,sizeof(string), "\n"plava"Ime - ID - Level");
	format(str,sizeof(str),"%s%s",str,string);
	foreach(Player,i)
	{
	    if(IsPlayerConnected(i))
	    {
			if(PlayerInfo[i][pAdmin] >= 1 || PlayerInfo[i][pGameMaster] >= 1)
			{
			    if(PlayerInfo[i][pAdmin] >= 1 && AdminDuty[i])
				{ format(string,sizeof(string), "\n"zuta"%s - "bijela"%d - "zuta"%d - "bijela"Admin", GetName(i), i, PlayerInfo[i][pAdmin]); format(str,sizeof(str),"%s%s",str,string); }
				else if(PlayerInfo[i][pGameMaster] && GameMasterDuty[i])
				{ format(string,sizeof(string), "\n"zelena"%s - "bijela"%d - "zelena"%d - "bijela"GameMaster", GetName(i), i, PlayerInfo[i][pGameMaster]); format(str,sizeof(str),"%s%s",str,string); }
				id++;
			}
		}
	}
	if(id == 0) return ERROR(playerid,"Nema admina i gamemastera!");
	ShowPlayerDialog(playerid,DIALOG_STAFF_LISTA,DIALOG_STYLE_MSGBOX,""plava""IME" "bijela"- "zuta"Staff:",str,""bijela"Ok","");
	return 1;
}
//==============================================================================
CMD:pustipjesmu(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
   		new pjesma[126];
        if(sscanf(params,"s[126]",pjesma)) return USAGE(playerid,"/pustipjesmu [YouTube Link]");
   		new str[255];
   		format(str,sizeof(str), "http://www.youtubeinmp3.com/fetch/?video=%s",pjesma);
   		foreach(Player,i)
   		{
     	 	if(IsPlayerConnected(i))
      		{
        		PlayAudioStreamForPlayer(i,str,0.0,0.0,0.0,0,0);
      		}
   		}
   		if(PlayerInfo[playerid][pAdmin] >= 1)
   		{ format(str,sizeof(str),""zuta"Admin %s je pustio pjesmu!",GetName(playerid)); }
   		else { format(str,sizeof(str),""zelena"GameMaster %s je pustio pjesmu!",GetName(playerid)); }
   		SCMTA(-1,str);
   		if(PlayerInfo[playerid][pAdmin] >= 1)
   		{ SCMTA(-1,""zuta"Da ju iskljucite koristite '/offmusic'!"); }
   		else { SCMTA(-1,""zelena"Da ju iskljucite koristite '/offmusic'!"); }
	}
	return 1;
}
//==============================================================================
CMD:pustipjesmu2(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
   		new pjesma[126];
        if(sscanf(params,"s[126]",pjesma)) return USAGE(playerid,"/pustipjesmu2 [MP3 Link]");
   		new str[255];
   		format(str,sizeof(str), "%s",pjesma);
   		foreach(Player,i)
   		{
     	 	if(IsPlayerConnected(i))
      		{
        		PlayAudioStreamForPlayer(i,str,0.0,0.0,0.0,0,0);
      		}
   		}
   		if(PlayerInfo[playerid][pAdmin] >= 1)
   		{ format(str,sizeof(str),""zuta"Admin %s je pustio pjesmu!",GetName(playerid)); }
   		else { format(str,sizeof(str),""zelena"GameMaster %s je pustio pjesmu!",GetName(playerid)); }
   		SCMTA(-1,str);
   		if(PlayerInfo[playerid][pAdmin] >= 1)
   		{ SCMTA(-1,""zuta"Da ju iskljucite koristite '/offmusic'!"); }
   		else { SCMTA(-1,""zelena"Da ju iskljucite koristite '/offmusic'!"); }
	}
	return 1;
}
//==============================================================================
CMD:offmusic(playerid,params[])
{
	#pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	StopAudioStreamForPlayer(playerid);
	INFO(playerid,"Ugasili ste pjesmu!");
	return 1;
}
//==============================================================================
CMD:getvoziloid(playerid,params[])
{
	#pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new id = -1;
	for(new i=0;i<MAX_VEHICLES;i++)
	{
	    new Float:x, Float:y, Float:z;
     	GetVehiclePos(i, x, y, z);
    	if(IsPlayerInRangeOfPoint(playerid, 5.0, x,y,z))
    	{
    	    id = i;
    	    break;
		}
	}
	if(PlayerInfo[playerid][pAdmin] < 2) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(id == -1) return ERROR(playerid,"Niste u blizini niti jednog vozila!");
	new str[100];
	format(str,sizeof(str),""zuta"Vi ste kod vozila id "bijela"%d"zuta".",id);
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:gpvid(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		new targetid;
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "u", targetid)) return USAGE(playerid,"/gpvid [Id/Ime]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if(!IsPlayerInAnyVehicle(targetid)) return ERROR(playerid,"Igrac nije u vozilu");
		new str[150];
		format(str, sizeof(str), ""zuta"Id vozila u kojem je igrac %s je %d", GetName(targetid),GetPlayerVehicleID(targetid));
		SCM(playerid, -1, str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:rcc(playerid, params[])
{
	#pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new id = -1;
	for(new i=0;i<MAX_VEHICLES;i++)
	{
	    new Float:x, Float:y, Float:z;
     	GetVehiclePos(i, x, y, z);
    	if(IsPlayerInRangeOfPoint(playerid, 5.0, x,y,z))
    	{
    	    id = i;
    	    break;
		}
	}
	if(PlayerInfo[playerid][pAdmin] < 1) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(id == -1) return ERROR(playerid,"Niste u blizini niti jednog vozila!");
	SetVehicleToRespawn(id);
	INFO(playerid,"Respawnovali ste vozilo!");
	return 1;
}
//==============================================================================
CMD:g(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
	{
  		if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
		new msg[200];
		if(sscanf(params,"s[200]",msg)) return USAGE(playerid,"/g [Poruka]");
		new str[300];
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{ format(str, sizeof(str),""zelena"[GM] "bijela"(( "crvena"Admin %s[%d]: "bijela"%s ))",GetName(playerid),playerid,msg); }
		else if(PlayerInfo[playerid][pGameMaster] >= 1)
		{ format(str, sizeof(str),""zelena"[GM] "bijela"(( "zelena"GameMaster %s[%d]: "bijela"%s ))",GetName(playerid),playerid,msg); }
  		foreach(Player,i)
		{
	 		if((PlayerInfo[i][pAdmin] >= 1 || PlayerInfo[i][pGameMaster] >= 1) && PlayerInfo[i][pGameMasterChat])
			{
	  			SCM(i,-1,str);
			}
		}
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:vc(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pVip] >= 1)
	{
  		if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
		new msg[200];
		if(sscanf(params,"s[200]",msg)) return USAGE(playerid,"/vc [Poruka]");
		new str[300];
		if(PlayerInfo[playerid][pAdmin] >= 1)
		{ format(str, sizeof(str),""roza"[VC] "bijela"(( "crvena"Admin %s[%d]: "bijela"%s ))",GetName(playerid),playerid,msg); }
		else if(PlayerInfo[playerid][pVip] >= 1)
		{ format(str, sizeof(str),""roza"[VC] "bijela"(( "roza"Vip %s[%d]: "bijela"%s ))",GetName(playerid),playerid,msg); }
        foreach(Player,i)
        {
			if((PlayerInfo[i][pVip] >= 1 || PlayerInfo[i][pAdmin] >= 1) && PlayerInfo[playerid][pVipChat])
			{
			    SCM(i,-1,str);
			}
        }
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:setvw(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new targetid,vw;
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params,"ud",targetid,vw)) return USAGE(playerid,"/setvw [Id/ime][Virtual World]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if(InEvent[targetid]) return ERROR(playerid,"Igrac je u eventu!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		SetPlayerVirtualWorld(targetid, vw);
		new str[150];
		format(str, sizeof(str),""zuta"Admin %s vam je postavio virtual world na %d.",GetName(playerid),vw);
		SCM(targetid, -1, str);
		format(str, sizeof(str),""zuta"Igracu %s si postavio vw na %d.",GetName(targetid),vw);
		SCM(playerid, -1, str);
		format(str, sizeof(str),""crvena"[VW] "zuta"| Admin %s | Igracu %s | Na %d |",GetName(playerid),GetName(targetid),vw);
        SendAdminMessage(str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:setint(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new targetid,inte;
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params,"ud",targetid,inte)) return USAGE(playerid,"/setint [Id/ime][Interior]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if(InEvent[targetid]) return ERROR(playerid,"Igrac je u eventu!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		SetPlayerInterior(targetid, inte);
		new str[150];
		format(str, sizeof(str),""zuta"Admin %s vam je postavio interior na %d.",GetName(playerid),inte);
		SCM(targetid, -1, str);
		format(str, sizeof(str),""zuta"Igracu %s si postavio interior na %d.",GetName(targetid),inte);
		SCM(playerid, -1, str);
		format(str, sizeof(str),""crvena"[INT] "zuta"| Admin %s | Igracu %s | Na %d |",GetName(playerid),GetName(targetid),inte);
        SendAdminMessage(str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:setubizu(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new targetid,inte;
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params,"ud",targetid,inte)) return USAGE(playerid,"/setubizu [Id/ime][Id]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if(InEvent[targetid]) return ERROR(playerid,"Igrac je u eventu!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		PlayerInfo[targetid][pUbizzu] = inte;
		new str[150];
		format(str, sizeof(str),""zuta"Admin %s vam je postavio ubizzu na %d.",GetName(playerid),inte);
		SCM(targetid, -1, str);
		format(str, sizeof(str),""zuta"Igracu %s si postavio ubizzu na %d.",GetName(targetid),inte);
		SCM(playerid, -1, str);
		format(str, sizeof(str),""crvena"[U-BIZNISU] "zuta"| Admin %s | Igracu %s | Na %d |",GetName(playerid),GetName(targetid),inte);
        SendAdminMessage(str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:setukuci(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new targetid,inte;
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params,"ud",targetid,inte)) return USAGE(playerid,"/setukuci [Id/ime][Id]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if(InEvent[targetid]) return ERROR(playerid,"Igrac je u eventu!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		PlayerInfo[targetid][pUkuci] = inte;
		new str[150];
		format(str, sizeof(str),""zuta"Admin %s vam je postavio ukuci na %d.",GetName(playerid),inte);
		SCM(targetid, -1, str);
		format(str, sizeof(str),""zuta"Igracu %s si postavio ukuci na %d.",GetName(targetid),inte);
		SCM(playerid, -1, str);
		format(str, sizeof(str),""crvena"[U-KUCI] "zuta"| Admin %s | Igracu %s | Na %d |",GetName(playerid),GetName(targetid),inte);
        SendAdminMessage(str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:setustanu(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new targetid,inte;
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params,"ud",targetid,inte)) return USAGE(playerid,"/setustanu [Id/ime][Id]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if(InEvent[targetid]) return ERROR(playerid,"Igrac je u eventu!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		PlayerInfo[targetid][pUstanu] = inte;
		new str[150];
		format(str, sizeof(str),""zuta"Admin %s vam je postavio ustanu na %d.",GetName(playerid),inte);
		SCM(targetid, -1, str);
		format(str, sizeof(str),""zuta"Igracu %s si postavio ustanu na %d.",GetName(targetid),inte);
		SCM(playerid, -1, str);
		format(str, sizeof(str),""crvena"[U-STANU] "zuta"| Admin %s | Igracu %s | Na %d |",GetName(playerid),GetName(targetid),inte);
        SendAdminMessage(str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:setuorg(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new targetid,inte;
  		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params,"ud",targetid,inte)) return USAGE(playerid,"/setuorg [Id/ime][Id]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if(InEvent[targetid]) return ERROR(playerid,"Igrac je u eventu!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		PlayerInfo[targetid][pUorg] = inte;
		new str[150];
		format(str, sizeof(str),""zuta"Admin %s vam je postavio uorg na %d.",GetName(playerid),inte);
		SCM(targetid, -1, str);
		format(str, sizeof(str),""zuta"Igracu %s si postavio uorg na %d.",GetName(targetid),inte);
		SCM(playerid, -1, str);
		format(str, sizeof(str),""crvena"[U-ORG] "zuta"| Admin %s | Igracu %s | Na %d |",GetName(playerid),GetName(targetid),inte);
        SendAdminMessage(str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:aotkaz(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] < 3) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
    new targetid;
    if(sscanf(params,"u",targetid)) return USAGE(playerid,"/aotkaz [Id/ime]");
    if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
    if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
    if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
	if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
    if(PlayerInfo[targetid][pPosao] == -1) return ERROR(playerid,"Igrac nema posao!");
    if(Radi[targetid]) return ERROR(playerid,"Igrac radi!");
    if(Opremljen[targetid]) return ERROR(playerid,"Igrac ima opremu!");
    PlayerInfo[targetid][pPosao] = -1;
    PlayerInfo[targetid][pStaz] = 0;
    SacuvajIgraca(targetid);
  	INFO(playerid,"Uspjesno ste dali igracu otkaz!");
	new lgg[200];
  	format(lgg, sizeof(lgg),""crvena"[OTKAZ] "zuta"| Admin %s | Igracu %s |",GetName(playerid),GetName(targetid));
   	SendAdminMessage(lgg);
   	format(lgg, sizeof(lgg),""zuta"Admin %s vam je dao otkaz!",GetName(playerid));
   	SCM(targetid,-1,lgg);
	format(lgg,sizeof(lgg),"[OTKAZ] | Admin %s | Igracu %s |",GetName(playerid),GetName(targetid));
	Log(ADMIN_LOG,lgg);
	return 1;
}
//==============================================================================
CMD:banka(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
   	if(!IsPlayerInRangeOfPoint(playerid,2.0,655.5286,360.4723,668.6714)) return ERROR(playerid,"Niste na salteru u banci!");
   	ShowPlayerDialog(playerid,DIALOG_BANKA,DIALOG_STYLE_LIST,""zelena""IME" - Banka",""bijela"Informacije\n"zelena"Ostavi novac\n"bijela"Podigni novac\n"zelena"Otvori racun","Izaberi","Odustani");
	return 1;
}
//==============================================================================
CMD:transfer(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(!IsPlayerInRangeOfPoint(playerid,2.0,645.2234,390.9962,668.6772)) return ERROR(playerid,"Niste na salteru u banci!");
	if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate otvoreni racun u banci!");
	new targetid,money;
	if(sscanf(params,"ud",targetid,money)) return USAGE(playerid,"/transfer [Id/Ime][Kolicina novca]!");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(money < 1) return ERROR(playerid,"Ne mozete poslati manje od 1$!");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(!PlayerInfo[targetid][pBankovniRacun]) return ERROR(playerid,"Igrac nema otvoren racun u banci!");
	if(PlayerInfo[playerid][pBankMoney] < money) return ERROR(playerid,"Nemate dovoljno novca na racunu!");
	PlayerInfo[playerid][pBankMoney] -= money;
	PlayerInfo[targetid][pBankMoney] += money;
	UpdateBankaZlatoTD(playerid);
	UpdateBankaZlatoTD(targetid);
	new str[120],str1[120];
	format(str,sizeof(str),""zelena"[BANKA] "plava"Igrac %s(%d) je uplatio %d$ novca na vas bankovni racun!",GetName(playerid),playerid,money);
	SCM(targetid,-1,str);
	format(str1,sizeof(str1),""zelena"[BANKA] "plava"Uplatili ste %d$ na bankovni racun igraca %s(%d).!",money,GetName(targetid),targetid);
	SCM(playerid,-1,str1);
	SacuvajIgraca(playerid);
	SacuvajIgraca(targetid);
	return 1;
}
//==============================================================================
CMD:kredit(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pLevel] < 5) return ERROR(playerid,"Za podizanje kredita potreban vam je minimalno level 5!");
    if(!IsPlayerInRangeOfPoint(playerid,2,653.2974,390.6435,668.6772)) return ERROR(playerid,"Niste na salteru za podizanje kredita!");
    if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate otvoreni racun u banci!");
   	if(PlayerInfo[playerid][pImaKredit]) return ERROR(playerid,"Vec otplacujete kredit!");
   	ShowPlayerDialog(playerid,DIALOG_BANKA5,DIALOG_STYLE_TABLIST_HEADERS,""zelena""IME" - Banka:","Novac\tLevel\tRata\n"bijela"$50000\t"bijela"5\t"bijela"$5000\n"zelena"$1000000\t"zelena"10\t"zelena"$50000\n"bijela"$1500000\t"bijela"13\t"bijela"$100000\n"zelena"$2200000\t"zelena"20\t"zelena"$200000",""bijela"Izaberi",""bijela"Odustani");
	return 1;
}
//==============================================================================
CMD:otplatikredit(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(!IsPlayerInRangeOfPoint(playerid,2,649.3770,390.7099,668.6772 )) return ERROR(playerid,"Niste na salteru za otplacivanje kredita!");
	if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate otvoreni racun u banci!");
    if(!PlayerInfo[playerid][pImaKredit]) return ERROR(playerid,"Ne otplacujete kredit");
   	if(PlayerInfo[playerid][pMoney] < PlayerInfo[playerid][pKolicinaKredita]) return ERROR(playerid,"Nemate dovoljno novca!");
	new kredit = PlayerInfo[playerid][pKolicinaKredita];
	new lgg[200];
	format(lgg,sizeof(lgg),"[OTPLATA] | Igraca %s | Kolicina %d | Banka %d | Dzep %d |",GetName(playerid), kredit, PlayerInfo[playerid][pBankMoney],PlayerInfo[playerid][pMoney]);
	Log(KREDIT_LOG,lgg);
	GivePlayerMoney(playerid,-kredit);
	PlayerInfo[playerid][pMoney] -= kredit;
	PlayerInfo[playerid][pImaKredit] = false;
	PlayerInfo[playerid][pKolicinaKredita] = 0;
	PlayerInfo[playerid][pRataKredita] = 0;
	UpdateBankaZlatoTD(playerid);
	SacuvajIgraca(playerid);
	INFO(playerid,"Uspjesno ste otplatili kredit!");
	Aktivnost(playerid,"je otplatio kredit.");
	return 1;
}
//==============================================================================
CMD:kreirajbankomat(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] <= 5) return ERROR(playerid,"Niste ovlasteni!");
    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
    new id = -1,str[30];
    for(new i=0;i<MAX_BANKOMATA;i++)
    {
    	format(str, sizeof(str), BANKOMATPATH, i);
		if(!fexist(str)) { id = i; break; }
	}
	if(id == -1) return ERROR(playerid,"Svi moguci bankomati su kreirani!");
	new Float:x, Float:y, Float:z, Float:az;
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, az);
	BankomatInfo[id][bUse] = true;
    BankomatInfo[id][bX] = x;
	BankomatInfo[id][bY] = y;
	BankomatInfo[id][bZ] = z;
	BankomatInfo[id][bZZ] = az;
    BankomatInfo[id][bInt] = GetPlayerInterior(playerid);
	BankomatInfo[id][bVW] = GetPlayerVirtualWorld(playerid);
    KreirajBankomat(id);
	SacuvajBankomat(id);
	INFO(playerid,"Uspjesno ste kreirali bankomat da ga editujete koristite '/editbankomat'!");
    return 1;
}
//==============================================================================
CMD:editbankomat(playerid, params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] <= 5) return ERROR(playerid,"Niste ovlasteni!");
    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new id;
 	id = GetBankomatID(playerid);
 	if(id == -1) return ERROR(playerid,"Niste kod bankomata!");
	Delete3DTextLabel(BankomatInfo[id][bBankomatLabel]);
	EditujeBankomat[playerid] = id;
	EditDynamicObject(playerid,BankomatInfo[id][bObjekt]);
	return 1;
}
//==============================================================================
CMD:izbrisibankomat(playerid, params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] <= 5) return ERROR(playerid,"Niste ovlasteni!");
    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new str[30], id;
 	id = GetBankomatID(playerid);
    if(id == -1) return ERROR(playerid,"Niste kod bankomata!");
    if(EditujeBankomat[playerid] != -1) return ERROR(playerid,"Editujete bankomat!");
   	BankomatInfo[id][bUse] = false;
    BankomatInfo[id][bX] =
	BankomatInfo[id][bY] =
	BankomatInfo[id][bZ] =
	BankomatInfo[id][bXX] =
	BankomatInfo[id][bYY] =
	BankomatInfo[id][bZZ] = 0.0;
    BankomatInfo[id][bInt] = 0;
	BankomatInfo[id][bVW] = 0;
    DestroyDynamicObject(BankomatInfo[id][bObjekt]);
	Delete3DTextLabel(BankomatInfo[id][bBankomatLabel]);
	format(str, sizeof(str), BANKOMATPATH, id);
	fremove(str);
	INFO(playerid,"Uspjesno ste obrisali bankomat!");
	return 1;
}
//==============================================================================
CMD:getbankomatid(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(GetBankomatID(playerid) == -1) return ERROR(playerid,"Niste kod bankomata!");
	new str[50];
	format(str,sizeof(str),""zuta"Vi ste kod bankomata %d",GetBankomatID(playerid));
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:portdobankomata(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 1) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new id;
	if(sscanf(params,"d",id)) return USAGE(playerid,"/portdobankomata [Id]");
 	new str[50];
    format(str,sizeof(str),BANKOMATPATH,id);
	if(!fexist(str)) return ERROR(playerid,"Taj bankomat ne postoji!");
	PlayerInfo[playerid][pUbizzu] = -1;
	PlayerInfo[playerid][pUkuci] = -1;
	PlayerInfo[playerid][pUorg] = -1;
    PlayerInfo[playerid][pUstanu] = -1;
	SetPlayerVirtualWorld(playerid, BankomatInfo[id][bVW]);
	SetPlayerInterior(playerid, BankomatInfo[id][bInt]);
	SetPlayerPos(playerid,BankomatInfo[id][bX], BankomatInfo[id][bY], BankomatInfo[id][bZ]);
	Freeze(playerid);
	format(str,sizeof(str),"Portali ste se do bankomata! ID:%d",id);
	INFO(playerid,str);
	return 1;
}
//==============================================================================
CMD:bankomat(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
 	new id = GetBankomatID(playerid);
	if(id == -1) return ERROR(playerid,"Niste kod bankomata!");
	for(new i=0;i<sizeof(BankomatTD);i++) { TextDrawShowForPlayer(playerid,BankomatTD[i]); }
	SelectTextDraw(playerid, 0x000000FF);//0x7F7F7FFF);
	INFO(playerid,"Da ukljucite pokazivac misa pritisnite 'Y'.");
	return 1;
}
//==============================================================================
CMD:oprema(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(Opremljen[playerid])
	{
	    if(Radi[playerid]) return ERROR(playerid,"Radite!");
		SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
		Opremljen[playerid] = false;
		Aktivnost(playerid,"je skinuo opremu.");
		return 1;
	}
	else if(!Opremljen[playerid])
	{
	    if(IsPlayerInRangeOfPoint(playerid,2.0,JobInfo[PlayerInfo[playerid][pPosao]][jOpX],JobInfo[PlayerInfo[playerid][pPosao]][jOpY],JobInfo[PlayerInfo[playerid][pPosao]][jOpZ]))
	    {
	    	Opremljen[playerid] = true;
	    	SetPlayerSkin(playerid,JobInfo[PlayerInfo[playerid][pPosao]][jSkin]);
	    	JOB(playerid,"Uspjesno ste uzeli svoju radnu opremu i alate!");
	    	Aktivnost(playerid,"je uzeo svoju radnu opremu i alate.");
		}
		else
		{
		    ERROR(playerid,"Niste kod mjesta za uzimanje opreme!");
		    return 1;
		}
		return 1;
	}
	return 1;
}
//==============================================================================
CMD:isporuka(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(PlayerInfo[playerid][pPosao] != KAMIONDZIJA) return ERROR(playerid,"Niste kamiondzija!");
	if(Radi[playerid]) return ERROR(playerid,"Vec radite!");
    if(!Opremljen[playerid]) return ERROR(playerid,"Nemate opremu!");
    if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u kamionu!");
    if(GPSON[playerid]) return ERROR(playerid,"Imate ukljucen GPS!");
    if(polaganje[playerid] != -1) return ERROR(playerid,"Imate ukljuceno polaganje!");
    if(Trenira[playerid] != -1) return ERROR(playerid,"Trenirate skill!");
    if(AdminDuty[playerid]) return ERROR(playerid,"Ne mozete biti na admin duznosti!");
    if(GameMasterDuty[playerid]) return ERROR(playerid,"Ne mozete biti na gamemaster duznosti!");
    if(PolicijaDuty[playerid]) return ERROR(playerid,"Ne mozete biti na policijskoj duznosti!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new id = -1;
	for(new i=0;i<sizeof(Kamion);i++)
	{
	    if(GetPlayerVehicleID(playerid) == Kamion[i])
	    {
	        id = i;
			break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Niste u poslovnom kamionu!");
	if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return ERROR(playerid,"Nemate prikolicu!");
	KamiondzijaCP[playerid] = 1;
	KamiondzijaPrikolica[playerid] = 0;
	SetPlayerCheckpoint(playerid,2657.2192,-2085.1406,14.5457,4.0);
	GameTextForPlayer(playerid,"~p~Idite do mjesta za utovar!",3000,3);
	Radi[playerid] = true;
	Aktivnost(playerid,"je poceo raditi.");
	return 1;
}
//==============================================================================
CMD:gettrailerid(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(PlayerInfo[playerid][pPosao] != KAMIONDZIJA) return ERROR(playerid,"Niste kamiondzija!");
	if(!Radi[playerid]) return ERROR(playerid,"Ne radite!");
	if(KamiondzijaPrikolica[playerid] == 0) return ERROR(playerid,"Jos niste utovarili gorivo u prikolicu!");
	new str[50];
	format(str,sizeof(str),"Id vase prikolice je "roza"%d"bijela"!",KamiondzijaPrikolica[playerid]);
	JOB(playerid,str);
	return 1;
}
//==============================================================================
CMD:locatemytrailer(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(trailerlocate[playerid]) return RemovePlayerMapIcon(playerid, KAMIONDZIJA_MAP_ICON), JOB(playerid,"Uspjesno ste obrisali oznaku!"),trailerlocate[playerid] = false;
    if(PlayerInfo[playerid][pPosao] != KAMIONDZIJA) return ERROR(playerid,"Niste kamiondzija!");
	if(!Radi[playerid]) return ERROR(playerid,"Ne radite!");
	if(KamiondzijaPrikolica[playerid] == 0) return ERROR(playerid,"Jos niste utovarili gorivo u prikolicu!");
    new Float:x, Float:y, Float:z;
    GetVehiclePos(KamiondzijaPrikolica[playerid] ,x,y,z);
    SetPlayerMapIcon(playerid, KAMIONDZIJA_MAP_ICON, x,y,z, 0, 0xFF0080FF, MAPICON_GLOBAL_CHECKPOINT);
	JOB(playerid,"Vasa prikolica je oznacena rozim na mapi!");
	JOB(playerid,"Da izbrisete oznaku ponovno upisite /locatemytrailer!");
 	trailerlocate[playerid] = true;
	return 1;
}
//==============================================================================
CMD:prekiniisporuku(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(PlayerInfo[playerid][pPosao] != KAMIONDZIJA) return ERROR(playerid,"Niste kamiondzija!");
	if(!Radi[playerid]) return ERROR(playerid,"Ne radite!");
	new id = -1;
	if(KamiondzijaPrikolica[playerid] != 0)
	{
	    new bool:test = false;
		foreach(Player,i)
		{
		    if(KamiondzijaPrikolica[i] == KamiondzijaPrikolica[playerid] && playerid != i)
		    {
				test = true;
				break;
		    }
		}
		if(!test) { SetVehicleToRespawn(KamiondzijaPrikolica[playerid]); }
		KamiondzijaPrikolica[playerid] = 0;
	}
	else
	{
	    new numb = GetVehicleTrailer(GetPlayerVehicleID(playerid));
	    if(numb != 0) { SetVehicleToRespawn(numb); }
	}
	for(new i=0;i<sizeof(Kamion);i++)
	{
	    if(GetPlayerVehicleID(playerid) == Kamion[i])
	    {
	        id = i;
			break;
	    }
	}
	if(id != -1)  { SetVehicleToRespawn(Kamion[id]); }
	KamiondzijaCP[playerid] = 0;
	DisablePlayerCheckpoint(playerid);
	Radi[playerid] = false;
	TogglePlayerControllable(playerid,1);
	return 1;
}
//==============================================================================
CMD:respawntrailers(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		new str[150];
		format(str,sizeof str, ""zuta"Admin %s je respawnowao sve nekoristene prikolice!", GetName(playerid));
		SCMTA(-1, str);
		new bool:r;
		for(new i=0;i<sizeof(Prikolica);i++)
		{
		    r=false;
		    foreach(Player,p)
		    {
		        if(KamiondzijaPrikolica[p] == Prikolica[i])
		        {
		            r=true;
		        }
		    }
		    if(!r) { SetVehicleToRespawn(Prikolica[i]); }
		}
		for(new i=0;i<sizeof(FarmerPrikolica);i++)
		{
		    r=false;
		    for(new v=0;v<MAX_VEHICLES;v++)
		    {
		        if(GetVehicleTrailer(v) == FarmerPrikolica[i]) { r=true; break; }
		    }
		    if(!r) { SetVehicleToRespawn(FarmerPrikolica[i]); }
		}
    }
	else return ERROR(playerid,"Niste ovlasteni");
	return 1;
}
//==============================================================================
CMD:otkaz(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(Radi[playerid]) return ERROR(playerid,"Radite!");
    if(Opremljen[playerid]) return ERROR(playerid,"Imate opremu!");
    if(!IsPlayerInRangeOfPoint(playerid,2.0,-813.6876,1501.3594,687.2899)) return ERROR(playerid,"Niste na salteru u opstini!");
    new id = PlayerInfo[playerid][pPosao];
    if(PlayerInfo[playerid][pStaz] < JobInfo[id][jUgovor]) return ERROR(playerid,"Nemate dovoljno staza za dati otkaz!");
    PlayerInfo[playerid][pPosao] = -1;
    PlayerInfo[playerid][pStaz] = 0;
    SacuvajIgraca(playerid);
  	INFO(playerid,"Uspjesno ste dali otkaz!");
  	Aktivnost(playerid,"je dao otkaz.");
	return 1;
}
//==============================================================================
CMD:zakvaci(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(PlayerInfo[playerid][pPosao] != FARMER) return ERROR(playerid,"Niste farmer!");
	if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u traktoru!");
	if(GetVehicleTrailer(playerid) != 0) return ERROR(playerid,"Vec imate prikolicu!");
	new id;
	if(sscanf(params,"d",id)) return USAGE(playerid,"/zakvaci [Broj]");
	new stanje = 0;
	for(new i=0;i<sizeof(FarmerVozilo);i++)
	{
	    if(GetPlayerVehicleID(playerid) == FarmerVozilo[i])
	    {
			stanje = 1;
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 531)
			{
			    stanje = 2;
			    break;
			}
	    }
	}
	if(stanje == 0) return ERROR(playerid,"Niste u vozilu svog posla!");
    if(stanje == 1) return ERROR(playerid,"Niste u traktoru!");
	stanje = 0;
	for(new i=0;i<sizeof(FarmerPrikolica);i++)
	{
		if(FarmerPrikolica[i] == id)
		{
		    stanje = 1;
		    break;
		}
	}
	if(stanje == 0) return ERROR(playerid,"Pogresan broj prikolice!");
	stanje = 0;
	for(new i=0;i<MAX_VEHICLES;i++)
	{
	    if(GetVehicleTrailer(i) == id)
	    {
	        stanje = 1;
	        break;
	    }
	}
	if(stanje == 1) return ERROR(playerid,"Prikolica je zakvacena za neko vozilo!");
	new Float:x,Float:y,Float:z,Float:xx,Float:yy,Float:zz;
	GetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
	GetVehiclePos(id,xx,yy,zz);
	if(IsPointInRangeOfPoint(x,y,z,xx,yy,zz,5.0))
	{
	    AttachTrailerToVehicle(id, GetPlayerVehicleID(playerid));
	    GameTextForPlayer(playerid,"~p~Zakvaceno!",3000,3);
	}
	else
	{
		ERROR(playerid,"Niste kod te prikolice!");
		return 1;
	}
	return 1;
}
//==============================================================================
CMD:fzapocni(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(PlayerInfo[playerid][pPosao] != FARMER) return ERROR(playerid,"Niste farmer!");
	if(Radi[playerid]) return ERROR(playerid,"Vec radite!");
    if(!Opremljen[playerid]) return ERROR(playerid,"Nemate opremu!");
    if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u traktoru!");
    if(GPSON[playerid]) return ERROR(playerid,"Imate ukljucen GPS!");
    if(polaganje[playerid] != -1) return ERROR(playerid,"Imate ukljuceno polaganje!");
    if(Trenira[playerid] != -1) return ERROR(playerid,"Trenirate skill!");
    if(AdminDuty[playerid]) return ERROR(playerid,"Ne mozete biti na admin duznosti!");
    if(GameMasterDuty[playerid]) return ERROR(playerid,"Ne mozete biti na gamemaster duznosti!");
    if(PolicijaDuty[playerid]) return ERROR(playerid,"Ne mozete biti na policijskoj duznosti!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new id = -1;
	for(new i=0;i<sizeof(FarmerVozilo);i++)
	{
	    if(GetPlayerVehicleID(playerid) == FarmerVozilo[i] && GetVehicleModel(GetPlayerVehicleID(playerid)) == 531)
	    {
	        id = i;
			break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Niste u traktoru!");
	if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return ERROR(playerid,"Nemate prikolicu!");
	id = -1;
	for(new i=0;i<sizeof(FarmerPrikolica);i++)
	{
		if(FarmerPrikolica[i] == GetVehicleTrailer(GetPlayerVehicleID(playerid)))
		{
		    id = 1;
		    break;
		}
	}
	if(id == -1) return ERROR(playerid,"Nemate prikladnu prikolicu!");
	FarmerCP[playerid] = 0;
	SetPlayerCheckpoint(playerid,FarmerObjekti[0][0],FarmerObjekti[0][1],FarmerObjekti[0][2],2.0);
	GameTextForPlayer(playerid,"~p~Idite do mjesta oznacenog na karti!",3000,3);
	Radi[playerid] = true;
	FarmerState[playerid] = 1;
	Aktivnost(playerid,"je poceo raditi.");
	return 1;
}
//==============================================================================
CMD:fprekini(playerid,params[])
{
    #pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(PlayerInfo[playerid][pPosao] != FARMER) return ERROR(playerid,"Niste farmer!");
	if(!Radi[playerid]) return ERROR(playerid,"Ne radite!");
	new id = -1;
	for(new i=0;i<sizeof(FarmerVozilo);i++)
	{
	    if(GetPlayerVehicleID(playerid) == FarmerVozilo[i])
	    {
	        id = i;
			break;
	    }
	}
	if(id != -1)
	{
	    new numb = GetVehicleTrailer(FarmerVozilo[id]);
	    if(numb != 0) { SetVehicleToRespawn(numb); }
		SetVehicleToRespawn(FarmerVozilo[id]);
	}
	for(new i=0;i<sizeof(FarmerObjekti);i++)
	{
		if(IsValidPlayerObject(playerid, FarmerPlayer[playerid][i])) { DestroyPlayerObject(playerid,FarmerPlayer[playerid][i]); }
		FarmerPlayer[playerid][i] = INVALID_OBJECT_ID;
	}
	DisablePlayerCheckpoint(playerid);
	FarmerState[playerid] = 0;
	FarmerCP[playerid] = -1;
	Radi[playerid] = false;
	return 1;
}
//==============================================================================
CMD:gradevinar(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(PlayerInfo[playerid][pPosao] != GRADEVINAR) return ERROR(playerid,"Niste gradevinar!");
	if(Radi[playerid]) return ERROR(playerid,"Vec radite!");
    if(!Opremljen[playerid]) return ERROR(playerid,"Nemate opremu!");
    if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u kamionu!");
    if(GPSON[playerid]) return ERROR(playerid,"Imate ukljucen GPS!");
    if(polaganje[playerid] != -1) return ERROR(playerid,"Imate ukljuceno polaganje!");
    if(Trenira[playerid] != -1) return ERROR(playerid,"Trenirate skill!");
    if(AdminDuty[playerid]) return ERROR(playerid,"Ne mozete biti na admin duznosti!");
    if(GameMasterDuty[playerid]) return ERROR(playerid,"Ne mozete biti na gamemaster duznosti!");
    if(PolicijaDuty[playerid]) return ERROR(playerid,"Ne mozete biti na policijskoj duznosti!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new id = -1;
	for(new i=0;i<sizeof(GradevinarVozilo);i++)
	{
	    if(GetPlayerVehicleID(playerid) == GradevinarVozilo[i])
	    {
	        id = i;
			break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Niste u poslovnom kamionu!");
	if(IsValidObject(gradevinarobject[playerid])) { DestroyObject(gradevinarobject[playerid]); }
	if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][0])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][0]); }
    if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][1])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][1]); }
    if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][2])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][2]); }
	GradevinarCP[playerid] = 1;
	SetPlayerCheckpoint(playerid,-2075.7307,249.7432,35.7152,4.0);
	GameTextForPlayer(playerid,"~p~Idite po matrijal!",3000,3);
	Radi[playerid] = true;
	Aktivnost(playerid,"je poceo raditi.");
	return 1;
}
//==============================================================================
CMD:gprekini(playerid,params[])
{
    #pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(PlayerInfo[playerid][pPosao] != GRADEVINAR) return ERROR(playerid,"Niste gradevinar!");
	if(!Radi[playerid]) return ERROR(playerid,"Ne radite!");
	new id = -1;
	for(new i=0;i<sizeof(GradevinarVozilo);i++)
	{
	    if(GetPlayerVehicleID(playerid) == GradevinarVozilo[i])
	    {
	        id = i;
			break;
	    }
	}
	if(id != -1) { SetVehicleToRespawn(GradevinarVozilo[id]); }
	DisablePlayerCheckpoint(playerid);
	TogglePlayerControllable(playerid,1);
	GradevinarCP[playerid] = 0;
	if(IsValidObject(gradevinarobject[playerid])) { DestroyObject(gradevinarobject[playerid]); }
	if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][0])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][0]); }
    if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][1])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][1]); }
    if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][2])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][2]); }
	Radi[playerid] = false;
	return 1;
}
//==============================================================================
CMD:kopajzlato(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(PlayerInfo[playerid][pPosao] != RUDAR) return ERROR(playerid,"Niste rudar!");
	if(Radi[playerid]) return ERROR(playerid,"Vec radite!");
    if(!Opremljen[playerid]) return ERROR(playerid,"Nemate opremu!");
    if(GPSON[playerid]) return ERROR(playerid,"Imate ukljucen GPS!");
    if(polaganje[playerid] != -1) return ERROR(playerid,"Imate ukljuceno polaganje!");
    if(Trenira[playerid] != -1) return ERROR(playerid,"Trenirate skill!");
    if(AdminDuty[playerid]) return ERROR(playerid,"Ne mozete biti na admin duznosti!");
    if(GameMasterDuty[playerid]) return ERROR(playerid,"Ne mozete biti na gamemaster duznosti!");
    if(PolicijaDuty[playerid]) return ERROR(playerid,"Ne mozete biti na policijskoj duznosti!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	RudarCP[playerid] = 1;
	Kopanje[playerid] = 0;
	if(IsPlayerAttachedObjectSlotUsed(playerid, RUDAR_SLOT)) { RemovePlayerAttachedObject(playerid, RUDAR_SLOT); }
	SetPlayerCheckpoint(playerid,600.9047,817.0106,-39.7112,5.0);
	GameTextForPlayer(playerid,"~p~Idite do mjesta za kopanje!",3000,3);
	Radi[playerid] = true;
	Aktivnost(playerid,"je poceo raditi.");
	return 1;
}
//==============================================================================
CMD:prekinikopanje(playerid,params[])
{
    #pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(PlayerInfo[playerid][pPosao] != RUDAR) return ERROR(playerid,"Niste rudar!");
	if(!Radi[playerid]) return ERROR(playerid,"Ne radite!");
	DisablePlayerCheckpoint(playerid);
	TogglePlayerControllable(playerid,1);
	RudarCP[playerid] = 0;
	Kopanje[playerid] = 0;
	if(IsPlayerAttachedObjectSlotUsed(playerid, RUDAR_SLOT)) { RemovePlayerAttachedObject(playerid, RUDAR_SLOT); }
	KillTimer(RudarTimer[playerid]);
	ClearAnimations(playerid);
	Radi[playerid] = false;
	return 1;
}
//==============================================================================
CMD:zavari(playerid,params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(PlayerInfo[playerid][pPosao] != ZAVARIVAC) return ERROR(playerid,"Niste zavarivac!");
    if(!Opremljen[playerid]) return ERROR(playerid,"Nemate opremu!");
    if(GPSON[playerid]) return ERROR(playerid,"Imate ukljucen GPS!");
    if(polaganje[playerid] != -1) return ERROR(playerid,"Imate ukljuceno polaganje!");
    if(Trenira[playerid] != -1) return ERROR(playerid,"Trenirate skill!");
    if(AdminDuty[playerid]) return ERROR(playerid,"Ne mozete biti na admin duznosti!");
    if(GameMasterDuty[playerid]) return ERROR(playerid,"Ne mozete biti na gamemaster duznosti!");
    if(PolicijaDuty[playerid]) return ERROR(playerid,"Ne mozete biti na policijskoj duznosti!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
    if(!Radi[playerid]) { ZavarivacCP[playerid] = 1; }
	if(ZavarivacCP[playerid] == 1 && IsPlayerInRangeOfPoint(playerid,2.0,1314.9347,-1346.1732,18.9857))
	{
	    if(Radi[playerid]) return ERROR(playerid,"Vec radis!"), ZavarivacCP[playerid] = 0;
		GameTextForPlayer(playerid,"~p~Varenje 0/6",1000,3);
		Zavarivac[playerid] = 0;
		ZavarivacTimer[playerid] = SetTimerEx("ztimer",1000,true,"d",playerid);
		TogglePlayerControllable(playerid,0);
		SetPlayerFacingAngle(playerid,91.2550);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 0, 0, 1, 1, 999, 1);
		Radi[playerid] = true;
		SetPlayerAttachedObject( playerid, ZAVARIVAC_SLOT, 18633, 6, 0.073002, 0.024260, -0.002843, 98.544425, 271.248077, 0.000000, 1.000000, 1.000000, 1.000000 );
		SetPlayerAttachedObject( playerid, ZAVARIVAC1_SLOT, 18718, 6, 0.067487, -0.001904, -1.329238, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
		Aktivnost(playerid,"je poceo raditi.");
	}
	else if(ZavarivacCP[playerid] == 2 && IsPlayerInRangeOfPoint(playerid,2.0,1299.1201,-1358.0764,18.9857))
	{
		GameTextForPlayer(playerid,"~p~Varenje 0/6",1000,3);
		Zavarivac[playerid] = 0;
		ZavarivacTimer[playerid] = SetTimerEx("ztimer",1000,true,"d",playerid);
		TogglePlayerControllable(playerid,0);
		SetPlayerFacingAngle(playerid,89.9782);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 0, 0, 1, 1, 999, 1);
		SetPlayerAttachedObject( playerid, ZAVARIVAC_SLOT, 18633, 6, 0.073002, 0.024260, -0.002843, 98.544425, 271.248077, 0.000000, 1.000000, 1.000000, 1.000000 );
		SetPlayerAttachedObject( playerid, ZAVARIVAC1_SLOT, 18718, 6, 0.067487, -0.001904, -1.329238, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	}
	else if(ZavarivacCP[playerid] == 3 && IsPlayerInRangeOfPoint(playerid,2.0,1298.4414,-1370.8756,18.9857))
	{
		GameTextForPlayer(playerid,"~p~Varenje 0/6",1000,3);
		Zavarivac[playerid] = 0;
		ZavarivacTimer[playerid] = SetTimerEx("ztimer",1000,true,"d",playerid);
		TogglePlayerControllable(playerid,0);
		SetPlayerFacingAngle(playerid,89.3281);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 0, 0, 1, 1, 999, 1);
		SetPlayerAttachedObject( playerid, ZAVARIVAC_SLOT, 18633, 6, 0.073002, 0.024260, -0.002843, 98.544425, 271.248077, 0.000000, 1.000000, 1.000000, 1.000000 );
		SetPlayerAttachedObject( playerid, ZAVARIVAC1_SLOT, 18718, 6, 0.067487, -0.001904, -1.329238, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	}
	else if(ZavarivacCP[playerid] == 4 && IsPlayerInRangeOfPoint(playerid,2.0,1298.0878,-1383.3872,18.9857))
	{
		GameTextForPlayer(playerid,"~p~Varenje 0/6",1000,3);
		Zavarivac[playerid] = 0;
		ZavarivacTimer[playerid] = SetTimerEx("ztimer",1000,true,"d",playerid);
		TogglePlayerControllable(playerid,0);
		SetPlayerFacingAngle(playerid,88.6780);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 0, 0, 1, 1, 999, 1);
		SetPlayerAttachedObject( playerid, ZAVARIVAC_SLOT, 18633, 6, 0.073002, 0.024260, -0.002843, 98.544425, 271.248077, 0.000000, 1.000000, 1.000000, 1.000000 );
		SetPlayerAttachedObject( playerid, ZAVARIVAC1_SLOT, 18718, 6, 0.067487, -0.001904, -1.329238, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	}
	return 1;
}
//==============================================================================
CMD:prekinivarenje(playerid,params[])
{
    #pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pPosao] == -1) return ERROR(playerid,"Nemate posao!");
    if(PlayerInfo[playerid][pPosao] != ZAVARIVAC) return ERROR(playerid,"Niste rudar!");
	if(!Radi[playerid]) return ERROR(playerid,"Ne radite!");
	DisablePlayerCheckpoint(playerid);
	TogglePlayerControllable(playerid,1);
	ZavarivacCP[playerid] = 0;
	Zavarivac[playerid] = 0;
	if(IsPlayerAttachedObjectSlotUsed(playerid, ZAVARIVAC_SLOT)) { RemovePlayerAttachedObject(playerid, ZAVARIVAC_SLOT); }
	if(IsPlayerAttachedObjectSlotUsed(playerid, ZAVARIVAC1_SLOT)) { RemovePlayerAttachedObject(playerid, ZAVARIVAC1_SLOT); }
	KillTimer(ZavarivacTimer[playerid]);
	ClearAnimations(playerid);
	Radi[playerid] = false;
	return 1;
}
//==============================================================================
CMD:poslovi(playerid,params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(Radi[playerid]) return ERROR(playerid,"Radite!");
    if(GPSON[playerid]) return ERROR(playerid,"Imate ukljucen GPS!");
    if(polaganje[playerid] != -1) return ERROR(playerid,"Imate ukljuceno polaganje!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
    if(!IsPlayerInRangeOfPoint(playerid,2.0,-819.5416,1501.3571,687.2899)) return ERROR(playerid,"Niste na salteru u opstini!");
	new str[200],str1[200];
	format(str,sizeof(str),""roza"Ime\t"roza"Level\n");
	for(new i=0;i<MAX_JOBS;i++)
	{
		format(str1,sizeof(str1),"%s\t%d\n",JobInfo[i][jName],JobInfo[i][jLevel]);
		strcat(str,str1);
	}
	ShowPlayerDialog(playerid, DIALOG_POSLOVI, DIALOG_STYLE_TABLIST_HEADERS, ""roza""IME" - Lista poslova",str,"Oznaci", "Odustani");
	Aktivnost(playerid,"gleda listu poslova.");
	return 1;
}
//==============================================================================
CMD:kreirajkucu(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] <= 5) return ERROR(playerid,"Niste ovlasteni!");
    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new vrsta;
	if(sscanf(params,"d",vrsta))
	{
		USAGE(playerid,"/kreirajkucu [vrsta]");
		INFO(playerid,"Vrste: 0:Mala | 1:Srednja | 2:Velika | 3:Villa");
		return 1;
	}
	if(vrsta < 0 || vrsta > 3) return ERROR(playerid,"Pogresna vrsta!");
    new id = -1;
	for(new i=0;i<MAX_KUCA;i++)
	{
	    new str11[20];
	    format(str11,sizeof(str11),KPATH,i);
	    if(!fexist(str11))
	    {
	        id = i;
	        break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Kreirali ste previse kuca!");
	KucaInfo[id][kOwned] = false;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	KucaInfo[id][kUlazX] = x;
	KucaInfo[id][kUlazY] = y;
	KucaInfo[id][kUlazZ] = z;
	KucaInfo[id][kVW] = id;
	KucaInfo[id][kMoney] = 0;
	KucaInfo[id][kOruzje][0] = -1;
	KucaInfo[id][kMunicija][0] = 0;
	KucaInfo[id][kOruzje][1] = -1;
	KucaInfo[id][kMunicija][1] = 0;
	KucaInfo[id][kOruzje][2] = -1;
	KucaInfo[id][kMunicija][2] = 0;
	KucaInfo[id][kDroga] = 0;
	KucaInfo[id][kMats] = 0;
	KucaInfo[id][kLocked] = true;
	new str[MAX_PLAYER_NAME];
    if(vrsta == 0)
	{
    	KucaInfo[id][kIzlazX] = 271.884979;
		KucaInfo[id][kIzlazY] = 306.631988;
		KucaInfo[id][kIzlazZ] = 999.148437;
		KucaInfo[id][kInterior] = 2;
		format(str,sizeof(str),"Mala kuca");
		strmid(KucaInfo[id][kName], str, 0, strlen(str), MAX_PLAYER_NAME);
		KucaInfo[id][kVrsta] = 0;
		KucaInfo[id][kLevel] = 2;
		KucaInfo[id][kPrice] = 450000;
	}
	else if(vrsta == 1)
	{
    	KucaInfo[id][kIzlazX] = 318.564971;
		KucaInfo[id][kIzlazY] = 1118.209960;
		KucaInfo[id][kIzlazZ] = 1083.882812;
		KucaInfo[id][kInterior] = 5;
		format(str,sizeof(str),"Srednja kuca");
		strmid(KucaInfo[id][kName], str, 0, strlen(str), MAX_PLAYER_NAME);
		KucaInfo[id][kVrsta] = 1;
		KucaInfo[id][kLevel] = 5;
		KucaInfo[id][kPrice] = 900000;
	}
	else if(vrsta == 2)
	{
    	KucaInfo[id][kIzlazX] = 2324.419921;
		KucaInfo[id][kIzlazY] = -1145.568359;
		KucaInfo[id][kIzlazZ] = 1050.710083;
		KucaInfo[id][kInterior] = 12;
		format(str,sizeof(str),"Velika kuca");
		strmid(KucaInfo[id][kName], str, 0, strlen(str), MAX_PLAYER_NAME);
		KucaInfo[id][kVrsta] = 2;
		KucaInfo[id][kLevel] = 9;
		KucaInfo[id][kPrice] = 2000000;
	}
    else if(vrsta == 3)
	{
    	KucaInfo[id][kIzlazX] = 2496.049804;
		KucaInfo[id][kIzlazY] = -1695.238159;
		KucaInfo[id][kIzlazZ] = 1014.742187;
		KucaInfo[id][kInterior] = 3;
		format(str,sizeof(str),"Villa");
		strmid(KucaInfo[id][kName], str, 0, strlen(str), MAX_PLAYER_NAME);
		KucaInfo[id][kVrsta] = 3;
		KucaInfo[id][kLevel] = 12;
		KucaInfo[id][kPrice] = 3500000;
	}

	new str3[200];
    format(str3,sizeof(str3),""zelena"Kuca na prodaju!\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\nVrsta: %s\n"zelena"Da kupite kucu upisite "bijela"'/kupikucu'",KucaInfo[id][kName],KucaInfo[id][kLevel],KucaInfo[id][kPrice],VrstaKuce(id));
	kText[id] = Create3DTextLabel(str3, -1, KucaInfo[id][kUlazX], KucaInfo[id][kUlazY], KucaInfo[id][kUlazZ], 20.0, 0, 0);
	KucaInfo[id][kUnutraPic] = CreateDynamicPickup(1239, 1, KucaInfo[id][kIzlazX], KucaInfo[id][kIzlazY], KucaInfo[id][kIzlazZ], KucaInfo[id][kVW]);
	KucaInfo[id][kIzvanPic] = CreateDynamicPickup(1273, 1, KucaInfo[id][kUlazX], KucaInfo[id][kUlazY], KucaInfo[id][kUlazZ], -1);
	SacuvajKucu(id);
	return 1;
}
//==============================================================================
CMD:kreirajkucuex(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] <= 5) return ERROR(playerid,"Niste ovlasteni!");
    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new level,price,vrsta;
	if(sscanf(params,"ddd",level,price,vrsta))
	{
		USAGE(playerid,"/kreirajkucuex [level][cijena][vrsta]");
		INFO(playerid,"Vrste: 0:Mala | 1:Srednja | 2:Velika | 3:Villa");
		return 1;
	}
	if(price < 1 || level < 1) return ERROR(playerid,"Cijena ili level nesmiju biti manji od 1!");
	if(vrsta < 0 || vrsta > 3) return 1;
    new id = -1;
	for(new i=0;i<MAX_KUCA;i++)
	{
	    new str11[20];
	    format(str11,sizeof(str11),KPATH,i);
	    if(!fexist(str11))
	    {
	        id = i;
	        break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Kreirali ste previse kuca!");
	KucaInfo[id][kOwned] = false;
	KucaInfo[id][kLevel] = level;
	KucaInfo[id][kPrice] = price;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	KucaInfo[id][kUlazX] = x;
	KucaInfo[id][kUlazY] = y;
	KucaInfo[id][kUlazZ] = z;
	KucaInfo[id][kVW] = id;
	KucaInfo[id][kMoney] = 0;
	KucaInfo[id][kOruzje][0] = -1;
	KucaInfo[id][kMunicija][0] = 0;
	KucaInfo[id][kOruzje][1] = -1;
	KucaInfo[id][kMunicija][1] = 0;
	KucaInfo[id][kOruzje][2] = -1;
	KucaInfo[id][kMunicija][2] = 0;
	KucaInfo[id][kDroga] = 0;
	KucaInfo[id][kMats] = 0;
	KucaInfo[id][kLocked] = true;
	new str[MAX_PLAYER_NAME];
    if(vrsta == 0)
	{
    	KucaInfo[id][kIzlazX] = 271.884979;
		KucaInfo[id][kIzlazY] = 306.631988;
		KucaInfo[id][kIzlazZ] = 999.148437;
		KucaInfo[id][kInterior] = 2;
		format(str,sizeof(str),"Mala kuca");
		strmid(KucaInfo[id][kName], str, 0, strlen(str), MAX_PLAYER_NAME);
		KucaInfo[id][kVrsta] = 0;
	}
	else if(vrsta == 1)
	{
    	KucaInfo[id][kIzlazX] = 318.564971;
		KucaInfo[id][kIzlazY] = 1118.209960;
		KucaInfo[id][kIzlazZ] = 1083.882812;
		KucaInfo[id][kInterior] = 5;
		format(str,sizeof(str),"Srednja kuca");
		strmid(KucaInfo[id][kName], str, 0, strlen(str), MAX_PLAYER_NAME);
		KucaInfo[id][kVrsta] = 1;
	}
	else if(vrsta == 2)
	{
    	KucaInfo[id][kIzlazX] = 2324.419921;
		KucaInfo[id][kIzlazY] = -1145.568359;
		KucaInfo[id][kIzlazZ] = 1050.710083;
		KucaInfo[id][kInterior] = 12;
		format(str,sizeof(str),"Velika kuca");
		strmid(KucaInfo[id][kName], str, 0, strlen(str), MAX_PLAYER_NAME);
		KucaInfo[id][kVrsta] = 2;
	}
    else if(vrsta == 3)
	{
    	KucaInfo[id][kIzlazX] = 2496.049804;
		KucaInfo[id][kIzlazY] = -1695.238159;
		KucaInfo[id][kIzlazZ] = 1014.742187;
		KucaInfo[id][kInterior] = 3;
		format(str,sizeof(str),"Villa");
		strmid(KucaInfo[id][kName], str, 0, strlen(str), MAX_PLAYER_NAME);
		KucaInfo[id][kVrsta] = 3;
	}

	new str3[200];
    format(str3,sizeof(str3),""zelena"Kuca na prodaju!\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\nVrsta: %s\n"zelena"Da kupite kucu upisite "bijela"'/kupikucu'",KucaInfo[id][kName],KucaInfo[id][kLevel],KucaInfo[id][kPrice],VrstaKuce(id));
	kText[id] = Create3DTextLabel(str3, -1, KucaInfo[id][kUlazX], KucaInfo[id][kUlazY], KucaInfo[id][kUlazZ], 20.0, 0, 0);
	KucaInfo[id][kUnutraPic] = CreateDynamicPickup(1239, 1, KucaInfo[id][kIzlazX], KucaInfo[id][kIzlazY], KucaInfo[id][kIzlazZ], KucaInfo[id][kVW]);
	KucaInfo[id][kIzvanPic] = CreateDynamicPickup(1273, 1, KucaInfo[id][kUlazX], KucaInfo[id][kUlazY], KucaInfo[id][kUlazZ], -1);
	SacuvajKucu(id);
	return 1;
}
//==============================================================================
CMD:kupikucu(playerid,params[])
{
    #pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pKucaID] != -1) return ERROR(playerid,"Vec ste vlasnik neke kuce!");
	new id = GetKuca(playerid);
	if(id == -1) return ERROR(playerid,"Niste u blizni kuce!");
	if(KucaInfo[id][kOwned]) return ERROR(playerid,"Ova kuca nije na prodaju!");
	if(GetPlayerMoney(playerid) < KucaInfo[id][kPrice]) return ERROR(playerid,"Nemate dovoljno novca!");
	if(PlayerInfo[playerid][pLevel] < KucaInfo[id][kLevel]) return ERROR(playerid,"Nemate dovoljan level!");
	KucaInfo[id][kOwned] = true;
	KucaInfo[id][kOwnerName] = RemoveUnderLine(GetName(playerid));
	KucaLP(id);
	KucaInfo[id][kLocked] = true;
	PlayerInfo[playerid][pMoney] -= KucaInfo[id][kPrice];
	GivePlayerMoney(playerid,-KucaInfo[id][kPrice]);
	PlayerInfo[playerid][pKucaID] = id;
	SacuvajKucu(id);
	SacuvajIgraca(playerid);
	ClearChat(playerid);
	INFO(playerid,"Uspjesno ste kupili kucu!");
	INFO(playerid,"Za upravljanje kucom koristite "zuta"'/kuca'");
	return 1;
}
//==============================================================================
CMD:kuca(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pKucaID] == -1) return ERROR(playerid,"Nemate kucu!");
	if(PlayerInfo[playerid][pKucaID] != GetKuca(playerid)) return ERROR(playerid,"Nisi kod svoje kuce!");
	ShowPlayerDialog(playerid,DIALOG_KUCA,DIALOG_STYLE_LIST,""zelena""IME" - Kuca:",""zelena"Otkljucaj"bijela"/"crvena"Zakljucaj\n"bijela"Prodaj drzavi\n"zelena"Informacije\n"bijela"Promijeni ime\n"zelena"Ostavi/uzmi","Izaberi","Odustani");
    Aktivnost(playerid,"upravlja kucom.");
	return 1;
}
//==============================================================================
CMD:izbrisikucu(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new id;
	if(sscanf(params,"d",id)) return USAGE(playerid,"/izbrisikucu [Id]");
    new str2[20];
    format(str2,sizeof(str2),KPATH,id);
	if(!fexist(str2))
	{
	    ERROR(playerid,"Ta kuca ne postoji!");
	}
	else
	{
	 	KucaInfo[id][kOwned] = false;
	 	KucaInfo[id][kUlazX] = 0.0;
		KucaInfo[id][kUlazY] = 0.0;
		KucaInfo[id][kUlazZ] = 0.0;
		KucaInfo[id][kVW] = 0;
		KucaInfo[id][kIzlazX] = 0.0;
		KucaInfo[id][kIzlazY] = 0.0;
		KucaInfo[id][kIzlazZ] = 0.0;
		KucaInfo[id][kInterior] = 0;
		strmid(KucaInfo[id][kName], "~n~", 0, strlen("~n~"), MAX_PLAYER_NAME);
		KucaInfo[id][kVrsta] = 0;
		KucaInfo[id][kLevel] = 0;
		KucaInfo[id][kPrice] = 0;
		KucaInfo[id][kMoney] = 0;
		KucaInfo[id][kOruzje][0] = -1;
		KucaInfo[id][kMunicija][0] = 0;
		KucaInfo[id][kOruzje][1] = -1;
		KucaInfo[id][kMunicija][1] = 0;
		KucaInfo[id][kOruzje][2] = -1;
		KucaInfo[id][kMunicija][2] = 0;
		KucaInfo[id][kDroga] = 0;
		KucaInfo[id][kMats] = 0;
		DestroyDynamicPickup(KucaInfo[id][kUnutraPic]);
		DestroyDynamicPickup(KucaInfo[id][kIzvanPic]);
		Delete3DTextLabel(kText[id]);
	 	fremove(str2);
	 	INFO(playerid,"Uspjesno ste obrisali kucu!");
	}
	return 1;
}
//==============================================================================
CMD:getkucaid(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(GetKuca(playerid) == -1) return ERROR(playerid,"Niste kod ulaza u niti jednu kucu!");
	new str[50];
	format(str,sizeof(str),""zuta"Vi ste kod kuce %d",GetKuca(playerid));
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:portdokuce(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 1) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new id;
	if(sscanf(params,"d",id)) return USAGE(playerid,"/portdokuce [Id]");
 	new str[50];
    format(str,sizeof(str),KPATH,id);
	if(!fexist(str)) return ERROR(playerid,"Ta kuca ne postoji!");
	PlayerInfo[playerid][pUkuci] = -1;
	PlayerInfo[playerid][pUbizzu] = -1;
	PlayerInfo[playerid][pUorg] = -1;
	PlayerInfo[playerid][pUstanu] = -1;
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid,KucaInfo[id][kUlazX], KucaInfo[id][kUlazY], KucaInfo[id][kUlazZ]);
	Freeze(playerid);
	format(str,sizeof(str),""zuta"Portali ste se do kuce! ID:%d",id);
	INFO(playerid,str);
	return 1;
}
//==============================================================================
CMD:smoke(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pCigarete] <= 0) return ERROR(playerid,"Nemate cigaretu!");
	if(PlayerInfo[playerid][pUpaljac] <= 0) return ERROR(playerid,"Nemate upaljac!");
	new rand = random(4);
	if(rand == 0)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
		Aktivnost(playerid,"je zapalio cigaretu.");
		PlayerInfo[playerid][pCigarete]--;
	}
	else if(rand == 1)
	{
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
		Aktivnost(playerid,"je zapalio cigaretu.");
		PlayerInfo[playerid][pCigarete]--;
	}
	else if(rand == 2)
	{
		ERROR(playerid,"Istrosio vam se upaljac.");
		PlayerInfo[playerid][pUpaljac]--;
	}
	else
	{
		Aktivnost(playerid,"ne uspjeva zapaliti cigaretu.");
	}
	return 1;
}
//==============================================================================
CMD:kupi(playerid,params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pUbizzu] == -1) return ERROR(playerid,"Niste u biznisu!");
    if(BiznisInfo[PlayerInfo[playerid][pUbizzu]][bVrsta] == SHOP)
   	{
		new str[300],str1[100];
		format(str1,sizeof(str1),""siva"Proizvod\t"siva"Cijena\n");
		strcat(str,str1);
		for(new i=0;i<sizeof(ShopInfo);i++)
		{
			format(str1,sizeof(str1),"%s\t%d$\n",ShopInfo[i][sName],ShopInfo[i][sPrice]);
			strcat(str,str1);
		}
		ShowPlayerDialog(playerid,DIALOG_SHOP,DIALOG_STYLE_TABLIST_HEADERS,""plava""IME" - Shop",str,"Kupi","Odustani");
	}
    else if(BiznisInfo[PlayerInfo[playerid][pUbizzu]][bVrsta] == SEX_SHOP)
   	{
   	    ShowPlayerDialog(playerid, DIALOG_SEX_SHOP, DIALOG_STYLE_TABLIST_HEADERS, ""plava""IME" - Sex Shop", ""siva"Proizvod\t"siva"Cijena\n"bijela"Sivi vibrator\t"bijela"1000$\n"siva"Bijeli vibrator\t"siva"1100$\n"bijela"Ljubicasti vibrator\t"bijela"1500$", "Kupi", "Odustani");
   	}
   	else if(BiznisInfo[PlayerInfo[playerid][pUbizzu]][bVrsta] == AMMUNATION)
   	{
		if(!PlayerInfo[playerid][pOruzjeDozvola]) return ERROR(playerid,"Nemate dozvolu za oruzje!");
   	    ShowPlayerDialog(playerid, DIALOG_AMMUNATION, DIALOG_STYLE_PREVIEW_MODEL, "~b~"IME" - Ammunation","335\tKnife - 100$\n336\tBaseball bat - 300$\n349\tShootgun - 40000$\n348\tDesert - 20000$\n356\tM4 - 50000$\n358\tSniper - 100000$\n371\tPadobran - 500$", "Kupi", "Odustani");
   	}
   	else if(BiznisInfo[PlayerInfo[playerid][pUbizzu]][bVrsta] == BINCO)
   	{
   	    if(Opremljen[playerid]) return ERROR(playerid,"Skinite opremu prvo!");
   	    new str[500];
   	    for(new i=0;i<sizeof(SkinInfo);i++)
   	    {
   	        format(str,sizeof(str),"%s%d\t%d$\n",str,SkinInfo[i][sID],SkinInfo[i][sPrice]);
   	    }
   	    ShowPlayerDialog(playerid, DIALOG_BINCO, DIALOG_STYLE_PREVIEW_MODEL, "~b~"IME" - Shop",str, "Kupi", "Odustani");
   	}
   	else if(BiznisInfo[PlayerInfo[playerid][pUbizzu]][bVrsta] == BAR || BiznisInfo[PlayerInfo[playerid][pUbizzu]][bVrsta] == DISCO)
	{
		new str[350];
  		format(str, sizeof(str), ""siva"Pice\t"siva"Cijena\n"bijela"Pivo\t100$\n"siva"Vino\t"siva"150$\n"bijela"Viski\t300$\n"siva"Votka\t"siva"25$\n"bijela"Voda\t0$\n"siva"Sok\t"siva"2$");
	    ShowPlayerDialog(playerid,DIALOG_BAR,DIALOG_STYLE_TABLIST_HEADERS,""plava""IME" - Bar",str,"Kupi","Odustani");
	}
	else if(BiznisInfo[PlayerInfo[playerid][pUbizzu]][bVrsta] == PIZZA)
	{
		new str[350];
  		format(str, sizeof(str), ""siva"Hrana\t"siva"Cijena\n"bijela"Hamburger\t50$\n"siva"Pizza\t"siva"100$\n"bijela"Sendvic\t40$\n"siva"Pohana piletina\t"siva"100$\n"bijela"Svinjetina\t120$\n"siva"Janjetina\t"siva"15$");
	    ShowPlayerDialog(playerid,DIALOG_PIZZA,DIALOG_STYLE_TABLIST_HEADERS,""plava""IME" - Pizza",str,"Kupi","Odustani");
	}
 	return 1;
}
//==============================================================================
CMD:kladionica(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pUbizzu] == -1) return ERROR(playerid,"Niste u biznisu!");
    if(BiznisInfo[PlayerInfo[playerid][pUbizzu]][bVrsta] != KLADIONICA) return  ERROR(playerid,"Niste u kladionici!");
	new broj, brojk = random(50), string[128];
 	if(sscanf(params, "i",broj)) return USAGE(playerid,"/kladionica [Broj od 0 do 50]");
	if(broj > 50) return  ERROR(playerid,"Maximun 50!");
    if(broj < 0) return  ERROR(playerid,"Nemozes toliko!");
	if(GetPlayerMoney(playerid) >= 100 || PlayerInfo[playerid][pBankMoney] >= 100)
	{
		Placanje(playerid,PlayerInfo[playerid][pUbizzu],100);
	}
	else return ERROR(playerid,"Nemate dovoljno novca!");
 	if(broj == brojk)
 	{
 	    new dobitak = 10000+random(10000);
		format(string,sizeof(string),""siva"[KLADIONICA] "zelena"Cestitamo osvojili ste %d$!",dobitak);
		SCM(playerid,-1,string);
		GivePlayerMoney(playerid,dobitak);
		PlayerInfo[playerid][pMoney] += dobitak;
		return 1;
	}
	else { BiznisNovac(PlayerInfo[playerid][pUbizzu],100); }
	SCM(playerid,-1,""siva"[KLADIONICA] "bijela"Zao nam je niste osvojili nista.");
  	return 1;
}
//==============================================================================
CMD:uplati(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pUbizzu] == -1) return ERROR(playerid,"Niste u biznisu!");
    if(BiznisInfo[PlayerInfo[playerid][pUbizzu]][bVrsta] != POSTA) return  ERROR(playerid,"Niste u posti!");
	new type;
	if(sscanf(params,"d",type)) return USAGE(playerid,"/uplati [Vrsta]!"),INFO(playerid,"Vrste: 1: Na svoj bankovni racun (30$) | 2:  Na racun nekog igraca (50$).");
	if(type == 1)
	{
	    if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate banokvni racun!");
	    new money;
	    if(sscanf(params,"dd",type,money)) return USAGE(playerid,"/uplati [Vrsta][Novac]!"),INFO(playerid,"Vrste: 1: Na svoj bankovni racun | 2:  Na racun nekog igraca.");
	    if(money < 1) return ERROR(playerid,"Upisali ste pogresnu kolicinu!");
		if(money+30 > PlayerInfo[playerid][pMoney]) return ERROR(playerid,"Nemate dovoljno novca!");
		PlayerInfo[playerid][pBankMoney] += money;
  		PlayerInfo[playerid][pMoney] -= money;
  		UpdateBankaZlatoTD(playerid);
		GivePlayerMoney(playerid,-money);
		SCM(playerid,-1,""siva"[POSTA] "bijela"Uspjesno ste uplatili novac na svoj bankovni racun!");
		PlayerInfo[playerid][pMoney] -= 30;
		GivePlayerMoney(playerid,-30);
		BiznisNovac(PlayerInfo[playerid][pUbizzu],30);
		SacuvajIgraca(playerid);
	}
	else if(type == 2)
	{
	    new money,id;
	    if(sscanf(params,"ddu",type,money,id)) return USAGE(playerid,"/uplati [Vrsta][Novac][Id/Ime]!"),INFO(playerid,"Vrste: 1: Na svoj bankovni racun | 2:  Na racun nekog igraca.");
        if(!IsPlayerConnected(id)) return ERROR(playerid,"Igrac nije u igri!");
		if(money < 1) return ERROR(playerid,"Upisali ste pogresnu kolicinu!");
		if(money+50 > PlayerInfo[playerid][pMoney]) return ERROR(playerid,"Nemate dovoljno novca!");
		if(!IsPlayerConnected(id)) return ERROR(playerid,"Igrac ne igra!");
		if(!PlayerInfo[id][pBankovniRacun]) return ERROR(playerid,"Igrac nema otvoreni bankovni racun!");
		PlayerInfo[id][pBankMoney] += money;
  		PlayerInfo[playerid][pMoney] -= money;
  		UpdateBankaZlatoTD(id);
		GivePlayerMoney(playerid,-money);
		new str[200];
		format(str,sizeof(str),""siva"[POSTA] "bijela"Uspjesno ste uplatili novac na bankovni racun igraca %s(%d$)!",GetName(id),money);
        SCM(playerid,-1,str);
		PlayerInfo[playerid][pMoney] -= 50;
		GivePlayerMoney(playerid,-50);
		BiznisNovac(PlayerInfo[playerid][pUbizzu],50);
		SacuvajIgraca(playerid);
		format(str,sizeof(str),""siva"[POSTA] "zelena"Igrac %s vam je uplatio %d$ na bankovni racun!",GetName(playerid),money);
        SCM(id,-1,str);
		SacuvajIgraca(id);
	}
	else return ERROR(playerid,"Pogresna vrsta!");
	return 1;
}
//==============================================================================
CMD:prodajzlato(playerid,params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(Radi[playerid]) return ERROR(playerid,"Radite!");
    if(!IsPlayerInRangeOfPoint(playerid,2.0,2824.4622,-1070.4570,-78.9915)) return ERROR(playerid,"Niste na salteru u zlatari!");
	new numb;
	if(sscanf(params,"d",numb)) return USAGE(playerid,"/prodajzlato [Kolicina]"), INFO(playerid,"1g = 10$");
	if(numb < 1 || numb > PlayerInfo[playerid][pZlato]) return ERROR(playerid,"Nemate dovoljno zlata!");
	PlayerInfo[playerid][pZlato] -= numb;
	GivePlayerMoney(playerid,numb*10);
	PlayerInfo[playerid][pMoney] += numb*10;
	UpdateBankaZlatoTD(playerid);
	SacuvajIgraca(playerid);
	new str[150];
	format(str,sizeof(str),""zuta"[ZLATARA] "zelena"Uspjesno ste prodali %dg zlata za %d$!",numb,numb*10);
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:kupizlato(playerid,params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(Radi[playerid]) return ERROR(playerid,"Radite!");
    if(!IsPlayerInRangeOfPoint(playerid,2.0,2836.4536,-1070.2576,-78.9915)) return ERROR(playerid,"Niste na salteru u zlatari!");
	new numb;
	if(sscanf(params,"d",numb)) return USAGE(playerid,"/kupizlato [Kolicina]"), INFO(playerid,"1g = 11$");
	if(numb < 1 || numb*11 > PlayerInfo[playerid][pMoney]) return ERROR(playerid,"Nemate dovoljno novca!");
	PlayerInfo[playerid][pZlato] += numb;
	GivePlayerMoney(playerid,-numb*11);
	PlayerInfo[playerid][pMoney] -= numb*11;
	UpdateBankaZlatoTD(playerid);
	SacuvajIgraca(playerid);
	new str[150];
	format(str,sizeof(str),""zuta"[ZLATARA] "zelena"Uspjesno ste kupili %dg zlata za %d$!",numb,numb*11);
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:updateonlinerekord(playerid, params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		new p; p=0;
		foreach(Player,i) { if(!IsPlayerNPC(i)) { p++; } }
		if(Online != p) { Online=p; }
		if(Online > ServerInfo[sRekord])
		{
		    ServerInfo[sRekord] = Online;
		    foreach(Player,i)
		    {
		        ClearChat(i);
		        PlayerPlaySound(i, 5448, 0.0, 0.0, 0.0);
		    }
		    SCMTA(-1,""plava"["TAG"] "zelena"Zahvaljujuemo se svim igracima upravo smo postigli novi rekord!");
			new str[100];
			format(str,sizeof(str),""plava"["TAG"] "zelena"Novi rekord je %d!",ServerInfo[sRekord]);
			SCMTA(-1,str);
			new str12[20];
			format(str12,sizeof(str12),"Rekord: %d",ServerInfo[sRekord]);
			TextDrawSetString(IgTextDraws[16],str12);
			SacuvajServer();
		}
	 	new str1[20];
		format(str1,sizeof(str1),"Online: %d",Online);
		TextDrawSetString(IgTextDraws[15],str1);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:camera(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 6)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		new v1,v2,v;
		if(sscanf(params,"ddd",v1,v2,v)) return USAGE(playerid,"/camera [x][y][z]");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		SetPlayerCameraPos(playerid, x+v1,y+v2,z+v);
		SetPlayerCameraLookAt(playerid, x,y,z);
	}
	return 1;
}
//==============================================================================
CMD:cameraoff(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 6)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		SetCameraBehindPlayer(playerid);
	}
	return 1;
}
//==============================================================================
CMD:kreirajbenzinsku(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
    new str2[30];
    new id=-1;
    for(new i=0;i<MAX_BENZINSKA;i++)
    {
    	format(str2,sizeof(str2),BENPATH,i);
		if(!fexist(str2)) { id = i; break; }
	}
	if(id == -1) return ERROR(playerid,"Dosegnuli ste limit sa benzinskama!");
 	new Float:x,Float:y,Float:z,Float:az;
  	GetPlayerPos(playerid,x,y,z);
 	GetPlayerFacingAngle(playerid,az);
 	BenzinskaInfo[id][bX] = x;
 	BenzinskaInfo[id][bY] = y;
 	BenzinskaInfo[id][bZ] = z;
 	KreirajBenzinsku(id);
 	SacuvajBenzinsku(id);
 	INFO(playerid,"Uspjesno ste kreirali benzinsku!");
	return 1;
}
//==============================================================================
CMD:izbrisibenzinsku(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
 	new id=-1;
  	new str2[30];
    for(new i=0;i<MAX_BENZINSKA;i++)
    {
    	format(str2,sizeof(str2),BENPATH,i);
		if(fexist(str2))
		{
		    if(IsPlayerInRangeOfPoint(playerid,2.0,BenzinskaInfo[i][bX],BenzinskaInfo[i][bY],BenzinskaInfo[i][bZ]))
		    {
		        id=i;
		        break;
		    }
		}
	}
	if(id == -1) return ERROR(playerid,"Niste kod niti jedne benzinske!");
	BenzinskaInfo[id][bX] = 0.0;
 	BenzinskaInfo[id][bY] = 0.0;
 	BenzinskaInfo[id][bZ] = 0.0;
 	IzbrisiBenzinsku(id);
    format(str2,sizeof(str2),BENPATH,id);
	fremove(str2);
	INFO(playerid,"Uspjesno ste obrisali benzinsku!");
	return 1;
}
//==============================================================================
CMD:getbenzinskaid(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new id=-1;
  	new str2[30];
    for(new i=0;i<MAX_BENZINSKA;i++)
    {
    	format(str2,sizeof(str2),BENPATH,i);
		if(fexist(str2))
		{
		    if(IsPlayerInRangeOfPoint(playerid,2.0,BenzinskaInfo[i][bX],BenzinskaInfo[i][bY],BenzinskaInfo[i][bZ]))
		    {
		        id=i;
		        break;
		    }
		}
	}
	if(id == -1) return ERROR(playerid,"Niste kod benzinske!");
	new str[50];
	format(str,sizeof(str),""zuta"Vi ste kod benzinske %d",id);
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:portdobenzinske(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 1) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new id;
	if(sscanf(params,"d",id)) return USAGE(playerid,"/portdobenzinske [Id]");
 	new str[50];
    format(str,sizeof(str),BENPATH,id);
	if(!fexist(str)) return ERROR(playerid,"Ta benzinska ne postoji!");
	PlayerInfo[playerid][pUbizzu] = -1;
	PlayerInfo[playerid][pUkuci] = -1;
	PlayerInfo[playerid][pUorg] = -1;
	PlayerInfo[playerid][pUstanu] = -1;
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid,BenzinskaInfo[id][bX], BenzinskaInfo[id][bY], BenzinskaInfo[id][bZ]);
	Freeze(playerid);
	format(str,sizeof(str),""zuta"Portali ste se do benzinske! ID:%d",id);
	INFO(playerid,str);
	return 1;
}
//==============================================================================
CMD:natoci(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    new str2[30];
    new id = -1;
	for(new i=0;i<MAX_BENZINSKA;i++)
	{
        format(str2,sizeof(str2),BENPATH,i);
		if(fexist(str2))
		{
		    if(IsPlayerInRangeOfPoint(playerid,10.0,BenzinskaInfo[i][bX],BenzinskaInfo[i][bY],BenzinskaInfo[i][bZ]))
		    {
			    new kolicina;
			    new str[150];
			    if(sscanf(params,"d",kolicina))
				{
					USAGE(playerid,"/natoci [Litara]!");
					INFO(playerid,"Cijene!");
					format(str,sizeof(str),"Benzin: 1l - %d$ | Dizel: 1l - %d$ | Eurosuper: 1l - %d$",BENZIN_PRICE,DIZEL_PRICE,EUROSUPER_PRICE);
		            INFO(playerid,str);
					return 1;
				}
				if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u vozilu!");
				if(BenzinInfo[GetNumb(GetPlayerVehicleID(playerid))][bMax] == NEMA) return ERROR(playerid,"Nemozete sipati gorivo u ovo vozilo!");
				if(IsMotorOn(GetPlayerVehicleID(playerid))) return ERROR(playerid,"Prvo morate ugasiti motor vozila!");
				if(kolicina+Gorivo[GetPlayerVehicleID(playerid)] > BenzinInfo[GetNumb(GetPlayerVehicleID(playerid))][bMax])
				{
				    format(str,sizeof(str),"Upisali ste previse! U ovo vozilo mozete natociti %dl!",BenzinInfo[GetNumb(GetPlayerVehicleID(playerid))][bMax]);
				    ERROR(playerid,str);
				    return 1;
				}
				if(kolicina < 1)
				{
				    format(str,sizeof(str),"Upisali ste premalo! U ovo vozilo mozete natociti %dl!",BenzinInfo[GetNumb(GetPlayerVehicleID(playerid))][bMax]);
				    ERROR(playerid,str);
				    return 1;
				}
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ERROR(playerid,"Niste vozac!");
				if(BenzinInfo[GetNumb(GetPlayerVehicleID(playerid))][bType] == BENZIN)
				{
					if(GetPlayerMoney(playerid) >= kolicina*BENZIN_PRICE || PlayerInfo[playerid][pBankMoney] >= kolicina*BENZIN_PRICE)
					{
						Placanje(playerid,-1,kolicina*BENZIN_PRICE);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
				}
				else if(BenzinInfo[GetNumb(GetPlayerVehicleID(playerid))][bType] == DIZEL)
				{
					if(GetPlayerMoney(playerid) >= kolicina*DIZEL_PRICE || PlayerInfo[playerid][pBankMoney] >= kolicina*DIZEL_PRICE)
					{
						Placanje(playerid,-1,kolicina*DIZEL_PRICE);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
				}
				else if(BenzinInfo[GetNumb(GetPlayerVehicleID(playerid))][bType] == EUROSUPER)
				{
					if(GetPlayerMoney(playerid) >= kolicina*EUROSUPER_PRICE || PlayerInfo[playerid][pBankMoney] >= kolicina*EUROSUPER_PRICE)
					{
						Placanje(playerid,-1,kolicina*EUROSUPER_PRICE);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
				}
				else return 1;
				SetGorivo(GetPlayerVehicleID(playerid),kolicina+Gorivo[GetPlayerVehicleID(playerid)]);
				if(BenzinInfo[GetNumb(GetPlayerVehicleID(playerid))][bType] == BENZIN)
				{ format(str,sizeof(str),""zuta"[BENZINSKA] "zelena"Uspjesno ste natocili %dl benzina za %d$!",kolicina,kolicina*BENZIN_PRICE); }
				else if(BenzinInfo[GetNumb(GetPlayerVehicleID(playerid))][bType] == DIZEL)
				{ format(str,sizeof(str),""zuta"[BENZINSKA] "zelena"Uspjesno ste natocili %dl dizela za %d$!",kolicina,kolicina*DIZEL_PRICE); }
				else if(BenzinInfo[GetNumb(GetPlayerVehicleID(playerid))][bType] == EUROSUPER)
                { format(str,sizeof(str),""zuta"[BENZINSKA] "zelena"Uspjesno ste natocili %dl eurosupera za %d$!",kolicina,kolicina*EUROSUPER_PRICE); }
				else return 1;
				SCM(playerid,-1,str);
				id = i;
				break;
			}
		}
	}
	if(id == -1) return ERROR(playerid,"Niste kod benzinske!");
	return 1;
}
//==============================================================================
CMD:kreirajvozilo(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new modelid,cijena,boja1,boja2;
	if(sscanf(params,"dddd",modelid,cijena,boja1,boja2)) return USAGE(playerid,"/kreirajvozilo [Model][Cijena][Boja1][Boja2]!");
	new id = -1;
	for(new i=0;i<MAX_VOZILA;i++)
	{
        new vFile[50];
        format(vFile, sizeof(vFile), VPATH, i);
        if(!fexist(vFile))
        {
            id=i;
            break;
        }
	}
	if(id == -1) return ERROR(playerid,"Kreirali ste previse vozila!");
	new Float:x,Float:y,Float:z,Float:az;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,az);
	VoziloInfo[id][vModel] = modelid; VoziloInfo[id][vPrice] = cijena;
	VoziloInfo[id][vBoja1] = boja1; VoziloInfo[id][vBoja2] = boja2;
	VoziloInfo[id][vOwned] = false; VoziloInfo[id][vLocked] = 0;
	VoziloInfo[id][vOruzje][0] = -1; VoziloInfo[id][vOruzje][1] = -1;
	VoziloInfo[id][vOruzje][2] = -1; VoziloInfo[id][vMunicija][0] = 0;
	VoziloInfo[id][vMunicija][1] = 0; VoziloInfo[id][vMunicija][2] = 0;
	VoziloInfo[id][vDroga] = 0; VoziloInfo[id][vMats] = 0;
	VoziloInfo[id][vMoney] = 0; VoziloInfo[id][vPaintJob] = -1;
	VoziloInfo[id][vX] = x; VoziloInfo[id][vY] = y; VoziloInfo[id][vZ] = z;
	VoziloInfo[id][vAZ] = az; VoziloInfo[id][vID] = CreateVehicle(VoziloInfo[id][vModel],VoziloInfo[id][vX],VoziloInfo[id][vY],VoziloInfo[id][vZ],VoziloInfo[id][vAZ],VoziloInfo[id][vBoja1],VoziloInfo[id][vBoja2],30000);
    SetGorivo(VoziloInfo[id][vID]);
	strmid(VoziloInfo[id][vOwnerName], "Drzava", 0, strlen("Drzava"), 60); SacuvajVozilo(id);
    VoziloInfo[id][vVW] = GetPlayerVirtualWorld(playerid);
	SetVehicleVirtualWorld(VoziloInfo[id][vID],VoziloInfo[id][vVW]);
	new str[120];
	new price;
	price = VoziloInfo[id][vPrice]/2;
	format(str,sizeof(str),""zuta"[%s]\n"zelena"Vozilo na prodaju!\n"zelena"Cijena: %d$",GetVehicleName(VoziloInfo[id][vID]),price);
	vehtxt[VoziloInfo[id][vID]] = Create3DTextLabel(str, -1, 0.0, 0.0, 0.0, 50.0, VoziloInfo[id][vVW], 0 );
	Attach3DTextLabelToVehicle(vehtxt[VoziloInfo[id][vID]], VoziloInfo[id][vID], 0.0, 0.0, 0.0);
    Locked[VoziloInfo[id][vID]] = VoziloInfo[id][vLocked];
	SetPlayerPos(playerid,x,y,z+5);
	INFO(playerid,"Uspjesno ste kreirali vozilo!");
	return 1;
}
//==============================================================================
CMD:kupivozilo(playerid,params[])
{
	#pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(!ServerInfo[sSajam]) return ERROR(playerid,"Sajam trenutno ne radi!");
	new slot=-1;
	for(new i=0;i<MAX_SLOTS;i++) { if(PlayerInfo[playerid][pVozilo][i] == -1) { slot = i; break; } }
 	if(slot == -1) return ERROR(playerid,"Nemate prazan slot za novo vozilo!");
	if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u vozilu koje se prodaje!");
	new idd = GetPlayerVehicleID(playerid),id=-1;
	for(new i=0;i<MAX_VOZILA;i++)
	{
	    if(VoziloInfo[i][vID] == idd)
	    {
	        id=i;
			break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Ovo vozilo se ne prodaje!");
	if(VoziloInfo[id][vOwned]) return ERROR(playerid,"Vozilo nije na prodaju!");
	if(GetPlayerMoney(playerid) < VoziloInfo[id][vPrice]/2) return ERROR(playerid,"Nemate dovoljno novca!");
	PlayerInfo[playerid][pVozilo][slot] = id;
 	strmid(VoziloInfo[id][vOwnerName], GetName(playerid), 0, strlen(GetName(playerid)), 60);
	Delete3DTextLabel(vehtxt[VoziloInfo[id][vID]]);
	new price;
	price = VoziloInfo[id][vPrice]/2;
	GivePlayerMoney(playerid,-price);
	PlayerInfo[playerid][pMoney] -= price;
	VoziloInfo[id][vLocked] = 1; VoziloInfo[id][vOwned] = true;
	Locked[VoziloInfo[id][vID]] = VoziloInfo[id][vLocked];
	SacuvajVozilo(id); SacuvajIgraca(playerid);
	TogglePlayerControllable(playerid, 1);
	ClearChat(playerid);
	INFO(playerid,"Uspjesno ste kupili vozilo!");
	INFO(playerid,"Za upravljanje vozila koristite "zuta"'/v'");
 	return 1;
}
//==============================================================================
CMD:v(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new operacija[24],slot;
	if(sscanf(params,"s[24]d",operacija,slot))
	{
        USAGE(playerid,"/v [Operacija][Slot]");
       	INFO(playerid,"Operacije: lock, find, informacije, sell, park");
	    return 1;
	}
	new id;
	if(slot >= 1 && slot <= MAX_SLOTS)
	{
		if(PlayerInfo[playerid][pVozilo][slot-1] == -1)
		{
			ERROR(playerid,"Nemate vozilo na tom slotu!");
			return 1;
		}
		else
		{
			id=PlayerInfo[playerid][pVozilo][slot-1];
		}
	}
	else
	{
	    USAGE(playerid,"/v [Operacija][Slot]");
       	INFO(playerid,"Operacije: lock, find, informacije, sell, park");
	    return 1;
	}
	if(!strcmp(operacija,"lock",true))
	{
	    new Float:vx,Float:vy,Float:vz;
	    GetVehiclePos(VoziloInfo[id][vID],vx,vy,vz);
	    if(!IsPlayerInRangeOfPoint(playerid,5.0,vx,vy,vz)) return ERROR(playerid,"Niste kod svog vozila!");
	    if(VoziloInfo[id][vLocked] == 1)
	    {
	        GameTextForPlayer(playerid,"~g~UNLOCKED",3000,3);
	        VoziloInfo[id][vLocked] = 0;
	        Locked[VoziloInfo[id][vID]] = VoziloInfo[id][vLocked];
	        SacuvajVozilo(id);
	    }
	    else if(VoziloInfo[id][vLocked] == 0)
	    {
	        GameTextForPlayer(playerid,"~r~LOCKED",3000,3);
	        VoziloInfo[id][vLocked] = 1;
	        Locked[VoziloInfo[id][vID]] = VoziloInfo[id][vLocked];
	        SacuvajVozilo(id);
	    }
	    return 1;
	}
	else if(!strcmp(operacija,"find",true))
	{
	    if(GPSON[playerid]) return ERROR(playerid,"Imate ukljucen gps!");
	    if(Radi[playerid]) return ERROR(playerid,"Radite!");
	    if(polaganje[playerid] != -1) return ERROR(playerid,"Imate ukljuceno polaganje!");
	    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	    GPSON[playerid] = true;
	    new Float:x,Float:y,Float:z;
	    GetVehiclePos(VoziloInfo[id][vID],x,y,z);
	    SetPlayerCheckpoint(playerid,x,y,z,5);
		return 1;
	}
	else if(!strcmp(operacija,"informacije",true))
	{
	    new str1[340],str[150],lock[24];
	    if(VoziloInfo[id][vLocked] == 1) { lock = ""zelena"Da"; }
	    else if(VoziloInfo[id][vLocked] == 0) { lock = ""crvena"Ne"; }
	    format(str,sizeof(str),""bijela"| "plava"Vlasnik: "bijela"%s | "plava"Model: "bijela"%s | "plava"Cijena: "bijela"$%d |",GetName(playerid),GetVehicleName(VoziloInfo[id][vID]),VoziloInfo[id][vPrice]);
		strcat(str1,str);
	    format(str,sizeof(str)," "plava"Zakljucano: %s "bijela"| "plava"ID: "bijela"%d |",lock,VoziloInfo[id][vID]);
        strcat(str1,str);
		ShowPlayerDialog(playerid,DIALOG_INFOR,DIALOG_STYLE_MSGBOX,""plava""IME"- Informacije",str1,"Ok","");
	    return 1;
	}
	else if(!strcmp(operacija,"sell",true))
	{
	    if(IsPlayerInRangeOfPoint(playerid, 10.0, -2053.2981,-109.8786,35.2944))
	    {
		    if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u vozilu!");
	     	if(GetPlayerVehicleID(playerid) != VoziloInfo[id][vID]) return ERROR(playerid,"Niste u svome vozilu!");
	     	if(VoziloJeBrod(GetVehicleModel(GetPlayerVehicleID(playerid)))) return ERROR(playerid,"Ne mozete prodati brod ovdje!");
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ERROR(playerid,"Niste na mjestu vozaca!");
			vsell[playerid] = slot-1;
	  		new str5[140];
			new price;
			price = VoziloInfo[id][vPrice]/2;
			format(str5,sizeof(str5),""bijela"Jeste li sigurni da zelite prodati vase vozilo za "zuta"%d$"bijela"?",price);
			ShowPlayerDialog(playerid,DIALOG_VSELL,DIALOG_STYLE_MSGBOX,""plava""IME" - Prodaja",str5,"Prodaj","Odustani");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 10.0, 2958.9890,-2055.5378,-0.0533))
		{
		    if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u vozilu!");
	     	if(GetPlayerVehicleID(playerid) != VoziloInfo[id][vID]) return ERROR(playerid,"Niste u svome vozilu!");
	     	if(!VoziloJeBrod(GetVehicleModel(GetPlayerVehicleID(playerid)))) return ERROR(playerid,"Niste u brodu!");
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ERROR(playerid,"Niste na mjestu vozaca!");
			vsell[playerid] = slot-1;
	  		new str5[140];
			new price;
			price = VoziloInfo[id][vPrice]/2;
			format(str5,sizeof(str5),""bijela"Jeste li sigurni da zelite prodati vase vozilo za "zuta"%d$"bijela"?",price);
			ShowPlayerDialog(playerid,DIALOG_VSELL,DIALOG_STYLE_MSGBOX,""plava""IME" - Prodaja",str5,"Prodaj","Odustani");
		}
		else return ERROR(playerid,"Niste na sajmu!");
		return 1;
	}
	else if(!strcmp(operacija,"park",true))
	{
	    if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Morate biti u vozilu!");
	    if(GetPlayerVehicleID(playerid) != VoziloInfo[id][vID]) return ERROR(playerid,"Niste u svome vozilu!");
		if(IsMotorOn(GetPlayerVehicleID(playerid))) return ERROR(playerid,"Ugasite vase vozilo!");
        if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ERROR(playerid,"Niste na mjestu vozaca!");
		new Float:x,Float:y,Float:z,Float:az;
		GetVehiclePos(GetPlayerVehicleID(playerid),x,y,z);
		GetVehicleZAngle(GetPlayerVehicleID(playerid),az);
		VoziloInfo[id][vX] = x; VoziloInfo[id][vY] = y;
		VoziloInfo[id][vZ] = z; VoziloInfo[id][vAZ] = az;
		DestroyVehicle(VoziloInfo[id][vID]);
	 	VoziloInfo[id][vID] = CreateVehicle(VoziloInfo[id][vModel],VoziloInfo[id][vX],VoziloInfo[id][vY],VoziloInfo[id][vZ],VoziloInfo[id][vAZ],VoziloInfo[id][vBoja1],VoziloInfo[id][vBoja2],30000);
		VoziloInfo[id][vVW] = GetPlayerVirtualWorld(playerid);
		SetVehicleVirtualWorld(VoziloInfo[id][vID],VoziloInfo[id][vVW]);
		SacuvajVozilo(id);
		ModVehicle(VoziloInfo[id][vID]);
		if(VoziloInfo[id][vPaintJob] != -1)
  		{
			ChangeVehiclePaintjob(VoziloInfo[id][vID], VoziloInfo[id][vPaintJob]);
		}
		ChangeVehicleColor(VoziloInfo[id][vID], VoziloInfo[id][vBoja1], VoziloInfo[id][vBoja2]);
		SetPlayerPos(playerid,x,y,z+3);
	    return 1;
	}
	else
	{
	    USAGE(playerid,"/v [Operacija][Slot]");
       	INFO(playerid,"Operacije: lock, find, informacije, sell, park");
	}
	return 1;
}
//==============================================================================
CMD:katalog(playerid,params[])
{
	#pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(!ServerInfo[sSalon]) return ERROR(playerid,"Salon trenutno ne radi!");
	if(GPSON[playerid]) return ERROR(playerid,"Imate ukljucen gps!");
	if(polaganje[playerid] != -1) return ERROR(playerid,"Imate ukljuceno polaganje!");
	if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new slot=-1;
	for(new i=0;i<MAX_SLOTS;i++) { if(PlayerInfo[playerid][pVozilo][i] == -1) { slot = i; break; } }
	if(slot == -1) return ERROR(playerid,"Nemate prazan slot za novo vozilo!");
	if(Radi[playerid]) return ERROR(playerid,"Radite!");
	if(IsPlayerInRangeOfPoint(playerid,2.0,1781.5028,-1782.7031,13.8998) || IsPlayerInRangeOfPoint(playerid,2.0,1781.9479,-1789.0289,13.8998) || IsPlayerInRangeOfPoint(playerid,2.0,1781.7378,-1797.0691,13.8998))
	{
	    for(new i=0;i<sizeof(katalog);i++) { TextDrawShowForPlayer(playerid,katalog[i]); }
	    for(new i=0;i<sizeof(katalogp);i++) { PlayerTextDrawShow(playerid,katalogp[i][playerid]); }
	    SelectTextDraw(playerid, 0xFFFFFFFF);
		katalogid[playerid] = 0;
		PlayerTextDrawHide(playerid,katalogp[1][playerid]);
	    PlayerTextDrawSetPreviewModel(playerid, katalogp[1][playerid], KatalogInfo[katalogid[playerid]][kID]);
        PlayerTextDrawShow(playerid,katalogp[1][playerid]);
        new str[60];
        format(str,sizeof(str),"%d/%d",katalogid[playerid],MAX_KATALOG-1);
		PlayerTextDrawSetString(playerid,katalogp[3][playerid],str);
		format(str,sizeof(str),"%s",VehicleNames[KatalogInfo[katalogid[playerid]][kID] - 400]);
		PlayerTextDrawSetString(playerid,katalogp[0][playerid],str);
		format(str,sizeof(str),"Cijena: %d$",KatalogInfo[katalogid[playerid]][kPrice]);
		PlayerTextDrawSetString(playerid,katalogp[2][playerid],str);
	}
	else return ERROR(playerid,"Niste u salonu vozila!");
	return 1;
}
//==============================================================================
CMD:izlaz(playerid,params[])
{
	#pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(!IsPlayerInAnyVehicle(playerid)) return 1;
	if(Radi[playerid]) return ERROR(playerid,"Radite!");
	TogglePlayerControllable(playerid, 1);
	RemovePlayerFromVehicle(playerid);
	return 1;
}
//==============================================================================
CMD:gepek(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    new Float:vx,Float:vy,Float:vz;
    new id = -1;
	for(new i=0;i<MAX_VEHICLES;i++)
	{
	    GetPosBehindVehicle(i, vx, vy, vz);
	    if(IsPlayerInRangeOfPoint(playerid,3.0,vx,vy,vz))
	    {
	        id = i;
	        break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Niste kod gepeka niti jednog vozila!");
	if(!IsTrunkOpened(id))
	{
		if(Locked[id] == 1 || Locked[id] == 2)
		{
			GameTextForPlayer(playerid,"~r~Zakljucano",1000,3);
			return 1;
		}
	}
	if(IsTrunkOpened(id))
	{
 		new engine, lightss, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(id, engine, lightss, alarm, doors, bonnet, boot, objective);
		boot = 0;
		SetVehicleParamsEx(id, engine, lightss, alarm, doors, bonnet, boot, objective);
		GameTextForPlayer(playerid,"~w~Gepek zatvoren",1000,3);
	}
	else
	{
	    new engine, lightss, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(id, engine, lightss, alarm, doors, bonnet, boot, objective);
		boot = 1;
		SetVehicleParamsEx(id, engine, lightss, alarm, doors, bonnet, boot, objective);
		GameTextForPlayer(playerid,"~w~Gepek otvoren",1000,3);
	}
	return 1;
}
//==============================================================================
CMD:gmenu(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    new Float:vx,Float:vy,Float:vz;
    new id = -1;
	for(new i=0;i<MAX_VEHICLES;i++)
	{
	    GetPosBehindVehicle(i, vx, vy, vz);
	    if(IsPlayerInRangeOfPoint(playerid,3.0,vx,vy,vz))
	    {
	        id = i;
	        break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Niste kod gepeka niti jednog vozila!");
	new id2 = -1;
	for(new i=0;i<MAX_VOZILA;i++)
	{
		if(VoziloInfo[i][vID] == id)
		{
		    id2 = i;
		    break;
		}
	}
	if(id2 == -1) return ERROR(playerid,"Ovo nije osobno vozilo!");
    if(!VoziloInfo[id2][vOwned]) return ERROR(playerid,"Nemozete uzimati stvari iz vozila koje se prodaje!");
	if(IsTrunkOpened(id))
	{
		ShowPlayerDialog(playerid,DIALOG_GEPEK,DIALOG_STYLE_LIST,""plava""IME" - Gepek:",""bijela"Uzmi novac\n"plava"Ostavi novac\n"bijela"Uzmi oruzje\n"plava"Ostavi oruzje\n"bijela"Uzmi oruzje 2\n"plava"Ostavi oruzje 2\n"bijela"Uzmi oruzje 3\n"plava"Ostavi oruzje 3\n"bijela"Uzmi drogu\n"plava"Ostavi drogu\n"bijela"Uzmi mats\n"plava"Ostavi mats\n"bijela"Gepek","Dalje","Odustani");
	}
	else return ERROR(playerid,"Prvo otvorite gepek!");
	return 1;
}
//==============================================================================
CMD:sellcarto(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new targetid,slot,cijena;
	if(sscanf(params,"udd",targetid,slot,cijena)) return USAGE(playerid,"/sellcarto [Id/Ime][Slot][Cijena]!");
    if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
    if(targetid == playerid) return ERROR(playerid,"Nemozete ponudit sami sebi!");
	new id;
	if(slot >= 1 && slot <= MAX_SLOTS)
	{
		if(PlayerInfo[playerid][pVozilo][slot-1] == -1)
		{
			ERROR(playerid,"Nemate vozilo na tom slotu!");
			return 1;
		}
		else
		{
			id=PlayerInfo[playerid][pVozilo][slot-1];
		}
	}
	if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u vozilu!");
   	if(GetPlayerVehicleID(playerid) != VoziloInfo[id][vID]) return ERROR(playerid,"Niste u svome vozilu!");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ERROR(playerid,"Niste na mjestu vozaca!");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(targetid,x,y,z);
	if(!IsPlayerInRangeOfPoint(playerid,5.0,x,y,z)) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(cijena <= 100000) return ERROR(playerid,"Nemozete za manje od 100000$!");
	new slott=-1;
	for(new i=0;i<MAX_SLOTS;i++) { if(PlayerInfo[targetid][pVozilo][i] == -1) { slott = i; } }
	if(slott == -1) return ERROR(playerid,"Igrac nema slobodan slot!");
	Ponudio[targetid] = playerid; Slot[targetid] = slot-1; Cijena[targetid] = cijena;
	new str[300];
	format(str,sizeof(str),""zelena"Ponudili ste vase vozilo igracu %s!",GetName(targetid));
	SCM(playerid,-1,str);
	format(str,sizeof(str),""crvena"PRODAJA\n"bijela"Igrac "zelena"%s "bijela"vam je ponudio vozilo "zelena"%s "bijela"za "zelena"%d$\n"bijela"Da prihvatite upisite "zuta"PRIHVATI "bijela"sa velikim slovima!",GetName(playerid),GetVehicleName(VoziloInfo[id][vID]),cijena);
	ShowPlayerDialog(targetid,DIALOG_SELLCARTO,DIALOG_STYLE_INPUT,""plava""IME" - Kupovina",str,"Dalje","Odustani");
	return 1;
}
//==============================================================================
CMD:portmyvehicle(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(Radi[playerid]) return ERROR(playerid,"Radite!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1 || PlayerInfo[playerid][pVip] >= 1)
	{
		if(PlayerInfo[playerid][pZatvoren]) return ERROR(playerid,"U zatvoru ste!");
		if(Radi[playerid]) return ERROR(playerid,"Radite!");
	    if(polaganje[playerid] != -1) return ERROR(playerid,"Polazete!");
	    if(Trenira[playerid] != -1) return ERROR(playerid,"Trenirate skill!");
	    if(GetPlayerVirtualWorld(playerid) != 0) return ERROR(playerid,"Ne mozete u virtual worldu!");
	    if(GetPlayerInterior(playerid) != 0) return ERROR(playerid,"Ne mozete u interioru!");
		new slot;
		if(sscanf(params,"d",slot)) return USAGE(playerid,"/portmyvehicle [Slot]");
		if(slot < 1 || slot > MAX_SLOTS) return ERROR(playerid,"Pogresan slot!");
		if(PlayerInfo[playerid][pVozilo][slot-1] == -1) return ERROR(playerid,"Nemate vozilo na tom slotu!");
        new Float:x,Float:y,Float:z;
		GetPlayerPos(playerid,x,y,z);
		SetVehiclePos(VoziloInfo[PlayerInfo[playerid][pVozilo][slot-1]][vID],x,y,z);
		new str[200];
        format(str, sizeof(str),"Portali ste svoj %s do sebe!",GetVehicleName(VoziloInfo[PlayerInfo[playerid][pVozilo][slot-1]][vID]));
        INFO(playerid,str);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:postavilidera(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] < 5) return ERROR(playerid,"Niste ovlasteni!");
    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new targetid,orgid;
	if(sscanf(params,"ud",targetid,orgid))
	{
		USAGE(playerid,"/postavilidera [Id/Ime][Id org]!");
		new str[50];
		format(str,sizeof(str),"-1: Skinuti lidera");
  		INFO(playerid,str);
		for(new i=0;i<MAX_ORGS;i++)
		{
		    format(str,sizeof(str),"%d: %s",i,OrgInfo[i][oName]);
		    INFO(playerid,str);
		}
		return 1;
	}
	if(orgid == -1)
	{
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if(PlayerInfo[targetid][pRank] != 6) return ERROR(playerid,"Igrac nije lider!");
		new str[100];
		format(str,sizeof(str),""smeda"Admin %s vam je skinuo lidera organizacije %s.",GetName(playerid),OrgInfo[PlayerInfo[targetid][pOrgID]][oName]);
	 	SCM(targetid,-1,str);
	 	OrgInfo2[PlayerInfo[targetid][pOrgID]][oClanovi]--;
		SacuvajOrganizaciju(PlayerInfo[targetid][pOrgID]);
		if(PlayerInfo[targetid][pOrgID] == POLICIJA)
	  	{
	  		PolicijaDuty[targetid] = false;
	    	ResetPlayerWeapons(targetid);
	    	SetPlayerArmour(targetid,0.0);
	    	Tazer[targetid] = false;
		}
	 	PlayerInfo[targetid][pOrgID] = -1;
	  	PlayerInfo[targetid][pRank] = 0;
	  	SetPlayerSkin(targetid,PlayerInfo[targetid][pSkin]);
  		SacuvajIgraca(targetid);
 		new lgg[200];
		format(lgg,sizeof(lgg),"[SKINUTI-LIDER] | Admin %s | Igraca %s |",GetName(playerid),GetName(targetid));
		Log(ADMIN_LOG,lgg);
		return 1;
	}
	else
	{
		if(orgid < 0 || orgid >= MAX_ORGS) return ERROR(playerid,"Pogresna organizacija!");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(!spawned[targetid]) return ERROR(playerid,"Igrac nije spawnovan!");
		if(PlayerInfo[targetid][pRank] == 6) return ERROR(playerid,"Igrac je vec lider neke organizacije!");
		if(OrgInfo2[orgid][oClanovi] >= OrgInfo[orgid][oMaxClanova]) return ERROR(playerid,"Organizacija ima maksimalan broj clanova!");
		new str[100];
	 	PlayerInfo[targetid][pOrgID] = orgid;
	  	PlayerInfo[targetid][pRank] = 6;
		format(str,sizeof(str),""smeda"Admin %s vam je dao lidera organizacije %s.",GetName(playerid),OrgInfo[orgid][oName]);
	 	SCM(targetid,-1,str);
	  	SetPlayerSkin(targetid,OrgInfo[orgid][oRankSkin6]);
	  	SacuvajIgraca(targetid);
        OrgInfo2[orgid][oClanovi]++;
		SacuvajOrganizaciju(orgid);
		new lgg[200];
		format(lgg,sizeof(lgg),"[LIDER] | Admin %s | Igraca %s | Organizacija %s |",GetName(playerid),GetName(targetid),OrgInfo[orgid][oName]);
		Log(ADMIN_LOG,lgg);
		return 1;
	}
}
//==============================================================================
CMD:ubaci(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pRank] != 6) return ERROR(playerid,"Nisite lider!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Nisite u niti jednoj organizaciji!");
	if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new targetid;
	if(sscanf(params,"u",targetid)) return USAGE(playerid,"/ubaci [Id/Ime]");
	if(PozvanUOrg[targetid]) return ERROR(playerid,"Igrac je trenutno pozvan u neku organizaciju!");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije na serveru!");
	if(PlayerInfo[targetid][pLevel] < 2) return ERROR(playerid,"Igrac ima manji level od 2!");
	if(PlayerInfo[targetid][pOrgID] != -1) return ERROR(playerid,"Taj igrac je vec u nekoj organizaciji!");
	if(playerid == targetid) return ERROR(playerid,"Ne mozete pozvati samoga sebe u organizaciju!");
	if(GetDistanceBetweenPlayers(playerid,targetid) > 5) return ERROR(playerid,"Nisite u blizini tog igraca!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA && !PlayerInfo[targetid][pOruzjeDozvola]) return ERROR(playerid,"Igrac nema dozvolu za oruzje!");
	if(OrgInfo2[PlayerInfo[playerid][pOrgID]][oClanovi] >= OrgInfo[PlayerInfo[playerid][pOrgID]][oMaxClanova]) return ERROR(playerid,"Organizacija ima maksimalan broj clanova!");
	PozvanUOrg[targetid] = true;
	IdOrgPozvan[targetid] = PlayerInfo[playerid][pOrgID];
	new str[100];
	format(str,sizeof(str),""bijela"Igrac "smeda"%s "bijela"vas je pozvao u organizaciju "smeda"%s.",GetName(playerid),OrgInfo[PlayerInfo[playerid][pOrgID]][oName]);
	ShowPlayerDialog(targetid,DIALOG_UBACI,DIALOG_STYLE_MSGBOX,""smeda""IME" - Poziv u organizaciju:",str,"Prihvati","Odbij");
	return 1;
}
//==============================================================================
CMD:izbaci(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pRank] != 6) return ERROR(playerid,"Nisite lider!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Nisite u niti jednoj organizaciji!");
	new targetid;
    if(sscanf(params,"u",targetid)) return USAGE(playerid,"/izbaci [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije na serveru!");
	if(PlayerInfo[targetid][pRank] == 6) return ERROR(playerid,"Taj igrac je lider!");
	if(PlayerInfo[targetid][pOrgID] != PlayerInfo[playerid][pOrgID]) return ERROR(playerid,"Taj igrac nije u vasoj organizaciji!");
	if(playerid == targetid) return ERROR(playerid,"Ne mozete izbaciti samog sebe iz organizacije!");
	new str[150];
	format(str,sizeof(str),""bijela"Lider "smeda"%s "bijela"je izbacio igraca "smeda"%s "bijela"iz organizacije.",GetName(playerid),GetName(targetid));
	SendOrgMessage(playerid,str);
	SetPlayerSkin(targetid,PlayerInfo[targetid][pSkin]);
	OrgInfo2[PlayerInfo[playerid][pOrgID]][oClanovi]--;
	SacuvajOrganizaciju(PlayerInfo[playerid][pOrgID]);
	if(PlayerInfo[targetid][pOrgID] == POLICIJA)
	{
		PolicijaDuty[targetid] = false;
 		ResetPlayerWeapons(targetid);
  		SetPlayerArmour(targetid,0.0);
	   	Tazer[targetid] = false;
	}
	PlayerInfo[targetid][pOrgID] = -1;
	PlayerInfo[targetid][pRank] = 0;
	SacuvajIgraca(targetid);
	return 1;
}
//==============================================================================
CMD:dodijelirank(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pRank] != 6) return ERROR(playerid,"Nisite lider!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Nisite u niti jednoj organizaciji!");
	new targetid,rank;
	if(sscanf(params,"ud",targetid,rank)) return USAGE(playerid,"/dodijelirank [Id/Ime][Rank]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije na serveru!");
	if(PlayerInfo[targetid][pRank] == 6) return ERROR(playerid,"Taj igrac je lider!");
	if(PlayerInfo[targetid][pOrgID] != PlayerInfo[playerid][pOrgID]) return ERROR(playerid,"Taj igrac nije u vasoj organizaciji!");
	if(playerid == targetid) return ERROR(playerid,"Ne mozete unaprijediti samoga sebe!");
	if(rank < 1 || rank > 5) return ERROR(playerid,"Eankovi su od 1 do 5!");
	PlayerInfo[targetid][pRank] = rank;
    if(PlayerInfo[targetid][pOrgID] != -1)
	{
	    if(PlayerInfo[targetid][pRank] == 1) { SetPlayerSkin(targetid,OrgInfo[PlayerInfo[targetid][pOrgID]][oRankSkin1]); }
		else if(PlayerInfo[targetid][pRank] == 2) { SetPlayerSkin(targetid,OrgInfo[PlayerInfo[targetid][pOrgID]][oRankSkin2]);  }
        else if(PlayerInfo[targetid][pRank] == 3) { SetPlayerSkin(targetid,OrgInfo[PlayerInfo[targetid][pOrgID]][oRankSkin3]);  }
        else if(PlayerInfo[targetid][pRank] == 4) { SetPlayerSkin(targetid,OrgInfo[PlayerInfo[targetid][pOrgID]][oRankSkin4]);  }
        else if(PlayerInfo[targetid][pRank] == 5) { SetPlayerSkin(targetid,OrgInfo[PlayerInfo[targetid][pOrgID]][oRankSkin5]);  }
        else if(PlayerInfo[targetid][pRank] == 6) { SetPlayerSkin(targetid,OrgInfo[PlayerInfo[targetid][pOrgID]][oRankSkin6]);  }
	}
	new str[100],str1[100];
	format(str,sizeof(str),""smeda"Lider %s vam je postavio rank %d.",GetName(playerid),rank);
	format(str1,sizeof(str1),""smeda"Postavili ste rank %d igracu %s.",rank,GetName(targetid));
    SCM(targetid,-1,str);
    SCM(playerid,-1,str1);
    SacuvajIgraca(targetid);
	return 1;
}
//==============================================================================
CMD:onlinelideri(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    new str[200],str1[100];
	foreach(Player,i)
	{
	    if(PlayerInfo[i][pRank] == 6)
	    {
	    	format(str1,sizeof(str1),""bijela"| "smeda"%s "bijela"| "smeda"%s "bijela"|\n",GetName(i),OrgInfo[PlayerInfo[i][pOrgID]][oName]);
	    	strcat(str,str1);
		}
	}
	ShowPlayerDialog(playerid,DIALOG_LIDERI,DIALOG_STYLE_MSGBOX,""smeda""IME" - Online lideri:",str,"Ok","");
	return 1;
}
//==============================================================================
CMD:f(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Nisite u niti jednoj organizaciji!");
	new chat[60];
	if(sscanf(params,"s[60]",chat)) return USAGE(playerid,"/f [Tekst]");
	new str[150];
 	format(str,sizeof(str),""smeda"%s[%d](Rank %d): "siva"%s",GetName(playerid),playerid,PlayerInfo[playerid][pRank],chat);
    SendOrgMessage(playerid,str); 
	return 1;
}
//==============================================================================
CMD:sef(playerid,params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Nisite u niti jednoj organizaciji!");
	if(PlayerInfo[playerid][pUorg] != PlayerInfo[playerid][pOrgID]) return ERROR(playerid,"Niste u svojoj organizaciji!");
	if(PlayerInfo[playerid][pRank] >= 5 || PlayerInfo[playerid][pAdmin] >= 6)
	{
		new id = PlayerInfo[playerid][pOrgID];
		if(!OrgInfo[id][oSef]) return ERROR(playerid,"Vasa organizacija nema sef!");
		if(!IsPlayerInRangeOfPoint(playerid,2.0,OrgInfo[id][oSefX],OrgInfo[id][oSefY],OrgInfo[id][oSefZ])) return ERROR(playerid,"Niste kod sefa!");
		ShowPlayerDialog(playerid,DIALOG_SEF,DIALOG_STYLE_LIST,""smeda""IME" - Sef:",""bijela"Uzmi novac\n"smeda"Ostavi novac\n"bijela"Uzmi drogu\n"smeda"Ostavi drogu\n"bijela"Uzmi mats\n"smeda"Ostavi mats\n"bijela"Informacije","Dalje","Odustani");
	}
	else return ERROR(playerid,"Nisite ovlasteni!");
	return 1;
}
//==============================================================================
CMD:portdoorganizacije(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] < 1) return ERROR(playerid,"Niste ovlasteni!");
    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new orgid;
	if(sscanf(params,"d",orgid))
	{
		USAGE(playerid,"/portdoorganizacije  [Id org]!");
		new str[50];
		for(new i=0;i<MAX_ORGS;i++)
		{
		    format(str,sizeof(str),"%d: %s",i,OrgInfo[i][oName]);
		    INFO(playerid,str);
		}
		return 1;
	}
	if(orgid < 0 || orgid >= MAX_ORGS) return ERROR(playerid,"Pogresna organizacija!");
	PlayerInfo[playerid][pUbizzu] = -1;
	PlayerInfo[playerid][pUkuci] = -1;
	PlayerInfo[playerid][pUorg] = -1;
	PlayerInfo[playerid][pUstanu] = -1;
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid,OrgInfo[orgid][oUlazX],OrgInfo[orgid][oUlazY],OrgInfo[orgid][oUlazZ]);
	SetPlayerFacingAngle(playerid,OrgInfo[orgid][oUlazAZ]);
	Freeze(playerid);
	new str[100];
	format(str,sizeof(str),"Portali ste se do organizacije %s!",OrgInfo[orgid][oName]);
 	INFO(playerid,str);
	return 1;
}
CMD:portdoorg(playerid,params[]) return cmd_portdoorganizacije(playerid,params);
//==============================================================================
CMD:promijenispawn(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new id;
	if(sscanf(params,"d",id)) return USAGE(playerid,"/promijenispawn [Id]"), INFO(playerid,"0: Spawn | 1: Biznis | 2: Kuca | 3: Organizacija | 4: Stan");
	if(id < 0 || id > 4) return ERROR(playerid,"Pogresan ID!");
	switch(id)
	{
	    case 0:
	    {
			PlayerInfo[playerid][pSpawnType] = 0;
			INFO(playerid,"Uspjesno ste postavili spawn na "zuta"Spawn"bijela"!");
	    }
	    case 1:
	    {
	        if(PlayerInfo[playerid][pBizzID] == -1) return ERROR(playerid,"Nemate biznis!");
			PlayerInfo[playerid][pSpawnType] = 1;
			INFO(playerid,"Uspjesno ste postavili spawn u "zuta"Biznis"bijela"!");
	    }
	    case 2:
	    {
	        if(PlayerInfo[playerid][pKucaID] == -1) return ERROR(playerid,"Nemate kucu!");
			PlayerInfo[playerid][pSpawnType] = 2;
			INFO(playerid,"Uspjesno ste postavili spawn u "zuta"Kucu"bijela"!");
	    }
	    case 3:
	    {
	        if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Niste u organizaciji!");
			PlayerInfo[playerid][pSpawnType] = 3;
			INFO(playerid,"Uspjesno ste postavili spawn u "zuta"Organizaciju"bijela"!");
	    }
	    case 4:
	    {
	        if(PlayerInfo[playerid][pStanID] == -1) return ERROR(playerid,"Nemate stan!");
			PlayerInfo[playerid][pSpawnType] = 4;
			INFO(playerid,"Uspjesno ste postavili spawn u "zuta"Stan"bijela"!");
	    }
	}
	SacuvajIgraca(playerid);
	return 1;
}
CMD:pspawn(playerid,params[]) return cmd_promijenispawn(playerid,params);
//==============================================================================
CMD:aspawn(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new targetid,str[128];
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "u", targetid)) return USAGE(playerid,"/aspawn [Id/Ime]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
		if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		format(str,sizeof(str),""crvena"[SPAWN] Admin %s vas je spawnovao!",GetName(playerid));
		SCM(targetid,-1,str);
		format(str,sizeof(str),""zuta"Spawnovali ste igraca %s!",GetName(targetid));
		SCM(playerid,-1,str);
		format(str,sizeof(str),""crvena"[SPAWN] "zuta"| Admin %s | Igraca %s |",GetName(playerid),GetName(targetid));
        SendAdminMessage(str);
        SpawnPlayer(targetid);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:koristidrogu(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new droga;
	if(sscanf(params,"d",droga)) return USAGE(playerid,"/koristidrogu [Kolicina]");
	if(PlayerInfo[playerid][pDroga] < 1) return ERROR(playerid,"Nemate droge!");
    if(droga > PlayerInfo[playerid][pDroga]) return ERROR(playerid,"Nemate toliko droge!");
    if(koristidrogu[playerid]) return ERROR(playerid,"Trenutno ste pod utjecajem droge!");
   	new Float:armour;
    GetPlayerArmour(playerid,armour);
    if(droga+armour > 99.0) return ERROR(playerid,"Ne mozete toliko!");
	PlayerInfo[playerid][pDroga] -= droga;
    SetPlayerDrunkLevel(playerid, 4000);
    SetPlayerWeather(playerid, -68);
    SetPlayerArmour(playerid,armour+droga);
    SetTimerEx("prekinidrogaeffect",droga*2000,false,"d",playerid);
    koristidrogu[playerid] = true;
	return 1;
}
//==============================================================================
CMD:afklista(playerid, params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
	    if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
		new id = 0, string[150],str[250];
		foreach(Player,i)
		{
		    if(IsPlayerConnected(i))
		    {
				if(AFK[i])
				{
					format(string,sizeof(string), "\n"plava"| Ime: "bijela"%s "plava"| ID: "bijela"%d "plava"| Vrijeme: "bijela"%d min"plava"|", GetName(i), i, ACNUMB[i]/60);
					format(str,sizeof(str),"%s%s",str,string);
					id++;
				}
			}
		}
		if(id == 0) return ERROR(playerid,"Nema afk igraca!");
		ShowPlayerDialog(playerid,DIALOG_AFK_LISTA,DIALOG_STYLE_MSGBOX,""zuta"Afk igraci:",str,""bijela"Ok","");
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:sellbiznisto(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new targetid,cijena;
	if(sscanf(params,"ud",targetid,cijena)) return USAGE(playerid,"/sellbiznisto [Id/Ime][Cijena]!");
    if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
    if(targetid == playerid) return ERROR(playerid,"Ne mozete ponuditi sami sebi!");
	if(PlayerInfo[playerid][pBizzID] == -1) return ERROR(playerid,"Nemate biznis!");
	if(GetBiznis(playerid) != PlayerInfo[playerid][pBizzID]) return ERROR(playerid,"Niste kod ulaza u svoj biznis!");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(targetid,x,y,z);
	if(!IsPlayerInRangeOfPoint(playerid,5.0,x,y,z)) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(cijena < 1) return ERROR(playerid,"Nemozete za manje od 1$!");
	if(PlayerInfo[targetid][pBizzID] != -1) return ERROR(playerid,"Igrac posjeduje biznis!");
	PonudioB[targetid] = playerid; CijenaB[targetid] = cijena;
	new str[300];
	format(str,sizeof(str),""zelena"Ponudili ste vas biznis igracu %s!",GetName(targetid));
	SCM(playerid,-1,str);
	format(str,sizeof(str),""crvena"PRODAJA\n"bijela"Igrac "zelena"%s "bijela"vam je ponudio biznis "zelena"%s(%d) "bijela"za "zelena"%d$\n"bijela"Da prihvatite upisite "zuta"PRIHVATI "bijela"sa velikim slovima!",GetName(playerid),VrstaBiznisa(PlayerInfo[playerid][pBizzID]),PlayerInfo[playerid][pBizzID],cijena);
	ShowPlayerDialog(targetid,DIALOG_SELLBIZNISTO,DIALOG_STYLE_INPUT,""plava""IME" - Kupovina",str,"Dalje","Odustani");
	return 1;
}
//==============================================================================
CMD:sellkucato(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new targetid,cijena;
	if(sscanf(params,"ud",targetid,cijena)) return USAGE(playerid,"/sellkucato [Id/Ime][Cijena]!");
    if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
    if(targetid == playerid) return ERROR(playerid,"Ne mozete ponuditi sami sebi!");
	if(PlayerInfo[playerid][pKucaID] == -1) return ERROR(playerid,"Nemate kucu!");
	if(GetKuca(playerid) != PlayerInfo[playerid][pKucaID]) return ERROR(playerid,"Niste kod ulaza u svoju kucu!");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(targetid,x,y,z);
	if(!IsPlayerInRangeOfPoint(playerid,5.0,x,y,z)) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(cijena < 1) return ERROR(playerid,"Nemozete za manje od 1$!");
	if(PlayerInfo[targetid][pKucaID] != -1) return ERROR(playerid,"Igrac posjeduje kucu!");
	PonudioK[targetid] = playerid; CijenaK[targetid] = cijena;
	new str[300];
	format(str,sizeof(str),""zelena"Ponudili ste vasu kucu igracu %s!",GetName(targetid));
	SCM(playerid,-1,str);
	format(str,sizeof(str),""crvena"PRODAJA\n"bijela"Igrac "zelena"%s "bijela"vam je ponudio kucu "zelena"%s(%d) "bijela"za "zelena"%d$\n"bijela"Da prihvatite upisite "zuta"PRIHVATI "bijela"sa velikim slovima!",GetName(playerid),VrstaKuce(PlayerInfo[playerid][pKucaID]),PlayerInfo[playerid][pKucaID],cijena);
	ShowPlayerDialog(targetid,DIALOG_SELLKUCATO,DIALOG_STYLE_INPUT,""plava""IME" - Kupovina",str,"Dalje","Odustani");
	return 1;
}
//==============================================================================
CMD:sellzlatoto(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new targetid,cijena,kol;
	if(sscanf(params,"udd",targetid,cijena,kol)) return USAGE(playerid,"/sellzlatoto [Id/Ime][Cijena jednog gramu][Kolicina]!");
    if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
    if(targetid == playerid) return ERROR(playerid,"Ne mozete ponuditi sami sebi!");
	if(PlayerInfo[playerid][pZlato] < kol) return ERROR(playerid,"Nemate toliko zlata!");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(targetid,x,y,z);
	if(!IsPlayerInRangeOfPoint(playerid,5.0,x,y,z)) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(cijena < 1) return ERROR(playerid,"Nemozete za manje od 1$!");
	PonudioZ[targetid] = playerid; CijenaZ[targetid] = cijena*kol; KolZ[targetid] = kol;
	new str[300];
	format(str,sizeof(str),""zelena"Ponudili ste %dg zlata igracu %s za %d$!",kol,GetName(targetid),cijena*kol);
	SCM(playerid,-1,str);
	format(str,sizeof(str),""crvena"PRODAJA\n"bijela"Igrac "zelena"%s "bijela"vam je ponudio "zelena"%dg "bijela"zlata za "zelena"%d$\n"bijela"Da prihvatite upisite "zuta"PRIHVATI "bijela"sa velikim slovima!",GetName(playerid),kol,cijena*kol);
	ShowPlayerDialog(targetid,DIALOG_SELLZLATOTO,DIALOG_STYLE_INPUT,""plava""IME" - Kupovina",str,"Dalje","Odustani");
	return 1;
}
//==============================================================================
CMD:selldrogato(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new targetid,cijena,kol;
	if(sscanf(params,"udd",targetid,cijena,kol)) return USAGE(playerid,"/selldrogato [Id/Ime][Cijena jednog gramu][Kolicina]!");
    if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
    if(targetid == playerid) return ERROR(playerid,"Ne mozete ponuditi sami sebi!");
	if(PlayerInfo[playerid][pDroga] < kol) return ERROR(playerid,"Nemate toliko droge!");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(targetid,x,y,z);
	if(!IsPlayerInRangeOfPoint(playerid,5.0,x,y,z)) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(cijena < 1) return ERROR(playerid,"Nemozete za manje od 1$!");
	PonudioD[targetid] = playerid; CijenaD[targetid] = cijena*kol; KolD[targetid] = kol;
	new str[300];
	format(str,sizeof(str),""zelena"Ponudili ste %dg droge igracu %s za %d$!",kol,GetName(targetid),cijena*kol);
	SCM(playerid,-1,str);
	format(str,sizeof(str),""crvena"PRODAJA\n"bijela"Igrac "zelena"%s "bijela"vam je ponudio "zelena"%dg "bijela"droge za "zelena"%d$\n"bijela"Da prihvatite upisite "zuta"PRIHVATI "bijela"sa velikim slovima!",GetName(playerid),kol,cijena*kol);
	ShowPlayerDialog(targetid,DIALOG_SELLDROGATO,DIALOG_STYLE_INPUT,""plava""IME" - Kupovina",str,"Dalje","Odustani");
	return 1;
}
//==============================================================================
CMD:sellmatsto(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new targetid,cijena,kol;
	if(sscanf(params,"udd",targetid,cijena,kol)) return USAGE(playerid,"/sellmatsto [Id/Ime][Cijena jednog gramu][Kolicina]!");
    if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
    if(targetid == playerid) return ERROR(playerid,"Ne mozete ponuditi sami sebi!");
	if(PlayerInfo[playerid][pMats] < kol) return ERROR(playerid,"Nemate toliko matsa!");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(targetid,x,y,z);
	if(!IsPlayerInRangeOfPoint(playerid,5.0,x,y,z)) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(cijena < 1) return ERROR(playerid,"Nemozete za manje od 1$!");
	PonudioM[targetid] = playerid; CijenaM[targetid] = cijena*kol; KolM[targetid] = kol;
	new str[300];
	format(str,sizeof(str),""zelena"Ponudili ste %dg matsa igracu %s za %d$!",kol,GetName(targetid),cijena*kol);
	SCM(playerid,-1,str);
	format(str,sizeof(str),""crvena"PRODAJA\n"bijela"Igrac "zelena"%s "bijela"vam je ponudio "zelena"%dg "bijela"matsa za "zelena"%d$\n"bijela"Da prihvatite upisite "zuta"PRIHVATI "bijela"sa velikim slovima!",GetName(playerid),kol,cijena*kol);
	ShowPlayerDialog(targetid,DIALOG_SELLMATSTO,DIALOG_STYLE_INPUT,""plava""IME" - Kupovina",str,"Dalje","Odustani");
	return 1;
}
//==============================================================================
CMD:stats(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    ShowStats(playerid,playerid);
	return 1;
}
//==============================================================================
CMD:me(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
	new txt[50];
	if(sscanf(params,"s[50]",txt)) return USAGE(playerid,"/me [Text]");
	Aktivnost(playerid,txt);
	return 1;
}
//==============================================================================
CMD:do(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
	new txt[50];
	if(sscanf(params,"s[50]",txt)) return USAGE(playerid,"/do [Text]");
	new str2[300],Float:x,Float:y,Float:z;
	new pnm[MAX_PLAYER_NAME];
	if(Marama[playerid]) { format(pnm,sizeof(pnm),"Stranac"); } else { format(pnm,sizeof(pnm),"%s",GetName(playerid)); }
    format(str2,sizeof(str2),"{FF6A6A}* %s (( %s ))",pnm,txt);
	GetPlayerPos(playerid,x,y,z);
	foreach(Player,i)
	{
	    if(Ulogovan[i] && IsPlayerInRangeOfPoint(i,20.0,x,y,z) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && GetPlayerInterior(i) == GetPlayerInterior(playerid)
	    && PlayerInfo[playerid][pUbizzu] == PlayerInfo[i][pUbizzu] && PlayerInfo[playerid][pUkuci] == PlayerInfo[i][pUkuci] && PlayerInfo[playerid][pUorg] == PlayerInfo[i][pUorg] && PlayerInfo[playerid][pUstanu] == PlayerInfo[i][pUstanu])
	    {
	        SCM(i,-1,str2);
	    }
	}
	return 1;
}
//==============================================================================
CMD:b(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
	new txt[100];
	if(sscanf(params,"s[100]",txt)) return USAGE(playerid,"/b [Text]");
	new str2[300],Float:x,Float:y,Float:z;
	new pnm[MAX_PLAYER_NAME];
	if(Marama[playerid]) { format(pnm,sizeof(pnm),"Stranac"); } else { format(pnm,sizeof(pnm),"%s",GetName(playerid)); }
    format(str2,sizeof(str2),"%s(%d) "bijela"(( "plava"OOC"bijela" )): "bijela"%s",pnm,playerid,txt);
	GetPlayerPos(playerid,x,y,z);
	foreach(Player,i)
	{
	    if(Ulogovan[i] && IsPlayerInRangeOfPoint(i,20.0,x,y,z) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && GetPlayerInterior(i) == GetPlayerInterior(playerid)
	    && PlayerInfo[playerid][pUbizzu] == PlayerInfo[i][pUbizzu] && PlayerInfo[playerid][pUkuci] == PlayerInfo[i][pUkuci] && PlayerInfo[playerid][pUorg] == PlayerInfo[i][pUorg] && PlayerInfo[playerid][pUstanu] == PlayerInfo[i][pUstanu])
	    {
	        SCM(i,GetPlayerColor(playerid),str2);
	    }
	}
	return 1;
}
//==============================================================================
CMD:s(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
	new txt[100];
	if(sscanf(params,"s[100]",txt)) return USAGE(playerid,"/s [Text]");
	new str2[300],Float:x,Float:y,Float:z;
	new pnm[MAX_PLAYER_NAME];
	if(Marama[playerid]) { format(pnm,sizeof(pnm),"Stranac"); } else { format(pnm,sizeof(pnm),"%s",GetName(playerid)); }
    format(str2,sizeof(str2),"%s(%d) "zuta"vice"bijela": "bijela"%s",pnm,playerid,txt);
	GetPlayerPos(playerid,x,y,z);
	foreach(Player,i)
	{
	    if(Ulogovan[i] && IsPlayerInRangeOfPoint(i,40.0,x,y,z) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && GetPlayerInterior(i) == GetPlayerInterior(playerid)
	    && PlayerInfo[playerid][pUbizzu] == PlayerInfo[i][pUbizzu] && PlayerInfo[playerid][pUkuci] == PlayerInfo[i][pUkuci] && PlayerInfo[playerid][pUorg] == PlayerInfo[i][pUorg] && PlayerInfo[playerid][pUstanu] == PlayerInfo[i][pUstanu])
	    {
	        SCM(i,GetPlayerColor(playerid),str2);
	    }
	}
	return 1;
}
//==============================================================================
CMD:w(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
	new txt[100],id;
	if(sscanf(params,"us[100]",id,txt)) return USAGE(playerid,"/w [Id/Ime][Text]");
	if(!IsPlayerConnected(id)) return ERROR(playerid,"Igrac nije u igri!");
	if(GetDistanceBetweenPlayers(playerid,id) > 5) return ERROR(playerid,"Nisite u blizini tog igraca!");
	if(playerid == id) return ERROR(playerid,"Nemozes saptati samome sebi!");
	new str2[300];
    format(str2,sizeof(str2),"%s(%d) "zelena"vam sapce"bijela": "bijela"%s",GetName(playerid),playerid,txt);
    SCM(id,GetPlayerColor(playerid),str2);
    format(str2,sizeof(str2),""zelena"Sapnuli ste igracu %s(%d): "bijela"%s",GetName(id),id,txt);
    SCM(playerid,-1,str2);
    format(str2,sizeof(str2),"sapce igracu %s.",GetName(id));
    Aktivnost(playerid,str2);
	return 1;
}
//==============================================================================
CMD:su(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(!PolicijaDuty[playerid]) return  ERROR(playerid,"Niste na duznosti!");
	new targetid,wl,razlog[50];
	if(sscanf(params,"uds[50]",targetid,wl,razlog)) return USAGE(playerid,"/su [Id/Ime][Level][Razlog]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Ne mozete dati wanted level samome sebi!");
	if(PlayerInfo[targetid][pOrgID] == POLICIJA) return ERROR(playerid,"Nemozete dati wl policajcu!");
	if(AdminDuty[targetid]) return ERROR(playerid,"Igrac je admin na duznosti!");
	PostaviZlocin(targetid,GetName(playerid),razlog,wl);
	new str[200];
	format(str,sizeof(str),"Policajac %s vam je dao %d wanted levela!(Razlog: %s)",GetName(playerid),wl,razlog);
	SCM(targetid,-1,str);
	format(str,sizeof(str),""smeda"Policijac "zelena"%s "smeda"je dao "zelena"%d "smeda"wl igracu "zelena"%s"smeda". "plava"(( Razlog: %s ))",GetName(playerid),wl,GetName(targetid),razlog);
	SendOrgMessage(playerid,str);
	new lgg[200];
	format(lgg,sizeof(lgg),"[SU] | Policajac %s | Igracu %s | Wl %d | Razlog %s |",GetName(playerid),GetName(targetid),wl,razlog);
	Log(POLICIJA_LOG,lgg);
	return 1;
}
//==============================================================================
CMD:cuff(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(!PolicijaDuty[playerid]) return  ERROR(playerid,"Niste na duznosti!");
	new targetid;
	if(sscanf(params,"u",targetid)) return USAGE(playerid,"/cuff [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Ne mozete staviti lisice samome sebi!");
	if(GetPlayerWL(targetid) == 0) return ERROR(playerid,"Igrac nema wanted levele!");
	if(AdminDuty[targetid]) return ERROR(playerid,"Igrac je admin na duznosti!");
	if(GetDistanceBetweenPlayers(playerid,targetid) > 5) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(!Tazed[targetid]) return ERROR(playerid,"Igrac nije tazovan!");
	if(IsPlayerInAnyVehicle(targetid)) return ERROR(playerid,"Igrac je u vozilu!");
	if(Vezan[targetid]) return ERROR(playerid,"Igrac je vezan! Koristite /odvezi!");
	if(ImaLisice[targetid]) return ERROR(playerid,"Igrac vec ima lisice!");
	SetPlayerAttachedObject(targetid, LISICE_SLOT, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977,-81.700035, 0.891999, 1.000000, 1.168000);
	SetPlayerSpecialAction(targetid,SPECIAL_ACTION_CUFFED);
	ImaLisice[targetid] = true;
	new str[50];
	format(str,sizeof(str),""plava"Policajac %s vam je stavio lisice!",GetName(playerid));
	SCM(targetid,-1,str);
	GameTextForPlayer(targetid,"~r~CUFFED",3000,3);
	return 1;
}
//==============================================================================
CMD:uncuff(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(!PolicijaDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new targetid;
	if(sscanf(params,"u",targetid)) return USAGE(playerid,"/uncuff [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Ne mozete samome sebi!");
	if(GetDistanceBetweenPlayers(playerid,targetid) > 5) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(!ImaLisice[targetid]) return ERROR(playerid,"Igrac nema lisice!");
	ImaLisice[targetid] = false;
	new str[50];
	format(str,sizeof(str),""plava"Policajac %s vam je skinuo lisice!",GetName(playerid));
	SCM(targetid,-1,str);
	if(IsPlayerAttachedObjectSlotUsed(playerid, LISICE_SLOT)) { RemovePlayerAttachedObject(playerid, LISICE_SLOT); }
 	SetPlayerSpecialAction(targetid,SPECIAL_ACTION_NONE);
 	GameTextForPlayer(targetid,"~r~UNCUFFED",3000,3);
	return 1;
}
//==============================================================================
CMD:vuci(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(!PolicijaDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new targetid;
	if(sscanf(params,"u",targetid)) return USAGE(playerid,"/vuci [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Ne mozete samome sebi!");
	if(AdminDuty[targetid]) return ERROR(playerid,"Igrac je admin na duznosti!");
	if(GetDistanceBetweenPlayers(playerid,targetid) > 5) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(!ImaLisice[targetid]) return ERROR(playerid,"Igrac nema lisice!");
	if(PolicajacKojiGaVuce[targetid] != -1) return ERROR(playerid,"Netko vec vuce tog igraca!");
 	new str[50];
	format(str,sizeof(str),""plava"Policajac %s vas je poceo vuci!",GetName(playerid));
	SCM(targetid,-1,str);
 	PolicajacKojiGaVuce[targetid] = playerid;
 	VuceTimer[targetid] = SetTimerEx("vuce",1000,true,"d",targetid);
	return 1;
}
//==============================================================================
CMD:prestanivuci(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(!PolicijaDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new targetid;
	if(sscanf(params,"u",targetid)) return USAGE(playerid,"/prestanivuci [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Ne mozete samome sebi!");
	if(GetDistanceBetweenPlayers(playerid,targetid) > 5) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(PolicajacKojiGaVuce[targetid] != playerid) return ERROR(playerid,"Ne vucete tog igraca!");
  	new str[50];
	format(str,sizeof(str),""plava"Policajac %s vas je prestao vuci!",GetName(playerid));
	SCM(targetid,-1,str);
 	PolicajacKojiGaVuce[targetid] = -1;
 	KillTimer(VuceTimer[targetid]);
	return 1;
}
//==============================================================================
CMD:ubaciuvozilo(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA || PlayerInfo[playerid][pAdmin] >= 1)
	{
		if(!AdminDuty[playerid]) { if(!PolicijaDuty[playerid]) return ERROR(playerid,"Niste na duznosti!"); }
		new targetid,mjesto;
		if(sscanf(params,"ud",targetid,mjesto)) return ERROR(playerid,"/ubaciuvozilo [Id/Ime][Sjediste]");
		if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
		if(targetid == playerid) return ERROR(playerid,"Ne mozete samome sebi!");
		if(!AdminDuty[playerid])
		{
			if(!ImaLisice[targetid]) return ERROR(playerid,"Igrac nema lisice!");
			if(AdminDuty[targetid]) return ERROR(playerid,"Igrac je admin na duznosti!");
		}
		else
		{
		    if(PlayerInfo[targetid][pAdmin] >= PlayerInfo[playerid][pAdmin]) return ERROR(playerid,"Ne mozete tog igraca!");
		    if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
		}
		if(mjesto == 0) return ERROR(playerid,"Nemozete ga ubaciti na mjesto vozaca!");
		if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u vozilu!");
		if(GetDistanceBetweenPlayers(playerid,targetid) > 5) return ERROR(playerid,"Niste u blizini tog igraca!");
		new str[50];
		if(!AdminDuty[playerid]) { format(str,sizeof(str),""plava"Policajac %s vas je ubacio u vozilo!",GetName(playerid)); }
		else { format(str,sizeof(str),""zuta"Admin %s vas je ubacio u vozilo!",GetName(playerid)); }
		SCM(targetid,-1,str);
	 	PutPlayerInVehicle(targetid,GetPlayerVehicleID(playerid),mjesto);
	}
	else { ERROR(playerid,"Niste policajac!"); }
	return 1;
}
//==============================================================================
CMD:izbaciizvozila(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new targetid;
	if(sscanf(params,"u",targetid)) return USAGE(playerid,"/izbaciizvozila [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Ne mozete samome sebi!");
	if(AdminDuty[targetid]) return ERROR(playerid,"Igrac je admin na duznosti!");
	if(!IsPlayerInAnyVehicle(targetid)) return ERROR(playerid,"Igrac nije u vozilu!");
	if(GetPlayerVehicleID(targetid) != GetPlayerVehicleID(playerid)) return ERROR(playerid,"Igrac nije u vasem vozilu!");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ERROR(playerid,"Niste na mjestu vozaca!");
	new str[50];
	format(str,sizeof(str),""bijela"Igrac %s vas je izbacio iz vozila!",GetName(playerid));
	SCM(targetid,-1,str);
 	RemovePlayerFromVehicle(targetid);
	return 1;
}
CMD:eject(playerid,params[]) return cmd_izbaciizvozila(playerid,params);
//==============================================================================
CMD:uhapsi(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(!PolicijaDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new targetid;
	if(sscanf(params,"u",targetid)) return USAGE(playerid,"/uhapsi [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Ne mozete samome sebi!");
	if(AdminDuty[targetid]) return ERROR(playerid,"Igrac je admin na duznosti!");
	if(!IsPlayerInRangeOfPoint(playerid,5,247.2204,86.7935,1003.6406)) return ERROR(playerid,"Niste na mjestu za hapsenje.");
	if(GetDistanceBetweenPlayers(playerid,targetid) > 5) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(!ImaLisice[targetid]) return ERROR(playerid,"Igrac nema lisice!");
	if(PlayerInfo[targetid][pOrgID] == POLICIJA) return ERROR(playerid,"Nemozete uhapsiti policajca.");
	if(GetPlayerWL(targetid) < 1) return ERROR(playerid,"Igrac nema wanted levele.");
	SetPlayerSpecialAction(targetid,SPECIAL_ACTION_NONE);
	ImaLisice[targetid] = false;
	new time = (GetPlayerWL(targetid)*5) + 20;
 	if(IsPlayerAttachedObjectSlotUsed(playerid, LISICE_SLOT)) { RemovePlayerAttachedObject(playerid, LISICE_SLOT); }
	PlayerInfo[targetid][pZatvoren] = true;
	PlayerInfo[targetid][pVrijeme] = time;
	SetPlayerPos(targetid,268.4124,78.2123,1001.0391);
	SetPlayerVirtualWorld(targetid,9);
	SetPlayerInterior(targetid,6);
	PlayerInfo[targetid][pUorg] = POLICIJA;
	Freeze(targetid);
	GameTextForPlayer(targetid,"~r~ARRESTED",5000,3);
	ZatvorTimer[targetid] = SetTimerEx("zatvor",1000,true,"d",targetid);
	SetPlayerWantedLevel(targetid,0);
	PolicajacKojiGaVuce[targetid] = -1;
 	KillTimer(VuceTimer[targetid]);
 	new lgg[200];
	format(lgg,sizeof(lgg),"[HAPSENJE] | Policajac %s | Igraca %s | Wl %d |",GetName(playerid),GetName(targetid),GetPlayerWL(targetid));
	Log(POLICIJA_LOG,lgg);
 	OcistiDosije(targetid);
 	ResetPlayerWeapons(targetid);
 	PlayerInfo[targetid][pDroga] = 0;
    PlayerInfo[targetid][pMats] = 0;
    PlayerInfo[targetid][pBankMoney] += PlayerInfo[targetid][pMoney];
    PlayerInfo[targetid][pMoney] = 0;
    PlayerInfo[targetid][pSjemeDroge] = 0;
    PlayerInfo[targetid][pDinamit] = 0;
    ResetPlayerMoney(targetid);
	AdminDuty[targetid] = false;
    GameMasterDuty[targetid] = false;
 	new str[100];
 	format(str,sizeof(str),""plava"[ZATVOR] Policajac %s je uhapsio igraca %s.",GetName(playerid),GetName(targetid));
 	foreach(Player,i) { SCM(i,-1,str); }
 	GivePlayerMoney(playerid,10000);
 	PlayerInfo[playerid][pMoney] += 10000;
 	SacuvajIgraca(targetid);
 	SacuvajIgraca(playerid);
	return 1;
}
//==============================================================================
CMD:pdduznost(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(AdminDuty[playerid]) return ERROR(playerid,"Ne mozete kad ste na admin duznosti!");
	if(GameMasterDuty[playerid]) return ERROR(playerid,"Ne mozete kad ste na gamemaster duznosti!");
   	if(IsPlayerInRangeOfPoint(playerid,2,257.0870,76.1152,1003.6406))
	{
		if(!PolicijaDuty[playerid])
		{
		    PolicijaDuty[playerid] = true;
		    new str[100];
			format(str,sizeof(str),""plava"Policajac %s je na duznosti.",GetName(playerid));
		    SendOrgMessage(playerid,str);
		    GivePlayerWeapon(playerid,3,1);
		    return 1;
		}
		else if(PolicijaDuty[playerid])
		{
		    PolicijaDuty[playerid] = false;
		    new str[100];
		    format(str,sizeof(str),""plava"Policajac %s vise nije na duznosti.",GetName(playerid));
		    SendOrgMessage(playerid,str);
		    ResetPlayerWeapons(playerid);
		    SetPlayerArmour(playerid,0.0);
		    Tazer[playerid] = false;
		}
 	}
	else { ERROR(playerid,"Niste kod mjesta za uzimanje duznosti."); return 1; }
	return 1;
}
//==============================================================================
CMD:lociraj(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(!PolicijaDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(Radi[playerid]) return ERROR(playerid,"Radite!");
	if(GPSON[playerid]) return ERROR(playerid,"Vec imate ukljucen gps! Da ga iskljucite koristite '/gpsoff'.");
	if(polaganje[playerid] != -1) return ERROR(playerid,"Imate ukljuceno polaganje!");
	new targetid;
	if(sscanf(params,"u",targetid)) return USAGE(playerid,"/lociraj [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Ne mozete samoga sebe!");
	if(GetPlayerWL(targetid) == 0) return ERROR(playerid,"Igrac nije pocinio zlocin!");
    if(!PlayerInfo[targetid][pMobitel]) return ERROR(playerid,"Igrac nema mobitel!");
	if(!PlayerInfo[targetid][pMobitelUkljucen]) return ERROR(playerid,"Igrac ima iskljucen mobitel!");
	GPSON[playerid] = true;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(targetid,x,y,z);
	SetPlayerCheckpoint(playerid,x,y,z,4.0);
	new str[100];
	format(str,sizeof(str),""bijela"Locirali ste igraca %s!",GetName(targetid));
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:najava(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(!PolicijaDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(PlayerInfo[playerid][pRank] < 5) return ERROR(playerid,"Samo zapovijednik i zamjenik!");
	if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
	new txt[100];
	if(sscanf(params,"s[100]",txt)) return USAGE(playerid,"/najava [Tekst]");
	new str[150];
	if(PlayerInfo[playerid][pRank] == 6)
	{ format(str,sizeof(str),""plava"Zapovijednik policije %s: "bijela"%s",GetName(playerid),txt); }
	else { format(str,sizeof(str),""plava"Zamjenik zapovijednika policije %s: "bijela"%s",GetName(playerid),txt); }
	foreach(Player,i)
	{
	    SCM(i,-1,"|--------------------------------------------------------------------------------------|");
	    SCM(i,-1,"|----------------------------------POLICIJSKA OBAVIJEST--------------------------------|");
	    SCM(i,-1,"|--------------------------------------------------------------------------------------|");
        SCM(i,-1,str);
        SCM(i,-1,"|--------------------------------------------------------------------------------------|");
	    SCM(i,-1,"|--------------------------------------------------------------------------------------|");
	    SCM(i,-1,"|--------------------------------------------------------------------------------------|");
	}
	new lgg[200];
	format(lgg,sizeof(lgg),"[NAJAVA] | Policajac %s | %s |",GetName(playerid),txt);
	Log(POLICIJA_LOG,lgg);
	return 1;
}
//==============================================================================
CMD:megafon(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(!PolicijaDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
	new txt[100];
	if(sscanf(params,"s[100]",txt)) return USAGE(playerid,"/megafon [Tekst]");
    new str2[300],Float:x,Float:y,Float:z;
    format(str2,sizeof(str2),""zuta"Megafon: "plava"%s",txt);
	GetPlayerPos(playerid,x,y,z);
	foreach(Player,i)
	{
	    if(Ulogovan[i] && IsPlayerInRangeOfPoint(i,100.0,x,y,z) && GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && GetPlayerInterior(i) == GetPlayerInterior(playerid)
	    && PlayerInfo[playerid][pUbizzu] == PlayerInfo[i][pUbizzu] && PlayerInfo[playerid][pUkuci] == PlayerInfo[i][pUkuci] && PlayerInfo[playerid][pUorg] == PlayerInfo[i][pUorg] && PlayerInfo[playerid][pUstanu] == PlayerInfo[i][pUstanu])
	    {
	        SCM(i,GetPlayerColor(playerid),str2);
	    }
	}
	return 1;
}
//==============================================================================
CMD:pretresi(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(!PolicijaDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
    new targetid;
	if(sscanf(params, "u", targetid)) return USAGE(playerid,"/pretresi [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Ne mozete samome sebi!");
	if(AdminDuty[targetid]) return ERROR(playerid,"Igrac je admin na duznosti!");
	if(GetDistanceBetweenPlayers(playerid,targetid) > 3) return ERROR(playerid,"Niste u blizini tog igraca!");
	new str1[200],winfo[24],weap,ammo,x=-1;
	for (new i = 0; i <= 12; i++)
	{
		GetPlayerWeaponData(targetid, i, weap,ammo);
		if(weap != -1 && weap != 0 && weap != 2 && weap != 7)
		{
		    winfo = ""zelena"Da";
			x = 1;
			break;
		}
	}
	if(x == -1) { winfo = ""crvena"Ne"; }
	format(str1,sizeof(str1),""plava"Droga: "bijela"%dg\n"plava"Mats: "bijela"%dg\n"plava"Oruzje: "bijela"%s\n"plava"Sjeme droge: "bijela"%d\n"plava"Dinamit: "bijela"%d",PlayerInfo[targetid][pDroga],PlayerInfo[targetid][pMats],winfo,PlayerInfo[playerid][pSjemeDroge],PlayerInfo[playerid][pDinamit]);
	ShowPlayerDialog(playerid,DIALOG_PRETRESANJE,DIALOG_STYLE_MSGBOX,""plava"Pretresanje:",str1,""plava"Ok","");
	new str[150];
	format(str, sizeof(str), "pretresa igraca %s.", GetName(targetid));
	Aktivnost(playerid,str);
	return 1;
}
//==============================================================================
CMD:oduzmi(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(!PolicijaDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new id, broj;
	if(sscanf(params, "ud", id, broj))
	{
		USAGE(playerid,"/oduzmi [Id/Ime][Broj]!");
		INFO(playerid,"| 1. Droga | 2. Mats | 3. Oruzje | 4. Vozacka |");
		INFO(playerid,"| 5. Dozvola za oruzje | 6. Dozvola za motor | 7. Dozvola za kamion |");
		INFO(playerid,"| 8. Dozvola za brod | 9. Dozvola za letjelice | 10. Sjeme droge |");
        INFO(playerid,"| 11. Dinamit | ");
		return 1;
	}
	if(!IsPlayerConnected(id)) return ERROR(playerid,"Taj igrac nije u igri!");
	if(id == playerid) return ERROR(playerid,"Ne mozete samome sebi!");
	if(AdminDuty[id]) return ERROR(playerid,"Igrac je admin na duznosti!");
	if(GetDistanceBetweenPlayers(playerid,id) > 3) return ERROR(playerid,"Niste u blizini tog igraca!");
	new str[200];
	if(broj == 1)
	{
		PlayerInfo[id][pDroga] = 0;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""bijela"Igracu %s ste oduzeli drogu!", GetName(id));
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""plava"Policajac %s vam je oduzeo drogu!", GetName(playerid));
		SCM(id, -1, str);
	}
	else if(broj == 2)
	{
		PlayerInfo[id][pMats] = 0;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""bijela"Igracu %s ste oduzeli mats!", GetName(id));
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""plava"Policajac %s vam je oduzeo mats!", GetName(playerid));
		SCM(id, -1, str);
	}
	else if(broj == 3)
	{
		ResetPlayerWeapons(id);
		SacuvajIgraca(id);
		format(str, sizeof(str), ""bijela"Igracu %s ste oduzeli oruzje!", GetName(id));
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""plava"Policajac %s vam je oduzeo oruzje!", GetName(playerid));
		SCM(id, -1, str);
		new dtxt[24];
		if(PlayerInfo[id][pOruzjeDozvola]) { dtxt = "Da"; } else { dtxt = "Ne"; }
		new lgg[200];
		format(lgg,sizeof(lgg),"[ODUZIMANJE] | Policajac %s | Igracu %s | Oruzje | Igrac imao dozvolu %s |",GetName(playerid),GetName(id),dtxt);
		Log(POLICIJA_LOG,lgg);
	}
	else if(broj == 4)
	{
	    new razlog[70];
	    if(sscanf(params, "uds[70]", id, broj, razlog))
		{
			USAGE(playerid,"/oduzmi [Id/Ime][Broj][Razlog]!");
			return 1;
		}
		PlayerInfo[id][pVozackaDozvola] = false;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""bijela"Igracu %s ste oduzeli vozacku (Razlog: %s)!", GetName(id), razlog);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""plava"Policajac %s vam je oduzeo vozacku (Razlog: %s)!", GetName(playerid), razlog);
		SCM(id, -1, str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[ODUZIMANJE] | Policajac %s | Igracu %s | Vozacku | Razlog %s |",GetName(playerid),GetName(id), razlog);
		Log(POLICIJA_LOG,lgg);
	}
	else if(broj == 5)
	{
	    new razlog[70];
	    if(sscanf(params, "uds[70]", id, broj, razlog))
		{
			USAGE(playerid,"/oduzmi [Id/Ime][Broj][Razlog]!");
			return 1;
		}
		PlayerInfo[id][pOruzjeDozvola] = false;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""bijela"Igracu %s ste oduzeli dozvolu za oruzje (Razlog: %s)!", GetName(id),razlog);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""plava"Policajac %s vam je oduzeo dozvolu za oruzje (Razlog: %s)!", GetName(playerid), razlog);
		SCM(id, -1, str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[ODUZIMANJE] | Policajac %s | Igracu %s | Dozvola za oruzje | Razlog %s|",GetName(playerid),GetName(id), razlog);
		Log(POLICIJA_LOG,lgg);
	}
	else if(broj == 6)
	{
	    new razlog[70];
	    if(sscanf(params, "uds[70]", id, broj, razlog))
		{
			USAGE(playerid,"/oduzmi [Id/Ime][Broj][Razlog]!");
			return 1;
		}
		PlayerInfo[id][pMotorDozvola] = false;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""bijela"Igracu %s ste oduzeli dozvolu za motor (Razlog: %s)!", GetName(id),razlog);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""plava"Policajac %s vam je oduzeo dozvolu za motor (Razlog: %s)!", GetName(playerid), razlog);
		SCM(id, -1, str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[ODUZIMANJE] | Policajac %s | Igracu %s | Dozvola za motor | Razlog %s|",GetName(playerid),GetName(id), razlog);
		Log(POLICIJA_LOG,lgg);
	}
	else if(broj == 7)
	{
	    new razlog[70];
	    if(sscanf(params, "uds[70]", id, broj, razlog))
		{
			USAGE(playerid,"/oduzmi [Id/Ime][Broj][Razlog]!");
			return 1;
		}
		PlayerInfo[id][pKamionDozvola] = false;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""bijela"Igracu %s ste oduzeli dozvolu za kamion (Razlog: %s)!", GetName(id),razlog);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""plava"Policajac %s vam je oduzeo dozvolu za kamion (Razlog: %s)!", GetName(playerid), razlog);
		SCM(id, -1, str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[ODUZIMANJE] | Policajac %s | Igracu %s | Dozvola za kamion | Razlog %s|",GetName(playerid),GetName(id), razlog);
		Log(POLICIJA_LOG,lgg);
	}
	else if(broj == 8)
	{
	    new razlog[70];
	    if(sscanf(params, "uds[70]", id, broj, razlog))
		{
			USAGE(playerid,"/oduzmi [Id/Ime][Broj][Razlog]!");
			return 1;
		}
		PlayerInfo[id][pBrodDozvola] = false;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""bijela"Igracu %s ste oduzeli dozvolu za brod (Razlog: %s)!", GetName(id),razlog);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""plava"Policajac %s vam je oduzeo dozvolu za brod (Razlog: %s)!", GetName(playerid), razlog);
		SCM(id, -1, str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[ODUZIMANJE] | Policajac %s | Igracu %s | Dozvola za brod | Razlog %s|",GetName(playerid),GetName(id), razlog);
		Log(POLICIJA_LOG,lgg);
	}
	else if(broj == 9)
	{
	    new razlog[70];
	    if(sscanf(params, "uds[70]", id, broj, razlog))
		{
			USAGE(playerid,"/oduzmi [Id/Ime][Broj][Razlog]!");
			return 1;
		}
		PlayerInfo[id][pLetjeliceDozvola] = false;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""bijela"Igracu %s ste oduzeli dozvolu za letjelice (Razlog: %s)!", GetName(id),razlog);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""plava"Policajac %s vam je oduzeo dozvolu za letjelice (Razlog: %s)!", GetName(playerid), razlog);
		SCM(id, -1, str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[ODUZIMANJE] | Policajac %s | Igracu %s | Dozvola za letjelice | Razlog %s|",GetName(playerid),GetName(id), razlog);
		Log(POLICIJA_LOG,lgg);
	}
	else if(broj == 10)
	{
	    new razlog[70];
	    if(sscanf(params, "uds[70]", id, broj, razlog))
		{
			USAGE(playerid,"/oduzmi [Id/Ime][Broj][Razlog]!");
			return 1;
		}
		PlayerInfo[id][pSjemeDroge] = 0;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""bijela"Igracu %s ste oduzeli sjeme za drogu!", GetName(id),razlog);
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""plava"Policajac %s vam je oduzeo sjeme za drogu!", GetName(playerid), razlog);
		SCM(id, -1, str);
	}
	else if(broj == 11)
	{
		PlayerInfo[id][pDinamit] = 0;
		SacuvajIgraca(id);
		format(str, sizeof(str), ""bijela"Igracu %s ste oduzeli dinamit!", GetName(id));
		SCM(playerid, -1, str);
		format(str, sizeof(str), ""plava"Policajac %s vam je oduzeo dinamit!", GetName(playerid));
		SCM(id, -1, str);
	}
	else return USAGE(playerid,"/oduzmi [Id/Ime][Broj]!");
	return 1;
}
//==============================================================================
CMD:pdoprema(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(!PolicijaDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
   	if(IsPlayerInRangeOfPoint(playerid,2,257.0870,76.1152,1003.6406))
	{
	    ShowPlayerDialog(playerid,DIALOG_POLICIJA_OPREMA,DIALOG_STYLE_LIST,""plava""IME" - Oprema:",""bijela"Armor\n"plava"Tazer\n"bijela"Prometni policajac(Rank 1)\n"plava"Undercover(Rank 2)\n"bijela"S.W.A.T(Rank 3)\n"plava"FBI(Rank 4)\n"bijela"Zamjenik zapovijednika(Rank 5)\n"plava"Zapovijednik(Rank 6)","Uzmi","Odustani");
	}
	else { ERROR(playerid,"Niste kod mjesta za uzimanje opreme!"); return 1; }
	return 1;
}
//==============================================================================
CMD:orginfo(playerid,params[])
{
 	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
	if(!PolicijaDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
    if(PlayerInfo[playerid][pRank] >= 5 || PlayerInfo[playerid][pAdmin] >= 6)
    {
		new str[500],str1[700];
		format(str,sizeof(str),""smeda"Clanovi: "bijela"%d\n",OrgInfo2[POLICIJA][oClanovi]);
		strcat(str1,str);
        format(str,sizeof(str),""plava".........................................\n");
		strcat(str1,str);
		format(str,sizeof(str),""smeda"Rank 1: "plava"Prometni policajac\n");
		strcat(str1,str);
		format(str,sizeof(str),""smeda"Rank 2: "plava"Undercover policajac\n");
		strcat(str1,str);
		format(str,sizeof(str),""smeda"Rank 3: "plava"S.W.A.T policajac\n");
		strcat(str1,str);
		format(str,sizeof(str),""smeda"Rank 4: "plava"FBI policajac\n");
		strcat(str1,str);
		format(str,sizeof(str),""smeda"Rank 5: "plava"Zamijenik zapovijednika\n");
		strcat(str1,str);
		format(str,sizeof(str),""smeda"Rank 6: "plava"Zapovijednik\n");
		strcat(str1,str);
		ShowPlayerDialog(playerid,DIALOG_SEF7,DIALOG_STYLE_MSGBOX,""smeda""IME" - Informacije o policiji:",str1,"Ok","");
	}
	else
	{
	    ERROR(playerid,"Niste ovlasteni!");
	}
	return 1;
}
//==============================================================================
CMD:kupidozvoluo(playerid,params[])
{
	#pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOruzjeDozvola]) return ERROR(playerid,"Vec imate dozvolu za oruzje!");
   	if(IsPlayerInRangeOfPoint(playerid,2,249.7552,69.3670,1003.6406))
	{
        if(GetPlayerMoney(playerid) >= 200000 || PlayerInfo[playerid][pBankMoney] >= 200000)
		{
			Placanje(playerid,-1,200000);
		}
		else return ERROR(playerid,"Nemate dovoljno novca!");
        PlayerInfo[playerid][pOruzjeDozvola] = true;
        INFO(playerid,"Uspjesno ste kupili dozvolu za oruzje!");
	}
	else { ERROR(playerid,"Niste kod mjesta za kupovinu dozvole!"); return 1; }
	return 1;
}
//==============================================================================
CMD:polaganje(playerid,params[])
{
    #pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
   	if(IsPlayerInRangeOfPoint(playerid,2,-2033.4346,-117.4143,1035.1719) && GetPlayerVirtualWorld(playerid) == 10)
   	{
		ShowPlayerDialog(playerid,DIALOG_AUTOSKOLA,DIALOG_STYLE_TABLIST_HEADERS,""zelena""IME" - Polaganje: "bijela"Izaberite kategoriju:","Kategorija\tCijena \
		\n"bijela"Vozacka dozvola\t30000$\n"zelena"Dozvola za motor\t 15000$\n"bijela"Dozvola za kamion\t50000$\n"zelena"Dozvola za brod\t100000$\n"bijela"Dozvola ta letjelice\t500000$","Polaganje","Odustani");
	}
	else { ERROR(playerid,"Niste u autoskoli!"); return 1; }
	return 1;
}
//==============================================================================
CMD:prekinipolaganje(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(polaganje[playerid] == -1)  return ERROR(playerid,"Ne polazete!");
	DisablePlayerCheckpoint(playerid);
	GameTextForPlayer(playerid,"~g~Prekinuli ste polaganje!",3500,3);
	SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
 	SetPlayerFacingAngle(playerid,9.0473);
	SetPlayerVirtualWorld(playerid,10);
	SetPlayerInterior(playerid,3);
	Freeze(playerid);
	if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
	{
		DestroyVehicle(PolaganjeVehicle[playerid]);
		PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
	}
	polaganje[playerid] = -1;
	PolaganjeVrsta[playerid] = -1;
	return 1;
}
//==============================================================================
CMD:sl(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new targetid;
	if(sscanf(params, "u", targetid)) return USAGE(playerid,"/sl [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Koristite /dozvole!");
	new str[400],otxt[24],vtxt[24],mtxt[24],ktxt[24],btxt[24],ltxt[24];
	if(PlayerInfo[playerid][pOruzjeDozvola]) { otxt = ""zelena"Da"; } else { otxt = ""crvena"Ne"; }
	if(PlayerInfo[playerid][pVozackaDozvola]) { vtxt = ""zelena"Da"; } else { vtxt = ""crvena"Ne"; }
	if(PlayerInfo[playerid][pMotorDozvola]) { mtxt = ""zelena"Da"; } else { mtxt = ""crvena"Ne"; }
	if(PlayerInfo[playerid][pKamionDozvola]) { ktxt = ""zelena"Da"; } else { ktxt = ""crvena"Ne"; }
	if(PlayerInfo[playerid][pBrodDozvola]) { btxt = ""zelena"Da"; } else { btxt = ""crvena"Ne"; }
	if(PlayerInfo[playerid][pLetjeliceDozvola]) { ltxt = ""zelena"Da"; } else { ltxt = ""crvena"Ne"; }
	format(str,sizeof(str),""plava"Dozvole igraca "zuta"%s\n"plava"Dozvola za oruzje: "bijela"%s\n"plava"Vozacka dozvola: "bijela"%s\n"plava"Dozvola za motor: "bijela"%s \
	\n"plava"Dozvola za kamion: "bijela"%s\n"plava"Dozvola za brod: "bijela"%s\n"plava"Dozvola za letjelice: "bijela"%s",GetName(playerid),otxt,vtxt,mtxt,ktxt,btxt,ltxt);
	ShowPlayerDialog(targetid,DIALOG_STATS,DIALOG_STYLE_MSGBOX,""plava""IME" - Dozvole:",str,""bijela"Ok","");
	format(str, sizeof(str), "Pokazali ste dozvole igracu %s!.", GetName(targetid));
	INFO(playerid,str);
	format(str, sizeof(str), "je pokazao dozvole igracu %s.", GetName(targetid));
	Aktivnost(playerid,str);
	return 1;
}
//==============================================================================
CMD:dozvole(playerid, params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new str[400],otxt[24],vtxt[24],mtxt[24],ktxt[24],btxt[24],ltxt[24];
	if(PlayerInfo[playerid][pOruzjeDozvola]) { otxt = ""zelena"Da"; } else { otxt = ""crvena"Ne"; }
	if(PlayerInfo[playerid][pVozackaDozvola]) { vtxt = ""zelena"Da"; } else { vtxt = ""crvena"Ne"; }
	if(PlayerInfo[playerid][pMotorDozvola]) { mtxt = ""zelena"Da"; } else { mtxt = ""crvena"Ne"; }
	if(PlayerInfo[playerid][pKamionDozvola]) { ktxt = ""zelena"Da"; } else { ktxt = ""crvena"Ne"; }
	if(PlayerInfo[playerid][pBrodDozvola]) { btxt = ""zelena"Da"; } else { btxt = ""crvena"Ne"; }
	if(PlayerInfo[playerid][pLetjeliceDozvola]) { ltxt = ""zelena"Da"; } else { ltxt = ""crvena"Ne"; }
	format(str,sizeof(str),""plava"Dozvole igraca "zuta"%s\n"plava"Dozvola za oruzje: "bijela"%s\n"plava"Vozacka dozvola: "bijela"%s\n"plava"Dozvola za motor: "bijela"%s \
	\n"plava"Dozvola za kamion: "bijela"%s\n"plava"Dozvola za brod: "bijela"%s\n"plava"Dozvola za letjelice: "bijela"%s",GetName(playerid),otxt,vtxt,mtxt,ktxt,btxt,ltxt);
	ShowPlayerDialog(playerid,DIALOG_STATS,DIALOG_STYLE_MSGBOX,""plava""IME" - Dozvole:",str,""bijela"Ok","");
	return 1;
}
//==============================================================================
CMD:asl(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] < 1) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new targetid;
	if(sscanf(params, "u", targetid)) return USAGE(playerid,"/asl [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
	if((PlayerInfo[playerid][pAdmin] < PlayerInfo[targetid][pAdmin]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
	if((PlayerInfo[playerid][pGameMaster] < PlayerInfo[targetid][pGameMaster]) && !PlayerInfo[targetid][pKomandeSlabijih]) return ERROR(playerid,"Igrac je iskljucio komande slabijih!");
	if(targetid == playerid) return ERROR(playerid,"Koristite /dozvole!");
	new str[400],otxt[24],vtxt[24],mtxt[24],ktxt[24],btxt[24],ltxt[24];
	if(PlayerInfo[targetid][pOruzjeDozvola]) { otxt = ""zelena"Da"; } else { otxt = ""crvena"Ne"; }
	if(PlayerInfo[targetid][pVozackaDozvola]) { vtxt = ""zelena"Da"; } else { vtxt = ""crvena"Ne"; }
	if(PlayerInfo[targetid][pMotorDozvola]) { mtxt = ""zelena"Da"; } else { mtxt = ""crvena"Ne"; }
	if(PlayerInfo[targetid][pKamionDozvola]) { ktxt = ""zelena"Da"; } else { ktxt = ""crvena"Ne"; }
	if(PlayerInfo[targetid][pBrodDozvola]) { btxt = ""zelena"Da"; } else { btxt = ""crvena"Ne"; }
	if(PlayerInfo[targetid][pLetjeliceDozvola]) { ltxt = ""zelena"Da"; } else { ltxt = ""crvena"Ne"; }
	format(str,sizeof(str),""plava"Dozvole igraca "zuta"%s\n"plava"Dozvola za oruzje: "bijela"%s\n"plava"Vozacka dozvola: "bijela"%s\n"plava"Dozvola za motor: "bijela"%s \
	\n"plava"Dozvola za kamion: "bijela"%s\n"plava"Dozvola za brod: "bijela"%s\n"plava"Dozvola za letjelice: "bijela"%s",GetName(targetid),otxt,vtxt,mtxt,ktxt,btxt,ltxt);
	ShowPlayerDialog(playerid,DIALOG_STATS,DIALOG_STYLE_MSGBOX,""plava""IME" - Dozvole:",str,""bijela"Ok","");
	return 1;
}
//==============================================================================
CMD:ss(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new targetid;
	if(sscanf(params, "u", targetid)) return USAGE(playerid,"/sl [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Koristite /stats!");
	ShowStats(targetid,playerid);
	new str[200];
	format(str, sizeof(str), "Pokazali ste stats igracu %s!.", GetName(targetid));
	INFO(playerid,str);
	format(str, sizeof(str), "je pokazao stats igracu %s.", GetName(targetid));
	Aktivnost(playerid,str);
	return 1;
}
//==============================================================================
CMD:pay(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new targetid,novac;
	if(sscanf(params,"ud",targetid,novac)) return USAGE(playerid,"/pay [Id/Ime][Kolicina]");
	if(novac > GetPlayerMoney(playerid)) return ERROR(playerid,"Nemate toliko novca kod sebe!");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(playerid == targetid) return ERROR(playerid,"Ne mozete dati novac samome sebi!");
	if(GetDistanceBetweenPlayers(playerid,targetid) > 5) return ERROR(playerid,"Nisi u blizini tog igraca!");
	if(novac < 1) return ERROR(playerid,"Ne mozete mu dati manje od 1$!");
	GivePlayerMoney(playerid,-novac);
	PlayerInfo[playerid][pMoney] -= novac;
	GivePlayerMoney(targetid,novac);
	PlayerInfo[targetid][pMoney] += novac;
	new str[100];
	format(str,sizeof(str),""bijela"Dali ste igracu %s %d$.",GetName(targetid),novac);
	SCM(playerid,-1,str);
	format(str,sizeof(str),""bijela"Igrac %s vam je dao %d$.",GetName(playerid),novac);
	SCM(targetid,-1,str);
	format(str,sizeof(str),"je dao novac igracu %s.",GetName(targetid));
	Aktivnost(playerid,str);
	format(str,sizeof(str),"[NOVAC] | Igrac %s | Dao igracu %s | Kolicina %d$ |",GetName(playerid),GetName(targetid),novac);
	Log(DAJ_LOG,str);
	return 1;
}
//==============================================================================
CMD:daj(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new targetid,opcija[24],kolicina,str[200];
	if(sscanf(params,"us[24]d",targetid,opcija,kolicina))
	{
		USAGE(playerid,"/daj [Id/Ime][Opcija][Kolicina]!");
        INFO(playerid,"Opcije: mats, droga, cigarete, upaljac, oruzje, drogasjeme, dinamit");
		return 1;
	}
 	if(kolicina < 1) return ERROR(playerid,"Ne mozete mu dati manje od 1!");
    if(GetDistanceBetweenPlayers(playerid,targetid) > 5) return ERROR(playerid,"Niste u blizini tog igraca!");
    if(playerid == targetid) return ERROR(playerid,"Ne mozete dati samome sebi!");
    if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(!strcmp(opcija,"mats",true))
	{
        if(kolicina > PlayerInfo[playerid][pMats]) return ERROR(playerid,"Nemate toliko matsa!");
        new string6[30];
		PlayerInfo[playerid][pMats] -= kolicina;
		format(string6,sizeof(string6),"~r~-%dg matsa",kolicina);
  		GameTextForPlayer(playerid, string6, 3000, 1);
		PlayerInfo[targetid][pMats] += kolicina;
		format(string6,sizeof(string6),"~g~+%dg matsa",kolicina);
  		GameTextForPlayer(targetid, string6, 3000, 1);
		format(str,sizeof(str),""bijela"Dali ste igracu %s %dg matsa.",GetName(targetid),kolicina);
		SCM(playerid,-1,str);
		format(str,sizeof(str),""bijela"Igrac %s vam je dao %dg matsa.",GetName(playerid),kolicina);
		SCM(targetid,-1,str);
		format(str,sizeof(str),"je dao mats igracu %s.",GetName(targetid));
		Aktivnost(playerid,str);
		SacuvajIgraca(playerid);
		SacuvajIgraca(targetid);
		format(str,sizeof(str),"[MATS] | Igrac %s | Dao igracu %s | Kolicina %dg |",GetName(playerid),GetName(targetid),kolicina);
		Log(DAJ_LOG,str);
	}
	else if(!strcmp(opcija,"droga",true))
	{
        if(kolicina > PlayerInfo[playerid][pDroga]) return ERROR(playerid,"Nemate toliko droge!");
        new string6[30];
		PlayerInfo[playerid][pDroga] -= kolicina;
		format(string6,sizeof(string6),"~r~-%dg droge",kolicina);
  		GameTextForPlayer(playerid, string6, 3000, 1);
		PlayerInfo[targetid][pDroga] += kolicina;
		format(string6,sizeof(string6),"~g~+%dg droge",kolicina);
  		GameTextForPlayer(targetid, string6, 3000, 1);
		format(str,sizeof(str),""bijela"Dali ste igracu %s %dg droge.",GetName(targetid),kolicina);
		SCM(playerid,-1,str);
		format(str,sizeof(str),""bijela"Igrac %s vam je dao %dg droge.",GetName(playerid),kolicina);
		SCM(targetid,-1,str);
		format(str,sizeof(str),"je dao drogu igracu %s.",GetName(targetid));
		Aktivnost(playerid,str);
		SacuvajIgraca(playerid);
		SacuvajIgraca(targetid);
		format(str,sizeof(str),"[DROGA] | Igrac %s | Dao igracu %s | Kolicina %dg |",GetName(playerid),GetName(targetid),kolicina);
		Log(DAJ_LOG,str);
	}
    else if(!strcmp(opcija,"cigarete",true))
	{
        if(kolicina > PlayerInfo[playerid][pCigarete]) return ERROR(playerid,"Nemate toliko cigareta!");
        new string6[30];
		PlayerInfo[playerid][pCigarete] -= kolicina;
		format(string6,sizeof(string6),"~r~-%d droge",kolicina);
  		GameTextForPlayer(playerid, string6, 3000, 1);
		PlayerInfo[targetid][pCigarete] += kolicina;
		format(string6,sizeof(string6),"~g~+%d droge",kolicina);
  		GameTextForPlayer(targetid, string6, 3000, 1);
		format(str,sizeof(str),""bijela"Dali ste igracu %s %d cigareta.",GetName(targetid),kolicina);
		SCM(playerid,-1,str);
		format(str,sizeof(str),""bijela"Igrac %s vam je dao %d cigareta.",GetName(playerid),kolicina);
		SCM(targetid,-1,str);
		format(str,sizeof(str),"je dao cigarete igracu %s.",GetName(targetid));
		Aktivnost(playerid,str);
		SacuvajIgraca(playerid);
		SacuvajIgraca(targetid);
		format(str,sizeof(str),"[CIGARETE] | Igrac %s | Dao igracu %s | Kolicina %d |",GetName(playerid),GetName(targetid),kolicina);
		Log(DAJ_LOG,str);
	}
    else if(!strcmp(opcija,"upaljac",true))
	{
        if(kolicina > PlayerInfo[playerid][pUpaljac]) return ERROR(playerid,"Nemate toliko upaljaca!");
        new string6[30];
		PlayerInfo[playerid][pUpaljac] -= kolicina;
		format(string6,sizeof(string6),"~r~-%d droge",kolicina);
  		GameTextForPlayer(playerid, string6, 3000, 1);
		PlayerInfo[targetid][pUpaljac] += kolicina;
		format(string6,sizeof(string6),"~g~+%d droge",kolicina);
  		GameTextForPlayer(targetid, string6, 3000, 1);
		format(str,sizeof(str),""bijela"Dali ste igracu %s %d upaljaca.",GetName(targetid),kolicina);
		SCM(playerid,-1,str);
		format(str,sizeof(str),""bijela"Igrac %s vam je dao %d upaljaca.",GetName(playerid),kolicina);
		SCM(targetid,-1,str);
		format(str,sizeof(str),"je dao upaljac igracu %s.",GetName(targetid));
		Aktivnost(playerid,str);
		SacuvajIgraca(playerid);
		SacuvajIgraca(targetid);
		format(str,sizeof(str),"[UPALJAC] | Igrac %s | Dao igracu %s | Kolicina %d |",GetName(playerid),GetName(targetid),kolicina);
		Log(DAJ_LOG,str);
	}
	else if(!strcmp(opcija,"oruzje",true))
	{
		if(GetPlayerWeapon(playerid) <= 0) return ERROR(playerid,"Nemate oruzje u ruci!");
		if(GetPlayerAmmo(playerid) < kolicina) return ERROR(playerid,"Nemate toliko metaka!");
   	    new ora = GetPlayerWeapon(playerid);
		new meci = GetPlayerAmmo(playerid)-kolicina;
		GivePlayerWeapon(targetid, ora, kolicina);
		SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), meci);
		format(str,sizeof(str),""bijela"Dali ste igracu %s %d metaka sa oruzjem.",GetName(targetid),kolicina);
		SCM(playerid,-1,str);
		format(str,sizeof(str),""bijela"Igrac %s vam je dao %d metaka oruzja.",GetName(playerid),kolicina);
		SCM(targetid,-1,str);
		format(str,sizeof(str),"je dao oruzje igracu %s.",GetName(targetid));
		Aktivnost(playerid,str);
		SacuvajIgraca(playerid);
		SacuvajIgraca(targetid);
		new nm[24];
		GetWeaponName(ora,nm,sizeof(nm));
		format(str,sizeof(str),"[WEAPON] | Igrac %s | Dao igracu %s | Kolicina %d | %s(%d) |",GetName(playerid),GetName(targetid),kolicina,nm,GetPlayerWeapon(playerid));
		Log(DAJ_LOG,str);
	}
	else if(!strcmp(opcija,"drogasjeme",true))
	{
        if(kolicina > PlayerInfo[playerid][pSjemeDroge]) return ERROR(playerid,"Nemate toliko sjemena droge!");
        new string6[30];
		PlayerInfo[playerid][pSjemeDroge] -= kolicina;
		format(string6,sizeof(string6),"~r~-%d sjemena droge",kolicina);
  		GameTextForPlayer(playerid, string6, 3000, 1);
		PlayerInfo[targetid][pSjemeDroge] += kolicina;
		format(string6,sizeof(string6),"~g~+%d sjemena droge",kolicina);
  		GameTextForPlayer(targetid, string6, 3000, 1);
		format(str,sizeof(str),""bijela"Dali ste igracu %s %d sjemena droge.",GetName(targetid),kolicina);
		SCM(playerid,-1,str);
		format(str,sizeof(str),""bijela"Igrac %s vam je dao %d sjemena droge.",GetName(playerid),kolicina);
		SCM(targetid,-1,str);
		format(str,sizeof(str),"je dao sjeme droge igracu %s.",GetName(targetid));
		Aktivnost(playerid,str);
		SacuvajIgraca(playerid);
		SacuvajIgraca(targetid);
		format(str,sizeof(str),"[SJEME-DROGE] | Igrac %s | Dao igracu %s | Kolicina %dg |",GetName(playerid),GetName(targetid),kolicina);
		Log(DAJ_LOG,str);
	}
	else if(!strcmp(opcija,"dinamit",true))
	{
        if(kolicina > PlayerInfo[playerid][pDinamit]) return ERROR(playerid,"Nemate toliko dinamita!");
        new string6[30];
		PlayerInfo[playerid][pDinamit] -= kolicina;
		format(string6,sizeof(string6),"~r~-%d dinamita",kolicina);
  		GameTextForPlayer(playerid, string6, 3000, 1);
		PlayerInfo[targetid][pDinamit] += kolicina;
		format(string6,sizeof(string6),"~g~+%d dinamita",kolicina);
  		GameTextForPlayer(targetid, string6, 3000, 1);
		format(str,sizeof(str),""bijela"Dali ste igracu %s %d dinamita.",GetName(targetid),kolicina);
		SCM(playerid,-1,str);
		format(str,sizeof(str),""bijela"Igrac %s vam je dao %d dinamita.",GetName(playerid),kolicina);
		SCM(targetid,-1,str);
		format(str,sizeof(str),"je dao dinamit igracu %s.",GetName(targetid));
		Aktivnost(playerid,str);
		SacuvajIgraca(playerid);
		SacuvajIgraca(targetid);
		format(str,sizeof(str),"[DINAMIT] | Igrac %s | Dao igracu %s | Kolicina %dg |",GetName(playerid),GetName(targetid),kolicina);
		Log(DAJ_LOG,str);
	}
	else return USAGE(playerid,"/daj [Id/Ime][Opcija][Kolicina]!");
	return 1;
}
//==============================================================================
CMD:turnmobile(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new turn[5];
	if(sscanf(params,"s[5]",turn)) return USAGE(playerid,"/turnmobile [on/off]!");
	if(!PlayerInfo[playerid][pMobitel]) return ERROR(playerid,"Nemate mobitel!");
	if(Razgovara[playerid] != -1) return ERROR(playerid,"Vec razgovarate s nekim!");
	if(Zove[playerid] != -1) return ERROR(playerid,"Zovete nekoga!");
	if(!strcmp(turn,"on",true))
	{
	    if(PlayerInfo[playerid][pMobitelUkljucen]) return ERROR(playerid,"Mobitel vam je vec ukljucen!");
		PlayerInfo[playerid][pMobitelUkljucen] = true;
		INFO(playerid,"Uspjesno ste ukljucili mobitel!");
		Aktivnost(playerid,"je ukljucio mobitel.");
	}
	else if(!strcmp(turn,"off",true))
	{
	    if(!PlayerInfo[playerid][pMobitelUkljucen]) return ERROR(playerid,"Mobitel vam je vec iskljucen!");
		PlayerInfo[playerid][pMobitelUkljucen] = false;
		INFO(playerid,"Uspjesno ste iskljucili mobitel!");
		Aktivnost(playerid,"je iskljucio mobitel.");
	}
	else return USAGE(playerid,"/turnmobile [on/off]!");
	return 1;
}
//==============================================================================
CMD:call(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(!PlayerInfo[playerid][pMobitel]) return ERROR(playerid,"Nemate mobitel!");
	if(!PlayerInfo[playerid][pMobitelUkljucen]) return ERROR(playerid,"Mobitel vam je iskljucen!");
	if(Razgovara[playerid] != -1) return ERROR(playerid,"Vec razgovarate s nekim!");
	if(PlayerInfo[playerid][pMobilniKredit] < 2) return ERROR(playerid,"Nemate dovoljno mobilnog kredita!");
	if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
	if(Zove[playerid] != -1) return ERROR(playerid,"Vec zovete nekoga!");
	new d = -1;
	foreach(Player,i)
	{
	    if(Zove[i] == playerid)
	    {
	        d = 1; break;
	    }
	}
	if(d == 1) return ERROR(playerid,"Zvoni vam mobitel!");
	new targetid, string[100];
	if(sscanf(params, "u", targetid)) return ERROR(playerid,"Koristi:/call [Id/Ime]!");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Nemozete samoga sebe!");

	if(!PlayerInfo[targetid][pMobitelUkljucen]) return ERROR(playerid,"Igrac ima iskljucen mobitel!");
	if(Razgovara[targetid] != -1) return ERROR(playerid,"Igrac razgovara s nekim!");
	d=-1;
 	foreach(Player,i)
	{
	    if(Zove[i] == targetid)
	    {
	        d=1; break;
	    }
	}
	if(d != -1) return ERROR(playerid,"Netko trenutno zove tog igraca!");
	Zove[playerid] = targetid;
	SCM(targetid,-1,""zelena"-------------------------------------------------------------------------------------");
	format(string, sizeof(string), ""zelena"Zvoni vam telefon | Pozivatelj: %d | /p - za javljanje | /h - za prekidanje", playerid);
	SCM(targetid, -1, string);
	SCM(targetid,-1,""zelena"-------------------------------------------------------------------------------------");
	Aktivnost(targetid,"zvoni mobitel.");
	Aktivnost(playerid,"vadi mobitel iz dzepa.");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	SetPlayerAttachedObject(playerid, MOBITEL_SLOT, 330, 6, 0.04, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0);
	CallTimer[playerid] = SetTimerEx("calltimer", 60000, false, "d", playerid);
	return 1;
}
//==============================================================================
CMD:p(playerid, params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(!PlayerInfo[playerid][pMobitel]) return ERROR(playerid,"Nemate mobitel!");
	if(!PlayerInfo[playerid][pMobitelUkljucen]) return ERROR(playerid,"Mobitel vam je iskljucen!");
	if(Razgovara[playerid] != -1) return ERROR(playerid,"Razgovarate s nekim!");
	if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
	new id = -1;
	foreach(Player,i)
	{
	    if(Zove[i] == playerid)
	    {
	        id = i; break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Nitko vas ne zove!");
	Zove[id] = false;
	Razgovara[id] = playerid;
	Razgovara[playerid] = id;
	SCM(Razgovara[playerid], -1, ""zelena"Igrac se javio na mobitel!" );
	SCM(Razgovara[playerid], -1, ""zelena"Sada mozete pricati na mobitel sa T!");
	SCM(playerid, -1, ""zuta"Javili ste se na mobitel!");
    SCM(playerid, -1, ""zuta"Sada mozete pricati na mobitel sa T!");
	Aktivnost(playerid,"se javio na telefon");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	SetPlayerAttachedObject(playerid, MOBITEL_SLOT, 330, 6, 0.04, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0);
	MobitelCijenaRazgovora[Razgovara[playerid]] = SetTimerEx("CijenaRazgovora", 10000, true, "d", Razgovara[playerid]);
	KillTimer(CallTimer[Razgovara[playerid]]);
	return 1;
}
//==============================================================================
CMD:h(playerid, params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(!PlayerInfo[playerid][pMobitel]) return ERROR(playerid,"Nemate mobitel!");
	if(!PlayerInfo[playerid][pMobitelUkljucen]) return ERROR(playerid,"Mobitel vam je iskljucen!");
	if(Razgovara[playerid] != -1)
	{
		SCM(Razgovara[playerid], -1, ""zelena"Igrac s kojim ste pricali je prekinuo poziv!");
		SetPlayerSpecialAction(Razgovara[playerid], SPECIAL_ACTION_STOPUSECELLPHONE);
		if(IsPlayerAttachedObjectSlotUsed(Razgovara[playerid], MOBITEL_SLOT)) { RemovePlayerAttachedObject(Razgovara[playerid], MOBITEL_SLOT); }
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		if(IsPlayerAttachedObjectSlotUsed(playerid, MOBITEL_SLOT)) { RemovePlayerAttachedObject(playerid, MOBITEL_SLOT); }
		SCM(playerid, -1, ""zelena"Prekinuli ste poziv");
	 	Razgovara[Razgovara[playerid]] = -1;
		Razgovara[playerid] = -1;
		KillTimer(MobitelCijenaRazgovora[playerid]);
		KillTimer(MobitelCijenaRazgovora[Razgovara[playerid]]);
	}
	else if(Zove[playerid] != -1)
	{
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	 	if(IsPlayerAttachedObjectSlotUsed(playerid, MOBITEL_SLOT)) { RemovePlayerAttachedObject(playerid, MOBITEL_SLOT); }
		SCM(playerid, -1, ""zelena"Prekinuli ste poziv");
	 	Zove[playerid] = -1;
	 	KillTimer(CallTimer[playerid]);
	}
	else return ERROR(playerid,"Ne razgovarate!");
    return 1;
}
//==============================================================================
CMD:sms(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(!PlayerInfo[playerid][pMobitel]) return ERROR(playerid,"Nemate mobitel!");
	if(!PlayerInfo[playerid][pMobitelUkljucen]) return ERROR(playerid,"Mobitel vam je iskljucen!");
	if(PlayerInfo[playerid][pMuted]) return ERROR(playerid,"Mutirani ste!");
	new targetid, poruka[128], string[100];
	if(sscanf(params, "ds[128]", targetid, poruka)) return USAGE(playerid,"/sms [Id/Ime][Tekst]!");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
    if(PlayerInfo[playerid][pMobilniKredit] < 5) return ERROR(playerid,"Nemate dovoljno mobilnog kredita!");

    if(!PlayerInfo[targetid][pMobitel]) return ERROR(playerid,"Igrac nema mobitel!");
	if(!PlayerInfo[targetid][pMobitelUkljucen]) return ERROR(playerid,"Igrac ima iskljucen mobitel!");
	format(string, sizeof(string), "Nova Poruka | "zelena"Posiljatelj: %d | Ime: %s", playerid, GetName(playerid));
	SCM(targetid, -1, string);
	format(string, sizeof(string), "Tekst Poruke | "zelena"%s", poruka);
	SCM(targetid, -1, string);
	format(string, sizeof(string), ""zelena"Uspjesno ste poslali poruku na igracu %s!", GetName(targetid));
	SCM(playerid, -1, string);
	format(string, sizeof(string), "Tekst poslane poruke | "zelena"%s", poruka);
	SCM(playerid, -1, string);
	PlayerInfo[playerid][pMobilniKredit] -= 5;
 	return 1;
}
//==============================================================================
CMD:smsoglas(playerid, params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(!PlayerInfo[playerid][pMobitel]) return ERROR(playerid,"Nemate mobitel!");
	if(!PlayerInfo[playerid][pMobitelUkljucen]) return ERROR(playerid,"Mobitel vam je iskljucen!");
    new result[256],str[256];
	if(sscanf(params, "s[256]", result)) return USAGE(playerid,"/smsoglas [Tekst]!");
    if(PlayerInfo[playerid][pMobilniKredit] < 50) return ERROR(playerid,"Za oglas vam je potrebno 50$ mobilnog kredita!");
    PlayerInfo[playerid][pMobilniKredit] -= 50;
    
    SCMTA(-1,""zelena"=================MALI OGLASI===================");
	format(str, sizeof(str), ""zelena"MALI OGLASI |"bijela" %s",  result);
	SCMTA(-1,str);
	format(str, sizeof(str),""zelena"Napisao:"bijela" %s", GetName(playerid));
	SCMTA(-1,str);
	format(str, sizeof(str), ""zelena"Id:"bijela" %d", playerid);
	SCMTA(-1, str);
	SCMTA(-1,""zelena"=================MALI OGLASI===================");
	GameTextForPlayer(playerid,"~g~Uspjesno ste dali oglas za ~r~50$ kredita!",5000,3);
    return 1;
}
//==============================================================================
CMD:ckupioruzje(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Niste u organizaciji!");
	if(!OrgJeMafija(PlayerInfo[playerid][pOrgID])) return ERROR(playerid,"Niste u mafiji!");
	if(!IsPlayerInRangeOfPoint(playerid,2.0,2723.1421,2839.9314,10.8203)) return ERROR(playerid,"Niste kod crnog trzista!");
	new oruzje[24],metci;
	if(sscanf(params,"s[24]d",oruzje,metci))
	{
		USAGE(playerid,"/ckupioruzje [Oruzje][Metci]");
		INFO(playerid,"Imena oruzja i cijena.");
		INFO(playerid,"| WEAPON_BRASSKNUCKLE $10 | WEAPON_GOLFCLUB $10 | WEAPON_KNIFE $10 | WEAPON_BAT $10");
		INFO(playerid,"| WEAPON_SHOVEL $10 | WEAPON_POOLSTICK $10 | WEAPON_KATANA $10 | WEAPON_CHAINSAW $10");
  		INFO(playerid,"| WEAPON_COLT45 $100 | WEAPON_SILENCED $200 | WEAPON_DEAGLE $1000 | WEAPON_SHOTGUN $1500");
    	INFO(playerid,"| WEAPON_SHOTGSPA $2000 | WEAPON_UZI $3000 | WEAPON_MP5 $4000 | WEAPON_AK47 $4500");
     	INFO(playerid,"| WEAPON_M4 $5000 | WEAPON_TEC9 $3500 | WEAPON_RIFLE $5500 | WEAPON_SNIPER $6000");
		INFO(playerid,"Ove cijene su za 5 metaka.");
		return 1;
	}
	if(strfind(oruzje, "WEAPON_", false) == -1) return ERROR(playerid,"Niste upisali tocno ime oruzja!");
	new cijena, id;
	if(!strcmp(oruzje, "WEAPON_BRASSKNUCKLE", true)) { cijena = 10, id = 1;}
	else if(!strcmp(oruzje, "WEAPON_GOLFCLUB", true)) { cijena = 10, id = 2;}
 	else if(!strcmp(oruzje, "WEAPON_KNIFE", true)) { cijena = 10, id = 4;}
  	else if(!strcmp(oruzje, "WEAPON_BAT", true)) { cijena = 10, id = 5; }
   	else if(!strcmp(oruzje, "WEAPON_SHOVEL", true)) { cijena = 10, id = 6;}
    else if(!strcmp(oruzje, "WEAPON_POOLSTICK", true)) { cijena = 10, id = 7;}
    else if(!strcmp(oruzje, "WEAPON_KATANA", true)) { cijena = 10, id = 8;}
    else if(!strcmp(oruzje, "WEAPON_CHAINSAW", true)) { cijena = 10, id = 9;}
    else if(!strcmp(oruzje, "WEAPON_COLT45", true)) { cijena = 100, id = 22;}
    else if(!strcmp(oruzje, "WEAPON_SILENCED", true)) { cijena = 200, id = 23;}
    else if(!strcmp(oruzje, "WEAPON_DEAGLE", true)) { cijena = 1000, id = 24;}
    else if(!strcmp(oruzje, "WEAPON_SHOTGUN", true)) { cijena = 1500, id = 25;}
    else if(!strcmp(oruzje, "WEAPON_SHOTGSPA", true)) { cijena = 2000, id = 27;}
    else if(!strcmp(oruzje, "WEAPON_UZI", true)) { cijena = 3000, id = 28;}
    else if(!strcmp(oruzje, "WEAPON_MP5", true)) { cijena = 4000, id = 29;}
    else if(!strcmp(oruzje, "WEAPON_AK47", true)) { cijena = 4500, id = 30;}
    else if(!strcmp(oruzje, "WEAPON_M4", true)) { cijena = 5000, id = 31;}
    else if(!strcmp(oruzje, "WEAPON_TEC9", true)) { cijena = 3500, id = 32;}
    else if(!strcmp(oruzje, "WEAPON_RIFLE", true)) { cijena = 5500, id = 33;}
    else if(!strcmp(oruzje, "WEAPON_SNIPER", true)) { cijena = 6000, id = 34;}
    else { ERROR(playerid,"To oruzje nije na listi!"); return 1; }
    new finalnacijena = (cijena/5) * metci;
	if(GetPlayerMoney(playerid) < finalnacijena) return INFO(playerid,"Nemate dovoljno novca!");
	GivePlayerMoney(playerid,-finalnacijena);
	PlayerInfo[playerid][pMoney] -= finalnacijena;
	GivePlayerWeapon(playerid,id,metci);
	SacuvajIgraca(playerid);
	new str[100];
	new nm[24];
	GetWeaponName(id,nm,sizeof(nm));
	format(str,sizeof(str),""zelena"Uspjesno ste kupili oruzje %s(%d metaka) za %d$!",nm,metci,finalnacijena);
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:ckupidrogu(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Niste u organizaciji!");
	if(!IsPlayerInRangeOfPoint(playerid,2.0,2739.4673,2851.0493,10.8203)) return ERROR(playerid,"Niste kod crnog trzista!");
	new kolicina;
	if(sscanf(params,"d",kolicina)) return USAGE(playerid,"/ckupidrogu [Kolicina] | 1g = 900$ |");
	if(kolicina < 1) return 1;
	new cijena=kolicina*900;
	if(GetPlayerMoney(playerid) < cijena) return INFO(playerid,"Nemate dovoljno novca!");
	GivePlayerMoney(playerid,-cijena);
	PlayerInfo[playerid][pMoney] -= cijena;
	PlayerInfo[playerid][pDroga] += kolicina;
	SacuvajIgraca(playerid);
	new str[100];
	format(str,sizeof(str),""zelena"Uspjesno ste kupili %dg droge za cijenu od %d$!",kolicina,cijena);
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:cprodajdrogu(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Niste u organizaciji!");
	if(!IsPlayerInRangeOfPoint(playerid,2.0,2743.5481,2851.8738,10.8203)) return ERROR(playerid,"Niste kod crnog trzista!");
	new kolicina;
	if(sscanf(params,"d",kolicina)) return USAGE(playerid,"/cprodajdrogu [Kolicina] | 1g = 500$ |");
	if(kolicina < 1) return 1;
	new cijena=kolicina*500;
	if(PlayerInfo[playerid][pDroga] < kolicina) return ERROR(playerid,"Nemate dovoljno droge!");
	GivePlayerMoney(playerid,cijena);
	PlayerInfo[playerid][pMoney] += cijena;
	PlayerInfo[playerid][pDroga] -= kolicina;
	SacuvajIgraca(playerid);
	new str[100];
	format(str,sizeof(str),""zelena"Uspjesno ste prodali %dg droge za cijenu od %d$!",kolicina,cijena);
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:ckupisjeme(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Niste u organizaciji!");
	if(!OrgJeMafija(PlayerInfo[playerid][pOrgID])) return ERROR(playerid,"Niste u mafiji!");
	if(!IsPlayerInRangeOfPoint(playerid,2.0,2740.1699,2839.8335,10.8203)) return ERROR(playerid,"Niste kod crnog trzista!");
	new kolicina;
	if(sscanf(params,"d",kolicina)) return USAGE(playerid,"/ckupisjeme [Kolicina] | 1g = 300$ |");
	if(kolicina < 1) return 1;
	new cijena=kolicina*300;
	if(GetPlayerMoney(playerid) < cijena) return INFO(playerid,"Nemate dovoljno novca!");
	GivePlayerMoney(playerid,-cijena);
	PlayerInfo[playerid][pMoney] -= cijena;
	PlayerInfo[playerid][pSjemeDroge] += kolicina;
	SacuvajIgraca(playerid);
	new str[100];
	format(str,sizeof(str),""zuta"Uspjesno ste kupili %dg sjemena droge za cijenu od %d$!",kolicina,cijena);
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:posadidrogu(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	if(PlayerInfo[playerid][pSjemeDroge] < 10) return ERROR(playerid,"Potrebno vam je 10 sjemena droge da ju posadite!");
	if(DrogaInfo[playerid][dUsed]) return ERROR(playerid,"Vec ste posadili drogu!");
	if(GetPlayerInterior(playerid) != 0) return ERROR(playerid,"Nemozete u interioru!");
    if(GetPlayerVirtualWorld(playerid) != 0) return ERROR(playerid,"Morate imati virtual world 0!");
	new Float:x,Float:y,Float:z,Float:az;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,az);
	DrogaInfo[playerid][dX] = x;
	DrogaInfo[playerid][dY] = y;
	DrogaInfo[playerid][dZ] = z;
	DrogaInfo[playerid][dRotX] = az;
	DrogaInfo[playerid][dRotY] = 0.0;
	DrogaInfo[playerid][dRotZ] = 0.0;
	DrogaInfo[playerid][dObject] = CreateDynamicObject(647,DrogaInfo[playerid][dX],DrogaInfo[playerid][dY],DrogaInfo[playerid][dZ],DrogaInfo[playerid][dRotX],DrogaInfo[playerid][dRotY],DrogaInfo[playerid][dRotZ]);
	DrogaInfo[playerid][dUsed] = true; DrogaInfo[playerid][dIzrasla] = 0;
	DrogaTimer[playerid] = SetTimerEx("drogatimer",60000,true,"d",playerid);
	DrogaText[playerid] = Create3DTextLabel(""smeda"[DROGA]\n"zuta"Droga raste.\n"bijela"0/5",-1,DrogaInfo[playerid][dX],DrogaInfo[playerid][dY],DrogaInfo[playerid][dZ],2.0,0,0);
	PlayerInfo[playerid][pSjemeDroge] -= 10;
	SacuvajIgraca(playerid);
	return 1;
}
//==============================================================================
CMD:ckupimats(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Niste u organizaciji!");
	if(!OrgJeBanda(PlayerInfo[playerid][pOrgID])) return ERROR(playerid,"Niste u bandi!");
	if(!IsPlayerInRangeOfPoint(playerid,2.0,2722.5085,2849.5295,10.8203)) return ERROR(playerid,"Niste kod crnog trzista!");
	new kolicina;
	if(sscanf(params,"d",kolicina)) return USAGE(playerid,"/ckupimats [Kolicina] | 1g = 900$ |");
	if(kolicina < 1) return 1;
	new cijena=kolicina*900;
	if(GetPlayerMoney(playerid) < cijena) return INFO(playerid,"Nemate dovoljno novca!");
	GivePlayerMoney(playerid,-cijena);
	PlayerInfo[playerid][pMoney] -= cijena;
	PlayerInfo[playerid][pMats] += kolicina;
	SacuvajIgraca(playerid);
	new str[100];
	format(str,sizeof(str),""zelena"Uspjesno ste kupili %dg matsa za cijenu od %d$!",kolicina,cijena);
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:cprodajmats(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Niste u organizaciji!");
	if(!IsPlayerInRangeOfPoint(playerid,2.0,2722.5085,2849.5295,10.8203)) return ERROR(playerid,"Niste kod crnog trzista!");
	new kolicina;
	if(sscanf(params,"d",kolicina)) return USAGE(playerid,"/cprodajmats [Kolicina] | 1g = 600$ |");
	if(kolicina < 1) return 1;
	new cijena=kolicina*600;
	if(PlayerInfo[playerid][pMats] < kolicina) return INFO(playerid,"Nemate dovoljno matsa!");
	GivePlayerMoney(playerid,cijena);
	PlayerInfo[playerid][pMoney] += cijena;
	PlayerInfo[playerid][pMats] -= kolicina;
	SacuvajIgraca(playerid);
	new str[100];
	format(str,sizeof(str),""zelena"Uspjesno ste prodali %dg matsa za cijenu od %d$!",kolicina,cijena);
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:cnapravioruzje(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Niste u organizaciji!");
	if(!IsPlayerInRangeOfPoint(playerid,2.0,2722.5085,2849.5295,10.8203)) return ERROR(playerid,"Niste kod crnog trzista!");
    ShowPlayerDialog(playerid, DIALOG_CNAPRAVIORUZJE, DIALOG_STYLE_PREVIEW_MODEL, "~b~"IME" - Crno trziste:","356\tM4 - 4g Matsa\n335\tKnife - 1g Matsa\n351\tShotgun - 2g Matsa\n355\tAK47 - 4g Matsa\n348\tDesert Eagle - 1g Matsa\n358\tSniper - 5g Matsa", "Napravi", "Odustani");
	return 1;
}
//==============================================================================
CMD:marama(playerid,params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
    if(Marama[playerid])
    {
        if(IsPlayerAttachedObjectSlotUsed(playerid, MARAMA_SLOT)) { RemovePlayerAttachedObject(playerid,MARAMA_SLOT); }
        INFO(playerid,"Skinuli ste maramu!");
		Aktivnost(playerid,"je skinuo maramu!");
        Marama[playerid] = false;
        foreach(Player,z)
		{
  			ShowPlayerNameTagForPlayer(z, playerid, true);
		}
    }
    else
    {
        if(PlayerInfo[playerid][pMarama] < 1) return ERROR(playerid,"Nemate maramu!");
    	SetPlayerAttachedObject(playerid, MARAMA_SLOT, 18913, 2, -0.08, 0.03, 0.0, 90, -180, -90);
        INFO(playerid,"Stavili ste maramu!");
		Aktivnost(playerid,"je stavio maramu!");
        Marama[playerid] = true;
        PlayerInfo[playerid][pMarama]--;
	}
	return 1;
}
//==============================================================================
CMD:unrentaj(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(RentaVozilo[playerid])
	{
	 	if(VoziloZaRent[IdRentVozila[playerid]])
	 	{
	 	    if(IsPlayerInAnyVehicle(playerid))
			{
			    if(GetPlayerVehicleID(playerid) == IdRentVozila[playerid])
			    {
			        RemovePlayerFromVehicle(playerid);
				}
		 	}
   			SetVehicleToRespawn(IdRentVozila[playerid]);
			VoziloRentano[IdRentVozila[playerid]] = false;
			RentaVozilo[playerid] = false;
			IdRentVozila[playerid] = -1;
			RentVrijeme[playerid] = 0;
			KillTimer(RentTimer[playerid]);
			INFO(playerid,"Uspjesno ste unrentali vozilo!");
		}
		else
		{
		    VoziloRentano[IdRentVozila[playerid]] = false;
			RentaVozilo[playerid] = false;
			IdRentVozila[playerid] = -1;
			RentVrijeme[playerid] = 0;
			KillTimer(RentTimer[playerid]);
			INFO(playerid,"Uspjesno ste unrentali vozilo!");
		}
	}
	else
	{
	    ERROR(playerid,"Ne rentate vozilo!");
	}
	return 1;
}
//==============================================================================
CMD:erent(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	EditInfo[playerid][eModel] = EditInfo[playerid][eColor1] = EditInfo[playerid][eColor2] = EditInfo[playerid][eRespawn] = EditInfo[playerid][eID] = 0;
	ShowPlayerDialog(playerid,DIALOG_RENT1,DIALOG_STYLE_LIST,""plava""IME" - Rent:",""bijela"Kreiraj vozilo\n"plava"Preparkiraj\n"bijela"Promijeni boju\n"plava"Promijeni respawn time\n"bijela"Obrisi rent","Odaberi","Odustani");
	return 1;
}
//==============================================================================
CMD:attackzone(playerid,params[])
{
	#pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Niste u organizaciji!");
	if(AdminDuty[playerid]) return ERROR(playerid,"Ne mozete biti na admin duznosti!");
    if(GameMasterDuty[playerid]) return ERROR(playerid,"Ne mozete biti na gamemaster duznosti!");
    if(GetPlayerInterior(playerid) != 0) return ERROR(playerid,"Ne smijete biti u interiouru!");
    if(GetPlayerVirtualWorld(playerid) != 0) return ERROR(playerid,"Ne smijete biti u interiouru!");
    if(!ServerInfo[sZauzimanjeZona]) return ERROR(playerid,"Zauzimanje zona je trenutno iskljuceno!");
	new id = GetPlayerZoneID(playerid);
    if(id == -1) return ERROR(playerid,"Niste u niti jednoj zoni!");
    new players = 0;
	foreach(Player,i)
	{
	    if(PlayerInfo[i][pOrgID] == PlayerInfo[playerid][pOrgID])
	    {
	        if(IsPlayerInZone(i,id)) { players++; }
	    }
	}
	if(players < 3) return ERROR(playerid,"Morate biti najmanje trojica za zauzimanje zone!");
	if(ZonaInfo2[id][zOrgID] == PlayerInfo[playerid][pOrgID]) return ERROR(playerid,"Ova zona pripada vasoj organizaciji!");
	new weap,ammo,x=-1;
	for (new i = 0; i <= 12; i++)
	{
		GetPlayerWeaponData(playerid, i, weap,ammo);
		if(weap != -1 && weap != 0 && weap != 2 && weap != 7)
		{
			x = 1;
			break;
		}
	}
	if(x == -1) return ERROR(playerid,"Nemate orzuje!");
	if(zonatime[id] != -1) return ERROR(playerid,"Netko vec napada ovu zonu!");
	new str[200];
	format(str,sizeof(str),"{804000}---------------------------------------------------------------------");
	SendOrgMessage(playerid,str);
	new orgname[24];
	if(ZonaInfo2[id][zOrgID] == -1) { format(orgname,sizeof(orgname),"Nema vlasnika"); }
	else { format(orgname,sizeof(orgname),"%s",OrgInfo[ZonaInfo2[id][zOrgID]][oName]);  }
	format(str,sizeof(str),"{804000}Vasa organizacija je napala gang zonu organizacije %s! ID zone: %d!",orgname,id);
	SendOrgMessage(playerid,str);
	format(str,sizeof(str),"{804000}---------------------------------------------------------------------");
	SendOrgMessage(playerid,str);
	
	if(ZonaInfo2[id][zOrgID] != -1)
	{
		new d = -1;
		foreach(Player,i)
		{
		    if(PlayerInfo[i][pOrgID] == ZonaInfo2[id][zOrgID])
			{
				d = i;
				break;
			}
		}
		if(d != -1)
		{
			format(str,sizeof(str),"{804000}---------------------------------------------------------------------");
			SendOrgMessage(d,str);
			format(str,sizeof(str),"{804000}Organizacija %s je napala vasu zonu! ID zone: %d!",OrgInfo[PlayerInfo[playerid][pOrgID]][oName],id);
			SendOrgMessage(d,str);
			format(str,sizeof(str),"{804000}---------------------------------------------------------------------");
			SendOrgMessage(d,str);
		}
	}
	zonatimer[id] = SetTimerEx("zattack",1000,true,"dd",PlayerInfo[playerid][pOrgID],id);
	zonatime[id] = 0;
	GangZoneFlashForAll(zona[id],OrgInfo[PlayerInfo[playerid][pOrgID]][oColor]);
	return 1;
}
//==============================================================================
CMD:resetgangzoneowners(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	for(new i=0;i<MAX_ZONA;i++)
	{
	    ZonaInfo2[i][zOrgID] = -1;
	    SacuvajZonu(i);
	}
	foreach(Player,i)
	{
	    ShowGangZones(playerid,false);
	    ShowGangZones(playerid,true);
	}
	INFO(playerid,"Uspjesno ste resetirali sve zone!");
	return 1;
}
//==============================================================================
CMD:zoneinfo(playerid,params[])
{
	#pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(GetPlayerInterior(playerid) != 0) return ERROR(playerid,"Ne smijete biti u interiouru!");
    if(GetPlayerVirtualWorld(playerid) != 0) return ERROR(playerid,"Ne smijete biti u interiouru!");
	new id = GetPlayerZoneID(playerid);
    if(id == -1) return ERROR(playerid,"Niste u niti jednoj zoni!");
    new str[100];
	if(ZonaInfo2[id][zOrgID] == -1)
	{
		format(str,sizeof(str),"{804000}Ova zona pripada organizaciji "plava"Nema.");
		SCM(playerid,-1,str);
	}
	else
	{
	    if(PlayerInfo[playerid][pOrgID] != ZonaInfo2[id][zOrgID])
	    {
	    	format(str,sizeof(str),"{804000}Ova zona pripada organizaciji "crvena"%s.",OrgInfo[ZonaInfo2[id][zOrgID]][oName]);
		}
		else
		{
		    format(str,sizeof(str),"{804000}Ova zona pripada organizaciji "zelena"%s. {804000}Placa zone je "zelena"%d$ ",OrgInfo[ZonaInfo2[id][zOrgID]][oName],ZonaInfo[id][zPlaca]);
		}
		SCM(playerid,-1,str);
	}
	return 1;
}
//==============================================================================
CMD:pomoc(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new str[250],str1[600];
	format(str,sizeof(str),""zuta"TeamSpeak3: "plava""TS3"\n\n");
   	strcat(str1,str);
	format(str,sizeof(str),""bijela"Da vidite listu svih komandi i njihova objasnjenja upisite "plava"'/help'\n"bijela"Ako vam zatreba pomoc upisite "plava"'/askq' "bijela" i admini ili gamemasteri ce vam pomoci u najkracem mogucem roku.\n");
 	strcat(str1,str);
  	format(str,sizeof(str),""bijela"Da vidite listu vaznih lokacija i kako doci do njih upisite "plava"'/gps'\n"bijela"Lokacije poslova mozete naci u opstini!\n");
   	strcat(str1,str);
   	format(str,sizeof(str),""zelena"Nadamo se da ce vam se svidjeti nas server i zelimo vam ugodnu igru.\n\n"bijela"Molimo vas da sve bugove prijavite adminima!");
   	strcat(str1,str);
	ShowPlayerDialog(playerid,DIALOG_INFO,DIALOG_STYLE_MSGBOX,""plava""IME" - Info",str1,"Ok","");
	return 1;
}
//==============================================================================
CMD:ckupidinamit(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Niste u organizaciji!");
	if(!IsPlayerInRangeOfPoint(playerid,2.0,2740.1699,2839.8335,10.8203)) return ERROR(playerid,"Niste kod crnog trzista!");
	new kolicina;
	if(sscanf(params,"d",kolicina)) return USAGE(playerid,"/ckupidinamit [Kolicina] | 1 = 30000$ |");
	if(kolicina < 1) return 1;
	new cijena=kolicina*30000;
	if(GetPlayerMoney(playerid) < cijena) return INFO(playerid,"Nemate dovoljno novca!");
	GivePlayerMoney(playerid,-cijena);
	PlayerInfo[playerid][pMoney] -= cijena;
	PlayerInfo[playerid][pDinamit] += kolicina;
	SacuvajIgraca(playerid);
	new str[100];
	format(str,sizeof(str),""zuta"Uspjesno ste kupili %d dinamita za cijenu od %d$!",kolicina,cijena);
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:raznesi(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(!IsPlayerInRangeOfPoint(playerid,2.0,656.7759,413.2963,651.3528)) return ERROR(playerid,"Niste kod crnog trzista!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	if(PlayerInfo[playerid][pDinamit] < 1) return ERROR(playerid,"Nemate dinamita!");
	if(sefstate) return ERROR(playerid,"Sef je otvoren!");
	if(dinamitobject[playerid] != INVALID_OBJECT_ID) return ERROR(playerid,"Vec ste postavili dinamit!");
	new d = 0;
	foreach(Player,i)
	{
 		if(PlayerInfo[i][pOrgID] == POLICIJA)
		{
			d++;
		}
	} 
	if(d < 2) return ERROR(playerid,"Nema dovoljno policajaca na serveru!");
	new id = -1;
	foreach(Player,i)
	{
	    if(dinamitobject[i] != INVALID_OBJECT_ID) { id = i; break; }
	}
	if(id != -1) return ERROR(playerid,"Netko je vec postavio dinamit!");
	dinamitobject[playerid] = CreateDynamicObject(1654, 656.76489, 413.67703, 651.77484,   0.00000, 0.00000, 0.00000);
	SetTimerEx("bankaeksplozija",10000,false,"d",playerid);
	INFO(playerid,"Dinamit ce eksplodirati za 10 sekundi!");
	GameTextForPlayer(playerid,"~g~Dinamit ce eksplodirati za 10 sekundi!",5000,3);
	PlayerInfo[playerid][pDinamit]--;
	SacuvajIgraca(playerid);
	return 1;
}
//==============================================================================
CMD:pokupi(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	if(pljacka[playerid] != -1) return ERROR(playerid,"Vec kupite novac!");
	if(IsPlayerInRangeOfPoint(playerid,2.0,644.5079,424.8175,651.3528))
	{
		if(novacpljacka[0]) return ERROR(playerid,"Netko je vec uzeo novac ovdje!");
		pljacka[playerid] = 0;
		pljackatimer[playerid] = SetTimerEx("pljackat",1000,true,"dd",playerid,0);
		SetPlayerFacingAngle(playerid,32.9746);
		
	}
	else if(IsPlayerInRangeOfPoint(playerid,2.0,647.5455,421.3625,651.3528))
	{
		if(novacpljacka[1]) return ERROR(playerid,"Netko je vec uzeo novac ovdje!");
        pljacka[playerid] = 0;
		pljackatimer[playerid] = SetTimerEx("pljackat",1000,true,"dd",playerid,1);
		SetPlayerFacingAngle(playerid,182.0993);
	}
	else if(IsPlayerInRangeOfPoint(playerid,2.0,652.0234,421.5735,651.3528))
	{
		if(novacpljacka[2]) return ERROR(playerid,"Netko je vec uzeo novac ovdje!");
        pljacka[playerid] = 0;
		pljackatimer[playerid] = SetTimerEx("pljackat",1000,true,"dd",playerid,2);
		SetPlayerFacingAngle(playerid,200.2727);
	}
	else if(IsPlayerInRangeOfPoint(playerid,2.0, 665.9907,424.8604,651.3528))
	{
		if(novacpljacka[3]) return ERROR(playerid,"Netko je vec uzeo novac ovdje!");
		pljacka[playerid] = 0;
		pljackatimer[playerid] = SetTimerEx("pljackat",1000,true,"dd",playerid,3);
		SetPlayerFacingAngle(playerid,300.5404);
	}
	else return ERROR(playerid,"Niste u sefu!");
	return 1;
}
//==============================================================================
CMD:resetbankrob(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
    KillTimer(bankaresettimer);
    bankaresettimer = SetTimer("bankareset",1000,false);
    INFO(playerid,"Uspjesno ste resetirali pljacku banke!");
	return 1;
}
//==============================================================================
CMD:adajoruzje(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 5) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new targetid,oruzje[24],metci;
	if(sscanf(params,"us[24]d",targetid,oruzje,metci))
	{
		USAGE(playerid,"/adajoruzje [Id/Ime][Oruzje][Metci]");
		INFO(playerid,"Imena oruzja i cijena.");
		INFO(playerid,"| WEAPON_BRASSKNUCKLE | WEAPON_GOLFCLUB | WEAPON_KNIFE | WEAPON_BAT");
		INFO(playerid,"| WEAPON_SHOVEL | WEAPON_POOLSTICK | WEAPON_KATANA | WEAPON_CHAINSAW");
  		INFO(playerid,"| WEAPON_CANE  | WEAPON_GRENADE | WEAPON_TEARGAS | WEAPON_MOLTOV");
  		INFO(playerid,"| WEAPON_COLT45 | WEAPON_SILENCED | WEAPON_DEAGLE | WEAPON_SHOTGUN");
    	INFO(playerid,"| WEAPON_SHOTGSPA | WEAPON_UZI | WEAPON_MP5 | WEAPON_AK47");
     	INFO(playerid,"| WEAPON_M4 | WEAPON_TEC9 | WEAPON_RIFLE | WEAPON_SNIPER");
      	INFO(playerid,"| WEAPON_ROCKETLAUNCHER | WEAPON_HEATSEEKER | WEAPON_FLAMETHROWER");
		return 1;
	}
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(strfind(oruzje, "WEAPON_", false) == -1) return ERROR(playerid,"Niste upisali tocno ime oruzja!");
	new cijena, id;
	if(!strcmp(oruzje, "WEAPON_BRASSKNUCKLE", true)) { cijena = 10, id = 1;}
	else if(!strcmp(oruzje, "WEAPON_GOLFCLUB", true)) { cijena = 10, id = 2;}
 	else if(!strcmp(oruzje, "WEAPON_KNIFE", true)) { cijena = 10, id = 4;}
  	else if(!strcmp(oruzje, "WEAPON_BAT", true)) { cijena = 10, id = 5; }
   	else if(!strcmp(oruzje, "WEAPON_SHOVEL", true)) { cijena = 10, id = 6;}
    else if(!strcmp(oruzje, "WEAPON_POOLSTICK", true)) { cijena = 10, id = 7;}
    else if(!strcmp(oruzje, "WEAPON_KATANA", true)) { cijena = 10, id = 8;}
    else if(!strcmp(oruzje, "WEAPON_CHAINSAW", true)) { cijena = 10, id = 9;}
    else if(!strcmp(oruzje, "WEAPON_CANE", true)) { cijena = 10, id = 15;}
    else if(!strcmp(oruzje, "WEAPON_GRENADE", true)) { cijena = 500, id = 16;}
    else if(!strcmp(oruzje, "WEAPON_TEARGAS", true)) { cijena = 400, id = 17;}
    else if(!strcmp(oruzje, "WEAPON_MOLTOV", true)) { cijena = 500, id = 18;}
    else if(!strcmp(oruzje, "WEAPON_COLT45", true)) { cijena = 100, id = 22;}
    else if(!strcmp(oruzje, "WEAPON_SILENCED", true)) { cijena = 200, id = 23;}
    else if(!strcmp(oruzje, "WEAPON_DEAGLE", true)) { cijena = 1000, id = 24;}
    else if(!strcmp(oruzje, "WEAPON_SHOTGUN", true)) { cijena = 1500, id = 25;}
    else if(!strcmp(oruzje, "WEAPON_SHOTGSPA", true)) { cijena = 2000, id = 27;}
    else if(!strcmp(oruzje, "WEAPON_UZI", true)) { cijena = 3000, id = 28;}
    else if(!strcmp(oruzje, "WEAPON_MP5", true)) { cijena = 4000, id = 29;}
    else if(!strcmp(oruzje, "WEAPON_AK47", true)) { cijena = 4500, id = 30;}
    else if(!strcmp(oruzje, "WEAPON_M4", true)) { cijena = 5000, id = 31;}
    else if(!strcmp(oruzje, "WEAPON_TEC9", true)) { cijena = 3500, id = 32;}
    else if(!strcmp(oruzje, "WEAPON_RIFLE", true)) { cijena = 5500, id = 33;}
    else if(!strcmp(oruzje, "WEAPON_SNIPER", true)) { cijena = 6000, id = 34;}
    else if(!strcmp(oruzje, "WEAPON_ROCKETLAUNCHER", true)) { cijena = 40000, id = 35;}
    else if(!strcmp(oruzje, "WEAPON_HEATSEEKER", true)) { cijena = 50000, id = 36;}
    else if(!strcmp(oruzje, "WEAPON_FLAMETHROWER", true)) { cijena = 20000, id = 37;}
    else { ERROR(playerid,"To oruzje nije na listi!"); return 1; }
	if(cijena > 1)
	{
		GivePlayerWeapon(targetid,id,metci);
	}
	SacuvajIgraca(targetid);
	new str[200];
	new nm[24];
	GetWeaponName(id,nm,sizeof(nm));
	format(str,sizeof(str),""zelena"Uspjesno ste dali oruzje %s(%d metaka) igracu %s!",nm,metci,GetName(targetid));
	SCM(playerid,-1,str);
	format(str,sizeof(str),""zelena"Admin %s vam je dao %s(%d metaka)!",GetName(playerid),nm,metci);
	SCM(targetid,-1,str);
	format(str, sizeof(str), ""crvena"[ORUZJE] "zuta"| Admin %s | Igracu %s | Oruzje %s | Metci %d |", GetName(playerid),GetName(targetid),nm,metci);
	SendAdminMessage(str);
	new lgg[200];
	format(lgg,sizeof(lgg),"[ORUZJE] | Admin %s | Igraca %s | Oruzje %s | Metci %d |",GetName(playerid),GetName(targetid),nm,metci);
	Log(ADMIN_LOG,lgg);
	return 1;
}
//==============================================================================
CMD:dajvip(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new targetid,time,level;
	if(sscanf(params,"udd",targetid,level,time))
	{
		USAGE(playerid,"/dajvip [Id/Ime][Level][Vrijeme u sekundama]!");
		return 1;
	}
	if(time < 1) return ERROR(playerid,"Ne mozete vrijeme manje od 1s!");
	if(level < 0 || level > 3) return ERROR(playerid,"Ne mozete manji od 0 ili veci od 3!");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(PlayerInfo[targetid][pVip] == 0)
	{
		new str[200];
		PlayerInfo[targetid][pVip] = level;
		PlayerInfo[targetid][pVipTime] = time;
	  	format(str,sizeof(str),""plava"Admin %s vam je dao vipa na %d sekundi.",GetName(playerid),time);
	   	SCM(targetid,-1,str);
	    format(str,sizeof(str),""crvena"[VIP] "zuta"| Admin %s | Igracu %s | Vrijeme %d | Level %d",GetName(playerid),GetName(targetid),time,level);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[VIP] | Admin %s | Igracu %s | Vrijeme %d | Level %d |",GetName(playerid),GetName(targetid),time,level);
		Log(ADMIN_LOG,lgg);
	}
	else if(level == 0)
	{
	    new str[200];
		PlayerInfo[targetid][pVip] = 0;
		PlayerInfo[targetid][pVipTime] = 0;
	  	format(str,sizeof(str),""plava"Admin %s vam je skinuo vipa.",GetName(playerid));
	   	SCM(targetid,-1,str);
	    format(str,sizeof(str),""crvena"[VIP] "zuta"| Admin %s | Igracu %s | Vrijeme 0 | Level 0",GetName(playerid),GetName(targetid),time,level);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[VIP] | Admin %s | Igracu %s | Vrijeme 0 | Level 0|",GetName(playerid),GetName(targetid));
		Log(ADMIN_LOG,lgg);
	}
	else if(PlayerInfo[targetid][pVip] != level)
	{
	    new str[200];
		PlayerInfo[targetid][pVip] = level;
		PlayerInfo[targetid][pVipTime] += time;
	  	format(str,sizeof(str),""plava"Admin %s vam je produzio vipa za %d sekundi.",GetName(playerid),time);
	   	SCM(targetid,-1,str);
	    format(str,sizeof(str),""crvena"[VIP] "zuta"| Admin %s | Igracu %s | Vrijeme +%d | Level %d",GetName(playerid),GetName(targetid),time,level);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[VIP] | Admin %s | Igracu %s | Vrijeme +%d | Level %d |",GetName(playerid),GetName(targetid),time,level);
		Log(ADMIN_LOG,lgg);
	}
	else
	{
	    new str[200];
		PlayerInfo[targetid][pVip] = level;
		PlayerInfo[targetid][pVipTime] += time;
	  	format(str,sizeof(str),""plava"Admin %s vam je produzio vipa %d za %d sekundi.",GetName(playerid),level,time);
	   	SCM(targetid,-1,str);
	    format(str,sizeof(str),""crvena"[VIP] "zuta"| Admin %s | Igracu %s | Vrijeme +%d | Level %d",GetName(playerid),GetName(targetid),time,level);
		SendAdminMessage(str);
		new lgg[200];
		format(lgg,sizeof(lgg),"[VIP] | Admin %s | Igracu %s | Vrijeme +%d | Level %d |",GetName(playerid),GetName(targetid),time,level);
		Log(ADMIN_LOG,lgg);
	}
	return 1;
}
//==============================================================================
CMD:settings(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new str[1000],str1[60];
	new txt[24];
	//--------------------------------------------------------------------------
	format(str,sizeof(str),"Opcija\tStanje\n");
	//--------------------------------------------------------------------------
	format(str1,sizeof(str1),""bijela"Ucitavanje\t%ds\n",PlayerInfo[playerid][pUcitavanje]);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(PlayerInfo[playerid][pChatbubble]) { txt = ""zelena"ON"; }
	else if(!PlayerInfo[playerid][pChatbubble]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Chat bubble([ TAG ])\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(PlayerInfo[playerid][pVipChat]) { txt = ""zelena"ON"; }
	else if(!PlayerInfo[playerid][pVipChat]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Vip chat\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(PlayerInfo[playerid][pGameMasterChat]) { txt = ""zelena"ON"; }
	else if(!PlayerInfo[playerid][pGameMasterChat]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"GameMaster chat\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(PlayerInfo[playerid][pAdminChat]) { txt = ""zelena"ON"; }
	else if(!PlayerInfo[playerid][pAdminChat]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Admin chat\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(PlayerInfo[playerid][pGotoSlabijih]) { txt = ""zelena"ON"; }
	else if(!PlayerInfo[playerid][pGotoSlabijih]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Goto slabijih\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(PlayerInfo[playerid][pGetSlabijih]) { txt = ""zelena"ON"; }
	else if(!PlayerInfo[playerid][pGetSlabijih]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Get slabijih\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(PlayerInfo[playerid][pKomandeSlabijih]) { txt = ""zelena"ON"; }
	else if(!PlayerInfo[playerid][pKomandeSlabijih]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Komande slabijih\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	if(PlayerInfo[playerid][pMapTeleport]) { txt = ""zelena"ON"; }
	else if(!PlayerInfo[playerid][pMapTeleport]) { txt = ""crvena"OFF"; }
	format(str1,sizeof(str1),""bijela"Map teleport\t%s\n",txt);
	strcat(str,str1);
	//--------------------------------------------------------------------------
	ShowPlayerDialog(playerid,DIALOG_SETTINGS,DIALOG_STYLE_TABLIST_HEADERS,""plava""IME" - Settings",str,"Izaberi","Odustani");
	return 1;
}
//==============================================================================
CMD:zavezi(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
    if(PlayerInfo[playerid][pUze] < 1) return ERROR(playerid,"Nemate uze!");
	new targetid;
	if(sscanf(params,"u",targetid)) return USAGE(playerid,"/zavezi [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Ne mozete zavezati samoga sebe!");
	if(AdminDuty[targetid]) return ERROR(playerid,"Igrac je admin na duznosti!");
	if(GameMasterDuty[targetid]) return ERROR(playerid,"Igrac je gamemaster na duznosti!");
	if(GetDistanceBetweenPlayers(playerid,targetid) > 5) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(IsPlayerInAnyVehicle(targetid)) return ERROR(playerid,"Igrac je u vozilu!");
    if(ImaLisice[targetid]) return ERROR(playerid,"Igrac ima lisice!");
	if(Vezan[targetid]) return ERROR(playerid,"Igrac je vec vezan!");
	SetPlayerSpecialAction(targetid,SPECIAL_ACTION_CUFFED);
	Vezan[targetid] = true;
	new str[50];
	new pnm[MAX_PLAYER_NAME];
	if(Marama[playerid]) { format(pnm,sizeof(pnm),"Stranac"); } else { format(pnm,sizeof(pnm),"%s",GetName(playerid)); }
	format(str,sizeof(str),""plava"Igrac %s vas je vezao!",pnm);
	SCM(targetid,-1,str);
 	GameTextForPlayer(targetid,"~r~VEZANI!",3000,3);
	return 1;
}
//==============================================================================
CMD:odvezi(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new targetid;
	if(sscanf(params,"u",targetid)) return USAGE(playerid,"/odvezi [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Ne mozete samoga sebe!");
	if(GetDistanceBetweenPlayers(playerid,targetid) > 5) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(!Vezan[targetid]) return ERROR(playerid,"Igrac nije vezan!");
	Vezan[targetid] = false;
	new str[50];
	new pnm[MAX_PLAYER_NAME];
	if(Marama[playerid]) { format(pnm,sizeof(pnm),"Stranac"); } else { format(pnm,sizeof(pnm),"%s",GetName(playerid)); }
	format(str,sizeof(str),""plava"Igrac %s vas je odvezao!",GetName(playerid));
	SCM(targetid,-1,str);
 	SetPlayerSpecialAction(targetid,SPECIAL_ACTION_NONE);
 	GameTextForPlayer(targetid,"~r~ODVEZANI!",3000,3);
	return 1;
}
//==============================================================================
CMD:vuci2(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	new targetid;
	if(sscanf(params,"u",targetid)) return USAGE(playerid,"/vuci2 [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Ne mozete samome sebi!");
	if(AdminDuty[targetid]) return ERROR(playerid,"Igrac je admin na duznosti!");
	if(GetDistanceBetweenPlayers(playerid,targetid) > 5) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(!Vezan[targetid]) return ERROR(playerid,"Igrac nije vezan!");
	if(IgracKojiGaVuce[targetid] != -1) return ERROR(playerid,"Netko vec vuce tog igraca!");
 	new str[50];
 	new pnm[MAX_PLAYER_NAME];
	if(Marama[playerid]) { format(pnm,sizeof(pnm),"Stranac"); } else { format(pnm,sizeof(pnm),"%s",GetName(playerid)); }
	format(str,sizeof(str),""plava"Igrac %s vas je poceo vuci!",GetName(playerid));
	SCM(targetid,-1,str);
 	IgracKojiGaVuce[targetid] = playerid;
 	IgracVuceTimer[targetid] = SetTimerEx("vuce2",1000,true,"d",targetid);
	return 1;
}
//==============================================================================
CMD:prestanivuci2(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
	new targetid;
	if(sscanf(params,"u",targetid)) return USAGE(playerid,"/prestanivuci2 [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Ne mozete samome sebi!");
	if(GetDistanceBetweenPlayers(playerid,targetid) > 5) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(IgracKojiGaVuce[targetid] != playerid) return ERROR(playerid,"Ne vucete tog igraca!");
  	new str[50];
  	new pnm[MAX_PLAYER_NAME];
	if(Marama[playerid]) { format(pnm,sizeof(pnm),"Stranac"); } else { format(pnm,sizeof(pnm),"%s",GetName(playerid)); }
	format(str,sizeof(str),""plava"Igrac %s vas je prestao vuci!",GetName(playerid));
	SCM(targetid,-1,str);
 	IgracKojiGaVuce[targetid] = -1;
 	KillTimer(IgracVuceTimer[targetid]);
	return 1;
}
//==============================================================================
CMD:portdoposla(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] < 1) return ERROR(playerid,"Niste ovlasteni!");
    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new id;
	if(sscanf(params,"d",id))
	{
		USAGE(playerid,"/portdoposla [Id posla]!");
		new str[50];
		for(new i=0;i<MAX_JOBS;i++)
		{
		    format(str,sizeof(str),"%d: %s",i,JobInfo[i][jName]);
		    INFO(playerid,str);
		}
		return 1;
	}
	if(id < 0 || id >= MAX_JOBS) return ERROR(playerid,"Pogresan posao!");
	PlayerInfo[playerid][pUbizzu] = -1;
	PlayerInfo[playerid][pUkuci] = -1;
	PlayerInfo[playerid][pUorg] = -1;
	PlayerInfo[playerid][pUstanu] = -1;
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid,JobInfo[id][jX],JobInfo[id][jY],JobInfo[id][jZ]);
	Freeze(playerid);
	new str[100];
	format(str,sizeof(str),"Portali ste se do posla %s!",JobInfo[id][jName]);
 	INFO(playerid,str);
	return 1;
}
//==============================================================================
CMD:refresh(playerid,params[])
{
    #pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pUbizzu] != -1)
	{
	    new id = PlayerInfo[playerid][pUbizzu];
	    SetPlayerVirtualWorld(playerid, BiznisInfo[id][bVW]);
		SetPlayerInterior(playerid, BiznisInfo[id][bInterior]);
	}
	else if(PlayerInfo[playerid][pUkuci] != -1)
	{
	    new id = PlayerInfo[playerid][pUkuci];
	    SetPlayerVirtualWorld(playerid, KucaInfo[id][kVW]);
		SetPlayerInterior(playerid, KucaInfo[id][kInterior]);
	}
	else if(PlayerInfo[playerid][pUorg] != -1)
	{
	    new id = PlayerInfo[playerid][pUorg];
	    SetPlayerVirtualWorld(playerid, OrgInfo[id][oVW]);
		SetPlayerInterior(playerid, OrgInfo[id][oInt]);
	}
	else if(PlayerInfo[playerid][pUstanu] != -1)
	{
	    new id = PlayerInfo[playerid][pUstanu];
	    SetPlayerVirtualWorld(playerid, StanInfo[id][sVW]);
		SetPlayerInterior(playerid, StanInfo[id][sInterior]);
	}
	else if(GetPlayerVirtualWorld(playerid) != 0)
	{
	    PlayerInfo[playerid][pUbizzu] = -1;
		PlayerInfo[playerid][pUkuci] = -1;
		PlayerInfo[playerid][pUorg] = -1;
		PlayerInfo[playerid][pUstanu] = -1;
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid));
		SetPlayerInterior(playerid, GetPlayerInterior(playerid));
	}
	else if(GetPlayerInterior(playerid) != 0)
	{
	    PlayerInfo[playerid][pUbizzu] = -1;
		PlayerInfo[playerid][pUkuci] = -1;
		PlayerInfo[playerid][pUorg] = -1;
		PlayerInfo[playerid][pUstanu] = -1;
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid));
		SetPlayerInterior(playerid, GetPlayerInterior(playerid));
	}
	else
	{
		PlayerInfo[playerid][pUbizzu] = -1;
		PlayerInfo[playerid][pUkuci] = -1;
		PlayerInfo[playerid][pUorg] = -1;
		PlayerInfo[playerid][pUstanu] = -1;
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerInterior(playerid, 0);
	}
    UpdateBankaZlatoTD(playerid);
    for(new i=0;i<sizeof(IgTextDraws);i++) { TextDrawHideForPlayer(playerid,IgTextDraws[i]); }
    for(new i=0;i<sizeof(IgTextDraws);i++) { TextDrawShowForPlayer(playerid,IgTextDraws[i]); }
    if(IsPlayerInAnyVehicle(playerid))
    {
        ShowBrzinomjer(playerid,false);
        ShowBrzinomjer(playerid,true);
    }
    else
    {
        ShowBrzinomjer(playerid,false);
    }
    Streamer_Update(playerid);
	new str[100];
	format(str,sizeof(str),"Uspjesno ste osvjezeni!");
	INFO(playerid,str);
	return 1;
}
//==============================================================================
CMD:weaponskills(playerid, params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new str[400];
	format(str,sizeof(str),""plava"Pistolj: "bijela"%d\n"plava"Silenced 9mm: "bijela"%d\n"plava"Desert Eagle: "bijela"%d\n"plava"Shotgun: "bijela"%d\n"plava"SawnOff: "bijela"%d\n"plava"Spas12 Shotgun: "bijela"%d\n"plava"Micro UZI: "bijela"%d\n"plava"MP5: "bijela"%d\n"plava"AK47: "bijela"%d\n"plava"M4: "bijela"%d\n"plava"Sniper: "bijela"%d",
	PlayerInfo[playerid][pWeaponSkill][0],PlayerInfo[playerid][pWeaponSkill][1],PlayerInfo[playerid][pWeaponSkill][2],PlayerInfo[playerid][pWeaponSkill][3],PlayerInfo[playerid][pWeaponSkill][4],PlayerInfo[playerid][pWeaponSkill][5],
	PlayerInfo[playerid][pWeaponSkill][6],PlayerInfo[playerid][pWeaponSkill][7],PlayerInfo[playerid][pWeaponSkill][8],PlayerInfo[playerid][pWeaponSkill][9],PlayerInfo[playerid][pWeaponSkill][10]);
	ShowPlayerDialog(playerid,DIALOG_STATS,DIALOG_STYLE_MSGBOX,""plava""IME" - Weapon skills:",str,""bijela"Ok","");
	return 1;
}
//==============================================================================
CMD:showweaponskills(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	new targetid;
	if(sscanf(params, "u", targetid)) return USAGE(playerid,"/showweaponskills [Id/Ime]");
	if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
	if(targetid == playerid) return ERROR(playerid,"Koristite /weaponskills!");
	new str[400];
	format(str,sizeof(str),""zuta"Ime: %s\n"plava"Pistolj: "bijela"%d\n"plava"Silenced 9mm: "bijela"%d\n"plava"Desert Eagle: "bijela"%d\n"plava"Shotgun: "bijela"%d\n"plava"SawnOff: "bijela"%d\n"plava"Spas12 Shotgun: "bijela"%d\n"plava"Micro UZI: "bijela"%d\n"plava"MP5: "bijela"%d\n"plava"AK47: "bijela"%d\n"plava"M4: "bijela"%d\n"plava"Sniper: "bijela"%d",
	GetName(playerid),PlayerInfo[playerid][pWeaponSkill][0],PlayerInfo[playerid][pWeaponSkill][1],PlayerInfo[playerid][pWeaponSkill][2],PlayerInfo[playerid][pWeaponSkill][3],PlayerInfo[playerid][pWeaponSkill][4],PlayerInfo[playerid][pWeaponSkill][5],
	PlayerInfo[playerid][pWeaponSkill][6],PlayerInfo[playerid][pWeaponSkill][7],PlayerInfo[playerid][pWeaponSkill][8],PlayerInfo[playerid][pWeaponSkill][9],PlayerInfo[playerid][pWeaponSkill][10]);
	ShowPlayerDialog(targetid,DIALOG_STATS,DIALOG_STYLE_MSGBOX,""plava""IME" - Weapon skills:",str,""bijela"Ok","");
	format(str, sizeof(str), "Pokazali ste skillove igracu %s!.", GetName(targetid));
	INFO(playerid,str);
	format(str, sizeof(str), "je pokazao skillove igracu %s.", GetName(targetid));
	Aktivnost(playerid,str);
	return 1;
}
//==============================================================================
CMD:trenirajskill(playerid,params[])
{
	#pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pUbizzu] == -1) return ERROR(playerid,"Niste u ammunationu!");
   	if(BiznisInfo[PlayerInfo[playerid][pUbizzu]][bVrsta] == AMMUNATION)
   	{
   	    if(Trenira[playerid] != -1) return ERROR(playerid,"Vec trenirate!");
		if(!PlayerInfo[playerid][pOruzjeDozvola]) return ERROR(playerid,"Nemate dozvolu za oruzje!");
		if(Radi[playerid]) return ERROR(playerid,"Radite!");
		if(AdminDuty[playerid]) return ERROR(playerid,"Ne mozete biti na admin duznosti!");
  		if(GameMasterDuty[playerid]) return ERROR(playerid,"Ne mozete biti na gamemaster duznosti!");
    	if(PolicijaDuty[playerid]) return ERROR(playerid,"Ne mozete biti na policijskoj duznosti!");
		if(polaganje[playerid] != -1) return ERROR(playerid,"Imate ukljuceno polaganje!");
        if(InEvent[playerid]) return ERROR(playerid,"Ne mozete u eventu!");
		if(!skill[playerid]) return ERROR(playerid,"Mozete trenirati svakih 10 minuta!");
		if(GetPlayerMoney(playerid) < 10000) return ERROR(playerid,"Potrebno vam je 10000$!");
   	    ShowPlayerDialog(playerid, DIALOG_TRENING, DIALOG_STYLE_LIST, ""plava""IME" - Izaberite oruzje za treniranje skilla:", ""bijela"Pistolj\n"plava"Silenced\n"bijela"Desert Eagle\n"plava"Shotgun\n"bijela"Sawnoff Shotgun\n"plava"Combat shotgun\n"bijela"Micro SMG\n"plava"MP5\n"bijela"AK47\n"plava"M4\n"bijela"Sniper", "Treniraj", "Odustani");
   	}
   	else return ERROR(playerid,"Niste u ammunationu!");
 	return 1;
}
//==============================================================================
CMD:prekinitreniranjeskilla(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(Trenira[playerid] != -1)
	{
 		DestroyPlayerObject(playerid,streljanaobject[playerid]);
        streljanaobject[playerid] = INVALID_OBJECT_ID;
   		Trenira[playerid] = -1;
   		new id = PlayerInfo[playerid][pUbizzu];
     	SetPlayerPos(playerid,BiznisInfo[id][bIzlazX], BiznisInfo[id][bIzlazY], BiznisInfo[id][bIzlazZ]);
		SetPlayerVirtualWorld(playerid,BiznisInfo[id][bVW]);
		SetPlayerInterior(playerid,BiznisInfo[id][bInterior]);
		Freeze(playerid);
		ResetPlayerWeapons(playerid);
		for(new i=0;i<13;i++)
		{
		    GivePlayerWeapon(playerid,oldWeapons[playerid][i],oldAmmo[playerid][i]);
		    oldWeapons[playerid][i] = 0;
		    oldAmmo[playerid][i] = 0;
		}
		TreniraState[playerid] = -1;
		new str[50];
		format(str,sizeof(str),"~r~Prekinuli ste treniranje skilla!");
	    GameTextForPlayer(playerid,str,3000,3);
	    format(str,sizeof(str),"Prekinuli ste treniranje skilla!");
	    INFO(playerid,str);
	}
	else return ERROR(playerid,"Ne trenirate!");
	return 1;
}
//==============================================================================
CMD:addspecnick(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 6)
	{
		new targetid[24];
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "s[24]", targetid)) return USAGE(playerid,"/addspecnick [Nick]");
		new str[50];
		format(str,sizeof(str),SPECNICKPATH,targetid);
		if(fexist(str)) return ERROR(playerid,"Taj spec nick vec postoji!");
		new string1[256];
		format(string1,sizeof(string1),""zelena"Kreirali ste spec nick %s!",targetid);
		SCM(playerid,-1,string1);
  		new File:fl = fopen(str, io_write);
	    fwrite(fl, "[SPEC-NICK]\n");
		format(string1,sizeof(string1),"\nKreirao admin %s\n",GetName(playerid));
        fwrite(fl, string1);
		fclose(fl);
	    new lgg[200];
		format(lgg,sizeof(lgg),"[SPEC-NICK] | Admin %s | Nick %s |",GetName(playerid),targetid);
		Log(ADMIN_LOG,lgg);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:deletespecnick(playerid, params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 6)
	{
		new targetid[24];
		if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
		if(sscanf(params, "s[24]", targetid)) return USAGE(playerid,"/deletespecnick [Nick]");
		new str[50];
		format(str,sizeof(str),SPECNICKPATH,targetid);
		if(!fexist(str)) return ERROR(playerid,"Taj spec nick ne postoji!");
		new string1[256];
		format(string1,sizeof(string1),""zelena"Obrisali ste spec nick %s!",targetid);
		SCM(playerid,-1,string1);
		fremove(str);
	    new lgg[200];
		format(lgg,sizeof(lgg),"[DELETE-SPEC-NICK] | Admin %s | Nick %s |",GetName(playerid),targetid);
		Log(ADMIN_LOG,lgg);
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:bug(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    new txt[200];
    if(sscanf(params,"s[200]",txt)) return USAGE(playerid,"/bug [Tekst]!");
    new str[120];
    format(str,sizeof(str),""crvena"[BUG] "bijela"| Igrac: %s[%d] | %s |",GetName(playerid),playerid,txt);
	SendAdminMessage(str);
	format(str,sizeof(str),""zuta"Poslali ste bug: "bijela"%s",txt);
	SCM(playerid,-1,str);
    new lgg[200];
	format(lgg,sizeof(lgg),"[BUG] | Igrac %s | %s |",GetName(playerid),txt);
	Log(BUG_LOG,lgg);
	return 1;
}
//==============================================================================
CMD:pokrenievent(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 2 || PlayerInfo[playerid][pGameMaster] == 3)
	{
		new id;
		if(sscanf(params, "d", id)) return USAGE(playerid,"/pokrenievent [Id]"), INFO(playerid,"0. Eksplozije u kavezu |");
		if(EventID != -1) return ERROR(playerid,"Netko je vec pokrenuo event!");
		if(EventPokrenut) return SCM(playerid,-1,"Event je u toku!");
		if(id == 0)
		{
		    EventID = 0;
		    EventPokrenut = false;
		    eksplozijepokrenut = false;
		    EventObjekti[0] = CreateDynamicObject(18753, 27.71030, 1519.81921, 42.32120,   0.00000, 90.00000, 180.00000,(MAX_PLAYERS+1),0,-1,200.0);
			EventObjekti[1] = CreateDynamicObject(18753, 2.59875, 1523.66907, 42.32115,   0.00000, 90.00000, 0.00000,(MAX_PLAYERS+1),0,-1,200.0);
			EventObjekti[2] = CreateDynamicObject(18753, -12.81650, 1562.17310, 42.32120,   0.00000, 90.00000, 270.00000,(MAX_PLAYERS+1),0,-1,200.0);
			EventObjekti[3] = CreateDynamicObject(18753, -17.56492, 1495.70105, 42.32120,   0.00000, 90.00000, 90.00000,(MAX_PLAYERS+1),0,-1,200.0);
			EventObjekti[4] = CreateDynamicObject(18753, -3.03290, 1507.02307, 59.95730,   0.00000, 180.00000, 0.00000,(MAX_PLAYERS+1),0,-1,200.0);
		    new str[100];
			format(str,sizeof(str),""zelena"Admin %s je pokrenuo event Eksplozije u kavezu.",GetName(playerid));
			SCMTA(-1,str);
			SCMTA(-1,""zelena"Da se pridruzite eventu upisite '/joinevent'");
		}
		else return ERROR(playerid,"Pogresan id!");
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:joinevent(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(Radi[playerid]) return ERROR(playerid,"Radite!");
    if(IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Izadite iz vozila!");
    if(GPSON[playerid]) return ERROR(playerid,"Imate ukljucen GPS!");
    if(polaganje[playerid] != -1) return ERROR(playerid,"Imate ukljuceno polaganje!");
    if(Trenira[playerid] != -1) return ERROR(playerid,"Trenirate skill!");
    if(AdminDuty[playerid]) return ERROR(playerid,"Ne mozete biti na admin duznosti!");
    if(GameMasterDuty[playerid]) return ERROR(playerid,"Ne mozete biti na gamemaster duznosti!");
    if(PolicijaDuty[playerid]) return ERROR(playerid,"Ne mozete biti na policijskoj duznosti!");
    if(GetPlayerInterior(playerid) != 0) return ERROR(playerid,"Ne smijete biti u interiouru!");
    if(GetPlayerVirtualWorld(playerid) != 0) return ERROR(playerid,"Ne smijete biti u interiouru!");
    if(PlayerInfo[playerid][pZatvoren]) return ERROR(playerid,"U zatvoru ste!");
    if(!spawned[playerid]) return ERROR(playerid,"Niste spawnovani!");
    if(EventID == -1) return ERROR(playerid,"Nema pokrenutih eventa!");
	if(EventPokrenut) return SCM(playerid,-1,"Event je vec zapoceo!");
	InEvent[playerid] = true;
	SetPlayerVirtualWorld(playerid,(MAX_PLAYERS+1));
	for(new i=0; i < 13; i++) { GetPlayerWeaponData(playerid,i,oldWeapons[playerid][i],oldAmmo[playerid][i]); }
	ResetPlayerWeapons(playerid);
	if(EventID == 0)
	{
	    new broj = random(7);
	    switch(broj)
	    {
	    	case 0: SetPlayerPos(playerid,23.4232,1499.6624,12.7500);
			case 1: SetPlayerPos(playerid,22.7310,1518.5305,12.7560);
			case 2: SetPlayerPos(playerid,21.7336,1543.7200,12.7500);
			case 3: SetPlayerPos(playerid,15.9142,1554.7715,12.7560);
			case 4: SetPlayerPos(playerid,13.9118,1543.4132,12.7500);
			case 5: SetPlayerPos(playerid,10.7492,1521.1968,12.7560);
			case 6: SetPlayerPos(playerid,7.0118,1504.8217,12.7560);
			default: SetPlayerPos(playerid,23.4232,1499.6624,12.7500);
		}
		SetPlayerHealth(playerid,99.0);
		SetPlayerArmour(playerid,0.0);
	}
	return 1;
}
//==============================================================================
CMD:stopevent(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 2 || PlayerInfo[playerid][pGameMaster] == 3)
	{
        if(EventID == -1) return ERROR(playerid,"Nema pokrenutih eventa!");
	    EventID = -1;
	    EventPokrenut = false;
		foreach(Player,i)
		{
		    if(InEvent[i])
		    {
		        TogglePlayerControllable(i,1);
		        InEvent[i] = false;
		        DisablePlayerRaceCheckpoint(playerid);
                DisablePlayerCheckpoint(playerid);
	        	SpawnPlayer(i);
			}
		}
		for(new i=0;i<sizeof(EventObjekti);i++)
		{
		    if(EventObjekti[i] != INVALID_OBJECT_ID)
		    {
		        DestroyDynamicObject(EventObjekti[i]);
		        EventObjekti[i] = INVALID_OBJECT_ID;
		    }
		}
		INFO(playerid,"Prekinuli ste event!");
	}
	else
	{
		ERROR(playerid,"Niste ovlasteni");
	}
	return 1;
}
//==============================================================================
CMD:eventcount(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] >= 2 || PlayerInfo[playerid][pGameMaster] == 3)
	{
	    if(EventID == -1) return ERROR(playerid,"Netko je vec pokrenuo event!");
		if(EventPokrenut) return SCM(playerid,-1,"Event je u toku!");
		foreach(Player,i)
		{
	    	if(InEvent[i])
	    	{
	        	EventCount(i,false);
			}
		}
		EventPokrenut = true;
		INFO(playerid,"Pokrenuli ste event!");
	}
	return 1;
}
//==============================================================================
CMD:kreirajstan(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] <= 5) return ERROR(playerid,"Niste ovlasteni!");
    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
    new id = -1;
	for(new i=0;i<MAX_STANOVA;i++)
	{
	    new str11[20];
	    format(str11,sizeof(str11),STANPATH,i);
	    if(!fexist(str11))
	    {
	        id = i;
	        break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Kreirali ste previse stanova!");
	StanInfo[id][sOwned] = false;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	StanInfo[id][sUlazX] = x;
	StanInfo[id][sUlazY] = y;
	StanInfo[id][sUlazZ] = z;
	StanInfo[id][sVW] = id;
	StanInfo[id][sMoney] = 0;
	StanInfo[id][sOruzje][0] = -1;
	StanInfo[id][sMunicija][0] = 0;
	StanInfo[id][sOruzje][1] = -1;
	StanInfo[id][sMunicija][1] = 0;
	StanInfo[id][sOruzje][2] = -1;
	StanInfo[id][sMunicija][2] = 0;
	StanInfo[id][sDroga] = 0;
	StanInfo[id][sMats] = 0;
	StanInfo[id][sLocked] = true;
	new str[MAX_PLAYER_NAME];
	StanInfo[id][sIzlazX] = 92.6234;
	StanInfo[id][sIzlazY] = 1680.4272;
	StanInfo[id][sIzlazZ] = -70.4174;
	StanInfo[id][sInterior] = 0;
	format(str,sizeof(str),"Stan");
	strmid(StanInfo[id][sName], str, 0, strlen(str), MAX_PLAYER_NAME);
	StanInfo[id][sLevel] = 7;
	StanInfo[id][sPrice] = 1200000;

	new str3[200];
	format(str3,sizeof(str3),""zuta"Stan na prodaju!\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\n"zuta"Da kupite stan upisite "bijela"'/kupistan'",StanInfo[id][sName],StanInfo[id][sLevel],StanInfo[id][sPrice]);
	sText[id] = Create3DTextLabel(str3, -1, StanInfo[id][sUlazX], StanInfo[id][sUlazY], StanInfo[id][sUlazZ], 20.0, 0, 0);
	StanInfo[id][sUnutraPic] = CreateDynamicPickup(1239, 1, StanInfo[id][sIzlazX], StanInfo[id][sIzlazY], StanInfo[id][sIzlazZ], StanInfo[id][sVW]);
	StanInfo[id][sIzvanPic] = CreateDynamicPickup(19524, 1, StanInfo[id][sUlazX], StanInfo[id][sUlazY], StanInfo[id][sUlazZ], -1);
	SacuvajStan(id);
	return 1;
}
//==============================================================================
CMD:kreirajstanex(playerid,params[])
{
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(PlayerInfo[playerid][pAdmin] <= 5) return ERROR(playerid,"Niste ovlasteni!");
    if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new level,price;
	if(sscanf(params,"dd",level,price))
	{
		USAGE(playerid,"/kreirajstanex [level][cijena]");
		return 1;
	}
	if(price < 1 || level < 1) return ERROR(playerid,"Cijena ili level nesmiju biti manji od 1!");
    new id = -1;
	for(new i=0;i<MAX_STANOVA;i++)
	{
	    new str11[20];
	    format(str11,sizeof(str11),STANPATH,i);
	    if(!fexist(str11))
	    {
	        id = i;
	        break;
	    }
	}
	if(id == -1) return ERROR(playerid,"Kreirali ste previse stanova!");
	StanInfo[id][sOwned] = false;
	StanInfo[id][sLevel] = level;
	StanInfo[id][sPrice] = price;
	StanInfo[id][sOwned] = false;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	StanInfo[id][sUlazX] = x;
	StanInfo[id][sUlazY] = y;
	StanInfo[id][sUlazZ] = z;
	StanInfo[id][sVW] = id;
	StanInfo[id][sMoney] = 0;
	StanInfo[id][sOruzje][0] = -1;
	StanInfo[id][sMunicija][0] = 0;
	StanInfo[id][sOruzje][1] = -1;
	StanInfo[id][sMunicija][1] = 0;
	StanInfo[id][sOruzje][2] = -1;
	StanInfo[id][sMunicija][2] = 0;
	StanInfo[id][sDroga] = 0;
	StanInfo[id][sMats] = 0;
	StanInfo[id][sLocked] = true;
	new str[MAX_PLAYER_NAME];
	StanInfo[id][sIzlazX] = 92.6234;
	StanInfo[id][sIzlazY] = 1680.4272;
	StanInfo[id][sIzlazZ] = -70.4174;
	StanInfo[id][sInterior] = 0;
	format(str,sizeof(str),"Stan");
	strmid(StanInfo[id][sName], str, 0, strlen(str), MAX_PLAYER_NAME);
	
	new str3[200];
	format(str3,sizeof(str3),""zuta"Stan na prodaju!\n"bijela"Ime: %s\n"bijela"Level: %d\n"bijela"Cijena: %d$\n"zuta"Da kupite stan upisite "bijela"'/kupistan'",StanInfo[id][sName],StanInfo[id][sLevel],StanInfo[id][sPrice]);
	sText[id] = Create3DTextLabel(str3, -1, StanInfo[id][sUlazX], StanInfo[id][sUlazY], StanInfo[id][sUlazZ], 20.0, 0, 0);
	StanInfo[id][sUnutraPic] = CreateDynamicPickup(1239, 1, StanInfo[id][sIzlazX], StanInfo[id][sIzlazY], StanInfo[id][sIzlazZ], StanInfo[id][sVW]);
	StanInfo[id][sIzvanPic] = CreateDynamicPickup(19524, 1, StanInfo[id][sUlazX], StanInfo[id][sUlazY], StanInfo[id][sUlazZ], -1);
	SacuvajStan(id);
	return 1;
}
//==============================================================================
CMD:kupistan(playerid,params[])
{
    #pragma unused params
	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pStanID] != -1) return ERROR(playerid,"Vec ste vlasnik nekog stana!");
	new id = GetStan(playerid);
	if(id == -1) return ERROR(playerid,"Niste u blizni stana!");
	if(StanInfo[id][sOwned]) return ERROR(playerid,"Ovaj stan nije na prodaju!");
	if(GetPlayerMoney(playerid) < StanInfo[id][sPrice]) return ERROR(playerid,"Nemate dovoljno novca!");
	if(PlayerInfo[playerid][pLevel] < StanInfo[id][sLevel]) return ERROR(playerid,"Nemate dovoljan level!");
	StanInfo[id][sOwned] = true;
	StanInfo[id][sOwnerName] = RemoveUnderLine(GetName(playerid));
	StanLP(id);
	StanInfo[id][sLocked] = true;
	PlayerInfo[playerid][pMoney] -= StanInfo[id][sPrice];
	GivePlayerMoney(playerid,-StanInfo[id][sPrice]);
	PlayerInfo[playerid][pStanID] = id;
	SacuvajStan(id);
	SacuvajIgraca(playerid);
	ClearChat(playerid);
	INFO(playerid,"Uspjesno ste kupili stan!");
	INFO(playerid,"Za upravljanje stanom koristite "zuta"'/stan'");
	return 1;
}
//==============================================================================
CMD:stan(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pStanID] == -1) return ERROR(playerid,"Nemate stan!");
	if(PlayerInfo[playerid][pStanID] != GetStan(playerid)) return ERROR(playerid,"Nisi kod svojeg stana!");
	ShowPlayerDialog(playerid,DIALOG_STAN,DIALOG_STYLE_LIST,""zuta""IME" - Stan:",""zelena"Otkljucaj"bijela"/"crvena"Zakljucaj\n"bijela"Prodaj drzavi\n"zuta"Informacije\n"bijela"Promijeni ime\n"zuta"Ostavi/uzmi","Izaberi","Odustani");
    Aktivnost(playerid,"upravlja stanom.");
	return 1;
}
//==============================================================================
CMD:izbrisistan(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	new id;
	if(sscanf(params,"d",id)) return USAGE(playerid,"/izbrisistan [Id]");
    new str2[20];
    format(str2,sizeof(str2),STANPATH,id);
	if(!fexist(str2))
	{
	    ERROR(playerid,"Taj stan ne postoji!");
	}
	else
	{
	 	StanInfo[id][sOwned] = false;
	 	StanInfo[id][sUlazX] = 0.0;
		StanInfo[id][sUlazY] = 0.0;
		StanInfo[id][sUlazZ] = 0.0;
		StanInfo[id][sVW] = 0;
		StanInfo[id][sIzlazX] = 0.0;
		StanInfo[id][sIzlazY] = 0.0;
		StanInfo[id][sIzlazZ] = 0.0;
		StanInfo[id][sInterior] = 0;
		strmid(StanInfo[id][sName], "~n~", 0, strlen("~n~"), MAX_PLAYER_NAME);
		StanInfo[id][sVrsta] = 0;
		StanInfo[id][sLevel] = 0;
		StanInfo[id][sPrice] = 0;
		StanInfo[id][sMoney] = 0;
		StanInfo[id][sOruzje][0] = -1;
		StanInfo[id][sMunicija][0] = 0;
		StanInfo[id][sOruzje][1] = -1;
		StanInfo[id][sMunicija][1] = 0;
		StanInfo[id][sOruzje][2] = -1;
		StanInfo[id][sMunicija][2] = 0;
		StanInfo[id][sDroga] = 0;
		StanInfo[id][sMats] = 0;
		DestroyDynamicPickup(StanInfo[id][sUnutraPic]);
		DestroyDynamicPickup(StanInfo[id][sIzvanPic]);
		Delete3DTextLabel(sText[id]);
	 	fremove(str2);
	 	INFO(playerid,"Uspjesno ste obrisali stan!");
	}
	return 1;
}
//==============================================================================
CMD:getstanid(playerid,params[])
{
    #pragma unused params
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 6) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(GetStan(playerid) == -1) return ERROR(playerid,"Niste kod ulaza u niti jedan stan!");
	new str[50];
	format(str,sizeof(str),""zuta"Vi ste kod stana %d",GetStan(playerid));
	SCM(playerid,-1,str);
	return 1;
}
//==============================================================================
CMD:portdostana(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
	if(PlayerInfo[playerid][pAdmin] < 1) return ERROR(playerid,"Niste ovlasteni!");
	if(!AdminDuty[playerid]) return ERROR(playerid,"Niste na duznosti!");
	if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new id;
	if(sscanf(params,"d",id)) return USAGE(playerid,"/portdostana [Id]");
 	new str[50];
    format(str,sizeof(str),STANPATH,id);
	if(!fexist(str)) return ERROR(playerid,"Taj stan ne postoji!");
	PlayerInfo[playerid][pUkuci] = -1;
	PlayerInfo[playerid][pUbizzu] = -1;
	PlayerInfo[playerid][pUorg] = -1;
	PlayerInfo[playerid][pUstanu] = -1;
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetPlayerPos(playerid,StanInfo[id][sUlazX], StanInfo[id][sUlazY], StanInfo[id][sUlazZ]);
	Freeze(playerid);
	format(str,sizeof(str),""zuta"Portali ste se do stana! ID:%d",id);
	INFO(playerid,str);
	return 1;
}
//==============================================================================
CMD:sellstanto(playerid,params[])
{
    if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
    if(InEvent[playerid]) return ERROR(playerid,"U eventu ste!");
	new targetid,cijena;
	if(sscanf(params,"ud",targetid,cijena)) return USAGE(playerid,"/sellstanto [Id/Ime][Cijena]!");
    if(!IsPlayerConnected(targetid)) return ERROR(playerid,"Taj igrac nije u igri!");
    if(targetid == playerid) return ERROR(playerid,"Ne mozete ponuditi sami sebi!");
	if(PlayerInfo[playerid][pStanID] == -1) return ERROR(playerid,"Nemate stan!");
	if(GetStan(playerid) != PlayerInfo[playerid][pStanID]) return ERROR(playerid,"Niste kod ulaza u svoj stan!");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(targetid,x,y,z);
	if(!IsPlayerInRangeOfPoint(playerid,5.0,x,y,z)) return ERROR(playerid,"Niste u blizini tog igraca!");
	if(cijena < 1) return ERROR(playerid,"Nemozete za manje od 1$!");
	if(PlayerInfo[targetid][pStanID] != -1) return ERROR(playerid,"Igrac posjeduje stan!");
	PonudioS[targetid] = playerid; CijenaS[targetid] = cijena;
	new str[300];
	format(str,sizeof(str),""zelena"Ponudili ste vas stan igracu %s!",GetName(targetid));
	SCM(playerid,-1,str);
	format(str,sizeof(str),""crvena"PRODAJA\n"bijela"Igrac "zuta"%s "bijela"vam je ponudio stan id "zuta"%d "bijela"za "zuta"%d$\n"bijela"Da prihvatite upisite "zuta"PRIHVATI "bijela"sa velikim slovima!",GetName(playerid),PlayerInfo[playerid][pStanID],cijena);
	ShowPlayerDialog(targetid,DIALOG_SELLSTANTO,DIALOG_STYLE_INPUT,""plava""IME" - Kupovina",str,"Dalje","Odustani");
	return 1;
}
//==============================================================================
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    //--------------------------------------------------------------------------
    ProvjeraZaVozilo(playerid, vehicleid);
    //--------------------------------------------------------------------------
	return 1;
}
//==============================================================================
public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}
//==============================================================================
public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
	    new str[150],id;
	    id = GetPlayerVehicleID(playerid);
	    format(str,sizeof(str),"je usao u vozilo marke %s.",GetVehicleName(id));
	    Aktivnost(playerid,str);
	}
	if(oldstate == PLAYER_STATE_ONFOOT && (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER))
 	{
 	    ShowBrzinomjer(playerid,true);
		updateg[playerid] = SetTimerEx("updategorivo",1000,true,"d",playerid);
	}
	if(newstate == PLAYER_STATE_ONFOOT && (oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER))
 	{
	 	ShowBrzinomjer(playerid,false);
		KillTimer(updateg[playerid]);
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
	    for(new i;i<MAX_VOZILA;i++)
		{
		    if(VoziloInfo[i][vID] == GetPlayerVehicleID(playerid))
		    {
	    		if(!VoziloInfo[i][vOwned])
	    		{
	        		TogglePlayerControllable(playerid, 0);
	        		ClearChat(30);
	        		SCM(playerid,-1,""zelena"Vozilo na prodaju!");
	       		 	SCM(playerid,-1,""zelena"Da kupite vozilo upisite "zuta"/kupivozilo");
	       		 	SCM(playerid,-1,""zelena"Da izadete iz vozila upisite "zuta"/izlaz");
				}
			}
	    }
	    
	    if(VoziloJeMotor(GetPlayerVehicleID(playerid)) && !PlayerInfo[playerid][pMotorDozvola]) { INFO(playerid,"Nemate dozvolu za voznju motora!"); }
	    else if(VoziloJeKamion(GetPlayerVehicleID(playerid)) && !PlayerInfo[playerid][pKamionDozvola]) { INFO(playerid,"Nemate dozvolu za voznju kamiona!"); }
        else if(VoziloJeBrod(GetPlayerVehicleID(playerid)) && !PlayerInfo[playerid][pBrodDozvola]) { INFO(playerid,"Nemate dozvolu za voznju broda!"); RemovePlayerFromVehicle(playerid); }
        else if(VoziloJeAvion(GetPlayerVehicleID(playerid)) && !PlayerInfo[playerid][pLetjeliceDozvola]) { INFO(playerid,"Nemate dozvolu za voznju letjelica!"); RemovePlayerFromVehicle(playerid); }
		else if(VoziloJeBicikl(GetPlayerVehicleID(playerid))) { }
		else if(!PlayerInfo[playerid][pVozackaDozvola]) { INFO(playerid,"Nemate vozacku dozvolu!"); }
		
		new vehid = GetPlayerVehicleID(playerid);
	    if(VoziloZaRent[vehid])
	    {
	        if(RentaVozilo[playerid] && IdRentVozila[playerid] != vehid) return RemovePlayerFromVehicle(playerid), ERROR(playerid,"Ovo nije vase rentano vozilo!");
     		if(VoziloRentano[vehid] && IdRentVozila[playerid] != vehid)
 			{
    			RemovePlayerFromVehicle(playerid);
    			ERROR(playerid,"Ovo nije vase rentano vozilo!");
			}
			else if(!VoziloRentano[vehid] && !RentaVozilo[playerid])
			{
			    TogglePlayerControllable(playerid,0);
			    new str[200];
			    format(str,sizeof(str),""plava"Usli ste u rent vozilo!\n"bijela"Upisite na koliko minuta zelite rentati vozilo.\n"zelena"Cijena po minuti: "crvena"%d$",ServerInfo[sRentCijena]);
			    ShowPlayerDialog(playerid,DIALOG_RENT,DIALOG_STYLE_INPUT,""plava""IME" - Rent:",str,"Rentaj","Odustani");
			}
		}
	}
	return 1;
}
//==============================================================================
public OnPlayerRequestSpawn(playerid)
{
    //--------------------------------------------------------------------------
    if(!Ulogovan[playerid]) return 0;
    //--------------------------------------------------------------------------
	return 1;
}
//==============================================================================
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	//--------------------------------------------------------------------------
	if(!Ulogovan[playerid]) return 1;
    //--------------------------------------------------------------------------
    if(PRESSED(KEY_YES))
	{
	    new d=-1;
	    if(!IsPlayerInAnyVehicle(playerid))
	    {
	        foreach(Player,i)
	        {
	            if(IsPlayerInRangeOfPoint(playerid,2.0,DrogaInfo[i][dX],DrogaInfo[i][dY],DrogaInfo[i][dZ]))
	            {
	                if(DrogaInfo[i][dUsed])
	                {
	                    if(PlayerInfo[playerid][pOrgID] == POLICIJA)
						{
                            DrogaInfo[i][dX] = DrogaInfo[i][dY] =
							DrogaInfo[i][dZ] = DrogaInfo[i][dRotX] =
							DrogaInfo[i][dRotY] = DrogaInfo[i][dRotZ] = 0.0;
							DestroyDynamicObject(DrogaInfo[i][dObject]);
							DrogaInfo[i][dUsed] = false; DrogaInfo[i][dIzrasla] = 0;
							Delete3DTextLabel(DrogaText[i]);
							PlayerInfo[playerid][pMoney] += 10000;
							GivePlayerMoney(playerid, 10000);
							SCM(playerid,-1,""zelena"Uspjesno ste unistili drogu! Nagrada: 10000$");
							SacuvajIgraca(playerid);
							d = 1;
						}
	                    else if(DrogaInfo[i][dIzrasla] == 5 && PlayerInfo[playerid][pOrgID] != POLICIJA)
						{
							DrogaInfo[i][dX] = DrogaInfo[i][dY] =
							DrogaInfo[i][dZ] = DrogaInfo[i][dRotX] =
							DrogaInfo[i][dRotY] = DrogaInfo[i][dRotZ] = 0.0;
							DestroyDynamicObject(DrogaInfo[i][dObject]);
							DrogaInfo[i][dUsed] = false; DrogaInfo[i][dIzrasla] = 0;
							Delete3DTextLabel(DrogaText[i]);
							PlayerInfo[playerid][pDroga] += 20;
							SCM(playerid,-1,""zelena"Uspjesno ste ubrali 15g droge!");
							SacuvajIgraca(playerid);
							d = 1;
						}
					}
				}
			}
	    }
	    if(d == -1)
	    {
	    	SelectTextDraw(playerid, 0x7F7F7FFF);
			INFO(playerid,"Ukljucili ste pokazivac misa!");
		}
	}
	//--------------------------------------------------------------------------
	if(PRESSED(KEY_SECONDARY_ATTACK))
	{
	    if(!IsPlayerInAnyVehicle(playerid))
	    {
	        if(IsPlayerInRangeOfPoint(playerid,2.0,1454.7629,-1010.1432,26.8438) && GetPlayerVirtualWorld(playerid) == 0)//banka
		    {
		        SetPlayerPos(playerid,653.9196,352.7068,668.6714);
		        SetPlayerFacingAngle(playerid,354.7242);
				SetPlayerVirtualWorld(playerid,1);
				SetPlayerInterior(playerid,0);
				if(!PolicijaDuty[playerid]) { Freeze(playerid); }
		    }
		    else if(IsPlayerInRangeOfPoint(playerid,2.0,653.9196,352.7068,668.6714))
		    {
		        SetPlayerPos(playerid,1454.7629,-1010.1432,26.8438);
		        SetPlayerFacingAngle(playerid,184.1635);
				SetPlayerVirtualWorld(playerid,0);
				SetPlayerInterior(playerid,0);
				if(!PolicijaDuty[playerid]) { Freeze(playerid); }
		    }
		    
		    if(IsPlayerInRangeOfPoint(playerid,2.0,1123.1215,-2036.8429,69.8936) && GetPlayerVirtualWorld(playerid) == 0)//opstina
		    {
		        SetPlayerPos(playerid,-829.3412,1432.2792,689.9901);
		        SetPlayerFacingAngle(playerid,4.4610);
				SetPlayerVirtualWorld(playerid,2);
				SetPlayerInterior(playerid,0);
				Freeze(playerid);
		    }
		    else if(IsPlayerInRangeOfPoint(playerid,2.0,-829.3412,1432.2792,689.9901))
		    {
		        SetPlayerPos(playerid,1123.1215,-2036.8429,69.8936);
		        SetPlayerFacingAngle(playerid,270.4601);
				SetPlayerVirtualWorld(playerid,0);
				SetPlayerInterior(playerid,0);
				Freeze(playerid);
		    }
		    
		    if(IsPlayerInRangeOfPoint(playerid,2.0,2793.2649,-1087.4554,30.7188) && GetPlayerVirtualWorld(playerid) == 0)//zlatara
		    {
		        SetPlayerPos(playerid,2838.1379,-1118.9884,-79.1271);
		        SetPlayerFacingAngle(playerid,6.0276);
				SetPlayerVirtualWorld(playerid,3);
				SetPlayerInterior(playerid,0);
				Freeze(playerid);
		    }
		    else if(IsPlayerInRangeOfPoint(playerid,2.0,2838.1379,-1118.9884,-79.1271))
		    {
		        SetPlayerPos(playerid,2793.2649,-1087.4554,30.7188);
		        SetPlayerFacingAngle(playerid,269.8802);
				SetPlayerVirtualWorld(playerid,0);
				SetPlayerInterior(playerid,0);
				Freeze(playerid);
		    }

			if(IsPlayerInRangeOfPoint(playerid,2.0,1765.0228,-1761.0403,13.8795))//autosalon
		    {
		        SetPlayerPos(playerid,1767.7019,-1761.0333,13.8998);
		        SetPlayerFacingAngle(playerid,272.6763);
				SetPlayerVirtualWorld(playerid,0);
				SetPlayerInterior(playerid,0);
				Freeze(playerid);
		    }
		    else if(IsPlayerInRangeOfPoint(playerid,2.0,1767.7019,-1761.0333,13.8998))
		    {
		        SetPlayerPos(playerid,1765.0228,-1761.0403,13.8795);
		        SetPlayerFacingAngle(playerid,87.5184);
				SetPlayerVirtualWorld(playerid,0);
				SetPlayerInterior(playerid,0);
				Freeze(playerid);
		    }
		    
		    if(IsPlayerInRangeOfPoint(playerid,2.0,246.3414,87.8023,1003.6406) && GetPlayerVirtualWorld(playerid) == 9 && PlayerInfo[playerid][pOrgID] == POLICIJA && !PlayerInfo[playerid][pZatvoren])//policija krov 
		    {
		        SetPlayerPos(playerid,1549.5526,-1651.2445,23.3800);
		        SetPlayerFacingAngle(playerid,277.9876);
				SetPlayerVirtualWorld(playerid,0);
				SetPlayerInterior(playerid,0);
                PlayerInfo[playerid][pUorg] = -1;
				Freeze(playerid);
		    }
		    else if(IsPlayerInRangeOfPoint(playerid,2.0,1549.5526,-1651.2445,23.3800) && PlayerInfo[playerid][pOrgID] == POLICIJA && !PlayerInfo[playerid][pZatvoren] && GetPlayerVirtualWorld(playerid) == 0)
		    {
		        SetPlayerPos(playerid,246.3414,87.8023,1003.6406);
		        SetPlayerFacingAngle(playerid,182.6438);
				SetPlayerVirtualWorld(playerid,9);
				SetPlayerInterior(playerid,6);
				PlayerInfo[playerid][pUorg] = POLICIJA;
				Freeze(playerid);
		    }
		    
		    if(IsPlayerInRangeOfPoint(playerid,2.0,2055.9624,-1914.2329,13.5680) && GetPlayerVirtualWorld(playerid) == 0)//autoskola
		    {
		        SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
		        SetPlayerFacingAngle(playerid,9.0473);
				SetPlayerVirtualWorld(playerid,10);
				SetPlayerInterior(playerid,3);
				Freeze(playerid);
		    }
		    else if(IsPlayerInRangeOfPoint(playerid,2.0,-2029.7234,-119.4169,1035.1719))
		    {
		        SetPlayerPos(playerid,2055.9624,-1914.2329,13.5680);
		        SetPlayerFacingAngle(playerid,262.7916);
				SetPlayerVirtualWorld(playerid,0);
				SetPlayerInterior(playerid,0);
				Freeze(playerid);
		    }
		    
		    if(IsPlayerInRangeOfPoint(playerid,2.0,664.3455,384.0997,657.0206))//banka ventilacija
		    {
		        if(GetPlayerVirtualWorld(playerid) == 1 && !AdminDuty[playerid] && !GameMasterDuty[playerid])
		        {
			        new d = 0;
					foreach(Player,i)
					{
				 		if(PlayerInfo[i][pOrgID] == POLICIJA)
						{
							d++;
						}
					}
					if(d >= 2)
					{
				        SetPlayerPos(playerid,650.3130,408.9044,651.3528+1);
						SetPlayerVirtualWorld(playerid,1);
						SetPlayerInterior(playerid,0);
						if(!PolicijaDuty[playerid]) { Freeze(playerid); }
						if(PlayerInfo[playerid][pOrgID] != POLICIJA)
						{
							new rand = random(10);
							if(rand == 5 || rand == 2 || rand == 8 )
							{
						    	PostaviZlocin(playerid,"Banka","Provala u sef",3);
		                    	foreach(Player,i)
								{
									if(PlayerInfo[i][pOrgID] == POLICIJA)
									{
								    	SCM(i,-1,""bijela"-------------------------------");
								    	SCM(i,-1,""zelena"Netko je provalio u sef banke!");
								    	SCM(i,-1,""bijela"-------------------------------");
									}
								}
							}
				    	}
					}
					else
					{
						ERROR(playerid,"Nema dovoljno policajaca na serveru!");
					}
				}
				else { ERROR(playerid,"Niste u banci! Ne smijete biti na admin ili gamemaster duznost!"); }
			}
		    
		    if(PlayerInfo[playerid][pUbizzu] == -1 && GetPlayerVirtualWorld(playerid) == 0)
		    {
				new id = GetBiznis(playerid);
				if(id != -1)
				{
					if(BiznisInfo[id][bLocked])
					{ GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); }
					else
					{
						SetPlayerPos(playerid,BiznisInfo[id][bIzlazX], BiznisInfo[id][bIzlazY], BiznisInfo[id][bIzlazZ]);
						SetPlayerVirtualWorld(playerid,BiznisInfo[id][bVW]);
						SetPlayerInterior(playerid,BiznisInfo[id][bInterior]);
						PlayerInfo[playerid][pUbizzu] = id;
						Freeze(playerid);
						if(BiznisInfo[id][bVrsta] == SHOP) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); }
						else if(BiznisInfo[id][bVrsta] == SEX_SHOP) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); }
						else if(BiznisInfo[id][bVrsta] == AMMUNATION) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za treniranje weapon skilla koristite "zuta"'/trenirajskill'"zelena"."); }
						else if(BiznisInfo[id][bVrsta] == KLADIONICA) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kladionica'"zelena"."); }
						else if(BiznisInfo[id][bVrsta] == BINCO) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); }
						else if(BiznisInfo[id][bVrsta] == BAR) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); }
						else if(BiznisInfo[id][bVrsta] == DISCO) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); }
		                else if(BiznisInfo[id][bVrsta] == PIZZA) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/kupi'"zelena"."); }
		                else if(BiznisInfo[id][bVrsta] == POSTA) { SCM(playerid,-1,""siva"[BIZNIS] "zelena"Za kupovinu u ovom biznisu koristite "zuta"'/uplati'"zelena"."); }
					}
				}
		    }
		    else if(PlayerInfo[playerid][pUbizzu] != -1)
		    {
				new id = PlayerInfo[playerid][pUbizzu];
				if(IsPlayerInRangeOfPoint(playerid,2.0,BiznisInfo[id][bIzlazX], BiznisInfo[id][bIzlazY], BiznisInfo[id][bIzlazZ]))
				{
					SetPlayerPos(playerid,BiznisInfo[id][bUlazX], BiznisInfo[id][bUlazY], BiznisInfo[id][bUlazZ]);
					SetPlayerVirtualWorld(playerid,0);
					SetPlayerInterior(playerid,0);
					PlayerInfo[playerid][pUbizzu] = -1;
					Freeze(playerid);
				}
	   		}
	   		
	   		if(PlayerInfo[playerid][pUkuci] == -1 && GetPlayerVirtualWorld(playerid) == 0)
		    {
				new id = GetKuca(playerid);
				if(id != -1)
				{
					if(KucaInfo[id][kLocked]) { GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); }
					else
					{
						SetPlayerPos(playerid,KucaInfo[id][kIzlazX], KucaInfo[id][kIzlazY], KucaInfo[id][kIzlazZ]);
						SetPlayerVirtualWorld(playerid,KucaInfo[id][kVW]);
						SetPlayerInterior(playerid,KucaInfo[id][kInterior]);
						PlayerInfo[playerid][pUkuci] = id;
						Freeze(playerid);
					}
				}
		    }
		    else if(PlayerInfo[playerid][pUkuci] != -1)
		    {
				new id = PlayerInfo[playerid][pUkuci];
				if(IsPlayerInRangeOfPoint(playerid,2.0,KucaInfo[id][kIzlazX], KucaInfo[id][kIzlazY], KucaInfo[id][kIzlazZ]))
				{
					SetPlayerPos(playerid,KucaInfo[id][kUlazX], KucaInfo[id][kUlazY], KucaInfo[id][kUlazZ]);
					SetPlayerVirtualWorld(playerid,0);
					SetPlayerInterior(playerid,0);
					PlayerInfo[playerid][pUkuci] = -1;
					Freeze(playerid);
				}
			}
			
			if(PlayerInfo[playerid][pUorg] == -1 && GetPlayerVirtualWorld(playerid) == 0)
			{
				for(new i=0;i<MAX_ORGS;i++)
			    {
	      			if(IsPlayerInRangeOfPoint(playerid,2.0,OrgInfo[i][oUlazX],OrgInfo[i][oUlazY],OrgInfo[i][oUlazZ]))
	       			{
	          			if((PlayerInfo[playerid][pOrgID] == i || PlayerInfo[playerid][pAdmin] >= 1) || i == POLICIJA)
		            	{
		            	    SetPlayerPos(playerid,OrgInfo[i][oIzlazX], OrgInfo[i][oIzlazY], OrgInfo[i][oIzlazZ]);
		            	    SetPlayerFacingAngle(playerid,OrgInfo[i][oIzlazAZ]);
							SetPlayerVirtualWorld(playerid,OrgInfo[i][oVW]);
							SetPlayerInterior(playerid,OrgInfo[i][oInt]);
							PlayerInfo[playerid][pUorg] = i;
							Freeze(playerid);
		            	}
		            	else { GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); }
					}
				}
			}
			else if(PlayerInfo[playerid][pUorg] != -1)
			{
				new i=PlayerInfo[playerid][pUorg];
				if(IsPlayerInRangeOfPoint(playerid,2.0,OrgInfo[i][oIzlazX],OrgInfo[i][oIzlazY],OrgInfo[i][oIzlazZ]))
 				{
        			SetPlayerPos(playerid,OrgInfo[i][oUlazX], OrgInfo[i][oUlazY], OrgInfo[i][oUlazZ]);
       	    		SetPlayerFacingAngle(playerid,OrgInfo[i][oUlazAZ]);
					SetPlayerVirtualWorld(playerid,0);
					SetPlayerInterior(playerid,0);
					PlayerInfo[playerid][pUorg] = -1;
					Freeze(playerid);
				}
			}
			
			if(PlayerInfo[playerid][pUstanu] == -1 && GetPlayerVirtualWorld(playerid) == 0)
		    {
				new id = GetStan(playerid);
				if(id != -1)
				{
					if(StanInfo[id][sLocked]) { GameTextForPlayer(playerid,"~r~Zakljucano",1000,3); }
					else
					{
						SetPlayerPos(playerid,StanInfo[id][sIzlazX], StanInfo[id][sIzlazY], StanInfo[id][sIzlazZ]);
						SetPlayerVirtualWorld(playerid,StanInfo[id][sVW]);
						SetPlayerInterior(playerid,StanInfo[id][sInterior]);
						PlayerInfo[playerid][pUstanu] = id;
						Freeze(playerid);
					}
				}
		    }
		    else if(PlayerInfo[playerid][pUstanu] != -1)
		    {
				new id = PlayerInfo[playerid][pUstanu];
				if(IsPlayerInRangeOfPoint(playerid,2.0,StanInfo[id][sIzlazX], StanInfo[id][sIzlazY], StanInfo[id][sIzlazZ]))
				{
					SetPlayerPos(playerid,StanInfo[id][sUlazX], StanInfo[id][sUlazY], StanInfo[id][sUlazZ]);
					SetPlayerVirtualWorld(playerid,0);
					SetPlayerInterior(playerid,0);
					PlayerInfo[playerid][pUstanu] = -1;
					Freeze(playerid);
				}
			}
		}
	}
	//--------------------------------------------------------------------------
	if(PRESSED(KEY_SUBMISSION))
	{
		if(IsPlayerInAnyVehicle(playerid))
        {
            if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER) return 1;
            if(Gorivo[GetPlayerVehicleID(playerid)] <= 0 && BenzinInfo[GetNumb(GetPlayerVehicleID(playerid))][bType] != NEMA) return GameTextForPlayer(playerid, "~r~Nemate goriva!", 1000, 1);
			new vIDD=GetPlayerVehicleID(playerid),tmp_engine,tmp_lights,tmp_alarm,tmp_doors,tmp_bonnet,tmp_boot,tmp_objective;
			GetVehicleParamsEx(vIDD,tmp_engine,tmp_lights,tmp_alarm,tmp_doors,tmp_bonnet,tmp_boot,tmp_objective);
			if(tmp_engine==1) { tmp_engine = 0; } else { tmp_engine = 1; }
			SetVehicleParamsEx(vIDD,tmp_engine,tmp_lights,tmp_alarm,tmp_doors,tmp_bonnet,tmp_boot,tmp_objective);
        }
	}
	//--------------------------------------------------------------------------
	if(PRESSED(KEY_NO))
	{
	    if(!IsPlayerInAnyVehicle(playerid))
        {
            for(new i=0;i<MAX_JOBS;i++)
            {
            	if(IsPlayerInRangeOfPoint(playerid,2.0,JobInfo[i][jX],JobInfo[i][jY],JobInfo[i][jZ]))
            	{
            	    new str[500];
            	    if(i != RUDAR)
            	    {
            	    	format(str,sizeof(str),""roza"[ %s ]\n"roza"Potreban level: "bijela"%d\n"roza"Placa: "bijela"%d$\n"roza"Ugovor: "bijela"%d staza\n\n"bijela"Jedan staz poen dobivate svaki puta kad zavrsite vas posao.\n"roza"Oni vam povecavaju placu.\n\n"bijela"Da prihvatite posao izaberite '"roza"Prihvati"bijela"'.",JobInfo[i][jName],JobInfo[i][jLevel],JobInfo[i][jPlaca],JobInfo[i][jUgovor]);
					}else{
					    format(str,sizeof(str),""roza"[ %s ]\n"roza"Potreban level: "bijela"%d\n"roza"Placa: "bijela"%dg\n"roza"Ugovor: "bijela"%d staza\n\n"bijela"Jedan staz poen dobivate svaki puta kad zavrsite vas posao.\n"roza"Oni vam povecavaju placu.\n\n"bijela"Da prihvatite posao izaberite '"roza"Prihvati"bijela"'.",JobInfo[i][jName],JobInfo[i][jLevel],JobInfo[i][jPlaca],JobInfo[i][jUgovor]);
					}
					PosaoID[playerid] = i;
					ShowPlayerDialog(playerid,DIALOG_POSAO,DIALOG_STYLE_MSGBOX,""roza""IME" - Posao:",str,"Prihvati","Odustani");
            	    break;
            	}
			}
		}
	}
	//--------------------------------------------------------------------------
	if(PRESSED(KEY_CROUCH))
	{
	    for(new i=0;i<MAX_ORGS;i++)
	    {
	        if(OrgInfo[i][oKapijaObj] != -1)
			{
		        if(IsPlayerInRangeOfPoint(playerid,10.0,OrgInfo[i][oKapijaX],OrgInfo[i][oKapijaY],OrgInfo[i][oKapijaZ]))
		        {
		            if(PlayerInfo[playerid][pOrgID] == i || AdminDuty[playerid])
		            {
		                if(KapijaState[i] == 0)
		                {
							MoveDynamicObject(KapijaObject[i],OrgInfo[i][oKapijaMoveX],OrgInfo[i][oKapijaMoveY],OrgInfo[i][oKapijaMoveZ],7);
							SetTimerEx("orgkapija",7000,false,"d",i);
							KapijaState[i] = 1;
						}
						else { ERROR(playerid,"Kapija je vec otvorena!"); }
					}
				}
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,3.0,244.14992, 72.48063, 1002.59729))
		{
		    if(PlayerInfo[playerid][pOrgID] == POLICIJA || AdminDuty[playerid])
			{
			    if(!pdvratastate)
			    {
			        MoveDynamicObject(pdvrata,244.14992, 72.48063, 1002.59729,7);
					SetTimer("pdvratat",4000,false);
					pdvratastate = true;
			    }
			    else { ERROR(playerid,"Vrata su vec otvorena!"); }
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,10.0,1539.96008, -1702.42566, 13.30480))
		{
		    if(PlayerInfo[playerid][pOrgID] == POLICIJA || AdminDuty[playerid])
			{
			    if(!rampastate)
			    {
			        DestroyDynamicObject(rampa);
			        rampa = CreateDynamicObject(968, 1539.96008, -1702.42566, 13.30480,   0.00000, -1.00000, 270.00000);
					SetTimer("rampat",7000,false);
					rampastate = true;
			    }
			    else { ERROR(playerid,"Rampa je vec otvorena!"); }
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,10.0,2731.35522, 2806.04370, 12.47020))
		{
		    if((PlayerInfo[playerid][pOrgID] != POLICIJA && PlayerInfo[playerid][pOrgID] != -1) || AdminDuty[playerid])
			{
			    if(!crnotrzistekapijastate)
			    {
			        MoveDynamicObject(crnotrzistekapija,2720.12305, 2806.28125, 12.47020,7);
					SetTimer("crnotrzistek",4000,false);
					crnotrzistekapijastate = true;
					if(!AdminDuty[playerid])
					{
						GivePlayerMoney(playerid,-20000);
						PlayerInfo[playerid][pMoney] -= 20000;
					}
				}
			    else { ERROR(playerid,"Kapija je vec otvorena!"); }
			}
		}
	}
	//--------------------------------------------------------------------------
	return 1;
}
//==============================================================================
public OnPlayerUpdate(playerid)
{
	if(FarmerState[playerid] == 2 && Radi[playerid])
	{
		for(new i=0;i<sizeof(FarmerPlayer[]);i++)
		{
		    new Float:x,Float:y,Float:z;
            GetPlayerObjectPos(playerid,FarmerPlayer[playerid][i],x,y,z);
			if(IsPlayerInRangeOfPoint(playerid,5.0,x,y,z) && FarmerPlayer[playerid][i] != INVALID_OBJECT_ID)
			{
		 		if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u kombajnu!");
			    new id = -1;
				for(new v=0;v<sizeof(FarmerVozilo);v++)
				{
				    if(GetPlayerVehicleID(playerid) == FarmerVozilo[v] && GetVehicleModel(GetPlayerVehicleID(playerid)) == 532)
				    {
				        id = v;
						break;
				    }
				}
				if(id == -1) return ERROR(playerid,"Niste u kombajnu!");
				DestroyPlayerObject(playerid,FarmerPlayer[playerid][i]);
				FarmerPlayer[playerid][i] = INVALID_OBJECT_ID;
				FarmerCP[playerid]++;
				new str[200];
				format(str,sizeof(str),"~p~%d/%d~n~~p~Nastavite dalje!",FarmerCP[playerid],sizeof(FarmerObjekti));
				GameTextForPlayer(playerid,str,3000,3);
				if(FarmerCP[playerid] >= sizeof(FarmerObjekti))
				{
				    SetVehicleToRespawn(GetPlayerVehicleID(playerid));
				    FarmerState[playerid] = 0;
					FarmerCP[playerid] = 0;
					Radi[playerid] = false;
		   			new placa = JobInfo[PlayerInfo[playerid][pPosao]][jPlaca]+PlayerInfo[playerid][pStaz]*100;
			  		PlayerInfo[playerid][pPlaca] += placa;
					format(str,sizeof(str),"Uspjesno ste zavrsili posao i dobili %d$! Vas bonus zbog staza je %d$. Ukupno %d$!",JobInfo[PlayerInfo[playerid][pPosao]][jPlaca],(PlayerInfo[playerid][pStaz]*100),placa);
			        JOB(playerid,str);
			        PlayerInfo[playerid][pStaz]++;
			        SacuvajIgraca(playerid);
			        for(new o=0;o<sizeof(FarmerObjekti);o++)
					{
						if(IsValidPlayerObject(playerid, FarmerPlayer[playerid][o])) { DestroyPlayerObject(playerid,FarmerPlayer[playerid][o]); }
						FarmerPlayer[playerid][o] = INVALID_OBJECT_ID;
					}
				}
			}
		}
	}
	return 1;
}
//==============================================================================
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == reg[11])
	{
        if(!ProvjeraRegistracije(playerid)) return ERROR(playerid,"Niste sve ispunili!");
        new str[200],dtxt[24],stxt[24];
       	if(PlayerInfo[playerid][pDrzava] == 0) { dtxt = "Hrvatska";
		}else if(PlayerInfo[playerid][pDrzava] == 1) { dtxt = "Srbija";
  		}else if(PlayerInfo[playerid][pDrzava] == 2) { dtxt = "BIH";
  		}else if(PlayerInfo[playerid][pDrzava] == 3) { dtxt = "Ostalo"; }
    	if(PlayerInfo[playerid][pSpol] == 1) { stxt = "Musko";
		}else if(PlayerInfo[playerid][pSpol] == 2) { stxt = "Zensko"; }
		format(str,sizeof(str),""bijela"Zahvaljujemo vam se na registraciji\n\n\n"plava"Vasi podatci:\n"plava"Godine: "bijela"%d\n"plava"Drzava: "bijela"%s\n"plava"Spol: "bijela"%s\n"plava"Mail: "bijela"%s",PlayerInfo[playerid][pGodine],dtxt,stxt,PlayerInfo[playerid][pMail]);
  		ShowPlayerDialog(playerid,DIALOG_PROVJERA,DIALOG_STYLE_MSGBOX,""plava""IME" - Registracija:",str,"Zavrsi","Promijeni");
	}
	else if(clickedid == reg[12])
	{
        for(new i=0;i<sizeof(reg);i++) { TextDrawHideForPlayer(playerid,reg[i]); }
		for(new i=0;i<sizeof(regp);i++) { PlayerTextDrawHide(playerid,regp[i][playerid]); }
		Kickaj(playerid,"Prekid registracije!");
	}
	else if(clickedid == reg[10])
	{
        RegistracijaInfo[playerid][pNumb]++;
	    if(RegistracijaInfo[playerid][pNumb] > 5) { PlayerPlaySound(playerid, 1137, 0.0, 0.0, 10.0); RegistracijaInfo[playerid][pNumb] = 5; }
		new skinid = 0;
		if(RegistracijaInfo[playerid][pNumb] == 0) { skinid = 23; }
		else if(RegistracijaInfo[playerid][pNumb] == 1) { skinid = 12; }
        else if(RegistracijaInfo[playerid][pNumb] == 2) { skinid = 26; }
        else if(RegistracijaInfo[playerid][pNumb] == 3) { skinid = 40; }
        else if(RegistracijaInfo[playerid][pNumb] == 4) { skinid = 46; }
        else if(RegistracijaInfo[playerid][pNumb] == 5) { skinid = 55; }
        else { skinid = 23; RegistracijaInfo[playerid][pNumb] = 0; }
		PlayerTextDrawHide(playerid,regp[5][playerid]);
	    PlayerTextDrawSetPreviewModel(playerid, regp[5][playerid], skinid);
        PlayerTextDrawShow(playerid,regp[5][playerid]);
	}
	else if(clickedid == reg[9])
	{
        RegistracijaInfo[playerid][pNumb]--;
	    if(RegistracijaInfo[playerid][pNumb] < 0) { PlayerPlaySound(playerid, 1137, 0.0, 0.0, 10.0); RegistracijaInfo[playerid][pNumb] = 0; }
	    new skinid = 0;
		if(RegistracijaInfo[playerid][pNumb] == 0) { skinid = 23; }
		else if(RegistracijaInfo[playerid][pNumb] == 1) { skinid = 12; }
        else if(RegistracijaInfo[playerid][pNumb] == 2) { skinid = 26; }
        else if(RegistracijaInfo[playerid][pNumb] == 3) { skinid = 40; }
        else if(RegistracijaInfo[playerid][pNumb] == 4) { skinid = 46; }
        else if(RegistracijaInfo[playerid][pNumb] == 5) { skinid = 55; }
        else { skinid = 23; RegistracijaInfo[playerid][pNumb] = 0; }
		PlayerTextDrawHide(playerid,regp[5][playerid]);
	    PlayerTextDrawSetPreviewModel(playerid, regp[5][playerid], skinid);
        PlayerTextDrawShow(playerid,regp[5][playerid]);
	}
	else if(clickedid == BankomatTD[2])
	{
	    new i = GetBankomatID(playerid);
    	if(i == -1) return ERROR(playerid,"Niste kod bankomata!");
	    if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate kraticu!");
	    new str[120];
  	 	format(str,sizeof(str),""zelena"Ime: "bijela"%s\n"zelena"Stanje na racunu: "bijela"%d$\n"zelena"Kredit za otplatiti: "bijela"%d$",GetName(playerid),PlayerInfo[playerid][pBankMoney],PlayerInfo[playerid][pKolicinaKredita]);
		ShowPlayerDialog(playerid,DIALOG_BANKA4,DIALOG_STYLE_MSGBOX,""zelena""IME" - Banka:",str,"Ok","");
	}
	else if(clickedid == BankomatTD[3])
	{
	    if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate karticu!");
  		ShowPlayerDialog(playerid,DIALOG_BANKA6,DIALOG_STYLE_INPUT,""zelena""IME" - Bankomat:",""bijela"Upisite koliko novca zelite podignuti","Podigni","Odustani");
	}
	else if(clickedid == BankomatTD[4])
	{
	    for(new i=0;i<sizeof(BankomatTD);i++) { TextDrawHideForPlayer(playerid, BankomatTD[i]); }
	    CancelSelectTextDraw(playerid);
	}
	else if(clickedid == katalog[12])
	{
	    katalogid[playerid]--;
	    if(katalogid[playerid] <= 0) { PlayerPlaySound(playerid, 1137, 0.0, 0.0, 10.0); katalogid[playerid] = 0; }
		PlayerTextDrawHide(playerid,katalogp[1][playerid]);
	    PlayerTextDrawSetPreviewModel(playerid, katalogp[1][playerid], KatalogInfo[katalogid[playerid]][kID]);
        PlayerTextDrawShow(playerid,katalogp[1][playerid]);
        new str[60];
        format(str,sizeof(str),"%d/%d",katalogid[playerid],MAX_KATALOG-1);
		PlayerTextDrawSetString(playerid,katalogp[3][playerid],str);
		format(str,sizeof(str),"%s",VehicleNames[KatalogInfo[katalogid[playerid]][kID] - 400]);
		PlayerTextDrawSetString(playerid,katalogp[0][playerid],str);
		format(str,sizeof(str),"Cijena: %d$",KatalogInfo[katalogid[playerid]][kPrice]);
		PlayerTextDrawSetString(playerid,katalogp[2][playerid],str);
	}
	else if(clickedid == katalog[11])
	{
	    katalogid[playerid]++;
	    if(katalogid[playerid] >= MAX_KATALOG) { PlayerPlaySound(playerid, 1137, 0.0, 0.0, 10.0); katalogid[playerid] = MAX_KATALOG-1; }
        PlayerTextDrawHide(playerid,katalogp[1][playerid]);
	    PlayerTextDrawSetPreviewModel(playerid, katalogp[1][playerid], KatalogInfo[katalogid[playerid]][kID]);
        PlayerTextDrawShow(playerid,katalogp[1][playerid]);
        new str[60];
        format(str,sizeof(str),"%d/%d",katalogid[playerid],MAX_KATALOG-1);
		PlayerTextDrawSetString(playerid,katalogp[3][playerid],str);
		format(str,sizeof(str),"%s",VehicleNames[KatalogInfo[katalogid[playerid]][kID] - 400]);
		PlayerTextDrawSetString(playerid,katalogp[0][playerid],str);
		format(str,sizeof(str),"Cijena: %d$",KatalogInfo[katalogid[playerid]][kPrice]);
		PlayerTextDrawSetString(playerid,katalogp[2][playerid],str);
	}
	else if(clickedid == katalog[13])
	{
	    if(PlayerInfo[playerid][pMoney] < KatalogInfo[katalogid[playerid]][kPrice] && PlayerInfo[playerid][pBankMoney] < KatalogInfo[katalogid[playerid]][kPrice]) return ERROR(playerid,"Nemate dovoljno novca!");
		ShowPlayerDialog(playerid,DIALOG_VKUPOVINA,DIALOG_STYLE_LIST,""plava""IME" - Placanje:",""bijela"Kartica\n"plava"Gotovina","Izaberi","Odustani");
        ktype[playerid] = 0;
	}
	else if(clickedid == katalog[14])
	{
 		for(new i=0;i<sizeof(katalog);i++) { TextDrawHideForPlayer(playerid,katalog[i]); }
	    for(new i=0;i<sizeof(katalogp);i++) { PlayerTextDrawHide(playerid,katalogp[i][playerid]); }
        CancelSelectTextDraw(playerid);
		katalogid[playerid] = 0;
	}
	return 1;
}
//==============================================================================
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(playertextid == regp[1][playerid])
	{
	    ShowPlayerDialog(playerid,DIALOG_MAIL,DIALOG_STYLE_INPUT,""plava""IME" - Registracija:",""bijela"Molimo vas upisite vas mail.","Dalje","Odustani");
	}
	else if(playertextid == regp[0][playerid])
	{
 		ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,""plava""IME" - Registracija:",""bijela"Molimo vas upisite zeljenu lozinku.","Regsitracija","Odustani");
	}
	else if(playertextid == regp[2][playerid])
	{
	    ShowPlayerDialog(playerid,DIALOG_GODINE,DIALOG_STYLE_INPUT,""plava""IME" - Registracija:",""bijela"Molimo vas upisite koliko imate godina.","Dalje","Odustani");
	}
	else if(playertextid == regp[3][playerid])
	{
	    ShowPlayerDialog(playerid,DIALOG_DRZAVA,DIALOG_STYLE_LIST,""plava""IME" - Registracija: "bijela"Izaberite vasu drzavu:",""bijela"Hrvatska\n"bijela"Srbija\n"bijela"BIH\n"bijela"Ostalo","Dalje","Odustani");
	}
	else if(playertextid == regp[4][playerid])
	{
	    ShowPlayerDialog(playerid,DIALOG_SPOL,DIALOG_STYLE_MSGBOX,""plava""IME" - Registracija:",""bijela"Izaberite vas spol:","Musko","Zensko");
	}
    return 1;
}
//==============================================================================
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(PlayerInfo[playerid][pAdmin] >= 6 && PlayerInfo[playerid][pUbizzu] == -1 && PlayerInfo[playerid][pUkuci] == -1 && PlayerInfo[playerid][pUorg] == -1 && PlayerInfo[playerid][pUstanu] == -1 && PlayerInfo[playerid][pMapTeleport])
	{
    	SetPlayerPosFindZ(playerid, fX, fY, fZ);
	}
	return 1;
}
//==============================================================================
public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success) return SCM(playerid, -1, ""plava"["TAG"] "zuta"Upisali ste pogresnu komandu! Za listu svih komanda upisite "bijela"'/help'");
 	return 1;
}
//==============================================================================
public OnPlayerEnterCheckpoint(playerid)
{
    //--------------------------------------------------------------------------
    if(GPSON[playerid])
	{
	    GPSON[playerid] = false;
	    DisablePlayerCheckpoint(playerid);
     	GameTextForPlayer(playerid,"~g~Stigli ste na odrediste!",3000,3);
	}
	//--------------------------------------------------------------------------
	switch(KamiondzijaCP[playerid])
	{
	    case 1:
	    {
	        if(utovar)
	        {
	            new id = -1;
				for(new i=0;i<sizeof(Kamion);i++)
				{
				    if(GetPlayerVehicleID(playerid) == Kamion[i])
				    {
				        id = i;
						break;
				    }
				}
				if(id == -1) { ERROR(playerid,"Niste u poslovnom kamionu!"); return 1; }
				if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) { ERROR(playerid,"Nemate prikolicu!"); return 1; }
				id = -1;
                for(new i=0;i<sizeof(Prikolica);i++)
				{
				    if(GetVehicleTrailer(GetPlayerVehicleID(playerid)) == Prikolica[i])
				    {
						id = i;
						break;
					}
				}
                if(id == -1) { ERROR(playerid,"Nemate prikladnu prikolicu!"); return 1; }
                utovar = false;
                DisablePlayerCheckpoint(playerid);
                GameTextForPlayer(playerid,"~p~Utovar...",7000,3);
                SetVehiclePos(GetPlayerVehicleID(playerid), 2657.2192,-2085.1406,14.5457);
                SetVehicleZAngle(GetPlayerVehicleID(playerid), 267.4234);
                SetVehiclePos(GetVehicleTrailer(GetPlayerVehicleID(playerid)),2647.3682,-2084.4531,14.5684);
                SetVehicleZAngle(GetVehicleTrailer(GetPlayerVehicleID(playerid)), 265.4544);
                /*AddStaticVehicle(515,2657.2192,-2085.1406,14.5457,267.4234,54,77); // kamion
				AddStaticVehicle(584,2647.3682,-2084.4531,14.5684,265.4544,1,1); // prikolica*/
	            SetTimerEx("kamiondzija1",7000,false,"d",playerid);
                TogglePlayerControllable(playerid,0);
	        }
	    }
	    case 2:
	    {
	        new id = -1;
			for(new i=0;i<sizeof(Kamion);i++)
			{
			    if(GetPlayerVehicleID(playerid) == Kamion[i])
			    {
			        id = i;
					break;
			    }
			}
			if(id == -1) { ERROR(playerid,"Niste u poslovnom kamionu!"); return 1; }
			if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) { ERROR(playerid,"Nemate prikolicu!"); return 1; }
   			if(GetVehicleTrailer(GetPlayerVehicleID(playerid)) != KamiondzijaPrikolica[playerid]) { ERROR(playerid,"Nemate prikolicu u koju ste utovarili teret!"); return 1; }
   			DisablePlayerCheckpoint(playerid);
   			TogglePlayerControllable(playerid,0);
   			SetTimerEx("kamiondzija2",7000,false,"d",playerid);
   			GameTextForPlayer(playerid,"~p~Istovar...",7000,3);
	    }
	    case 3:
	    {
            new id = -1;
			for(new i=0;i<sizeof(Kamion);i++)
			{
			    if(GetPlayerVehicleID(playerid) == Kamion[i])
			    {
			        id = i;
					break;
			    }
			}
			if(id == -1) { ERROR(playerid,"Niste u poslovnom kamionu!"); return 1; }
			if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) { ERROR(playerid,"Nemate prikolicu!"); return 1; }
   			if(GetVehicleTrailer(GetPlayerVehicleID(playerid)) != KamiondzijaPrikolica[playerid]) { ERROR(playerid,"Nemate vasu prikolicu!"); return 1; }
   			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
   			SetVehicleToRespawn(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
   			KamiondzijaCP[playerid] = 0;
   			KamiondzijaPrikolica[playerid] = 0;
   			Radi[playerid] = false;
   			new placa = JobInfo[PlayerInfo[playerid][pPosao]][jPlaca]+PlayerInfo[playerid][pStaz]*100;
	  		PlayerInfo[playerid][pPlaca] += placa;
	        DisablePlayerCheckpoint(playerid);
			new str[200];
			format(str,sizeof(str),"Uspjesno ste zavrsili isporuku i dobili %d$! Vas bonus zbog staza je %d$. Ukupno %d$!",JobInfo[PlayerInfo[playerid][pPosao]][jPlaca],(PlayerInfo[playerid][pStaz]*100),placa);
	        JOB(playerid,str);
	        PlayerInfo[playerid][pStaz]++;
	    	SacuvajIgraca(playerid);
	    }
	}
	//--------------------------------------------------------------------------
	if(Radi[playerid] && FarmerCP[playerid] != -1)
	{
	    if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u traktoru!");
	    new id = -1;
		for(new i=0;i<sizeof(FarmerVozilo);i++)
		{
		    if(GetPlayerVehicleID(playerid) == FarmerVozilo[i] && GetVehicleModel(GetPlayerVehicleID(playerid)) == 531)
		    {
		        id = i;
				break;
		    }
		}
		if(id == -1) return ERROR(playerid,"Niste u traktoru!");
		if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return ERROR(playerid,"Nemate prikolicu!");
		id = -1;
		for(new i=0;i<sizeof(FarmerPrikolica);i++)
		{
			if(FarmerPrikolica[i] == GetVehicleTrailer(GetPlayerVehicleID(playerid)))
			{
			    id = 1;
			    break;
			}
		}
		if(id == -1) return ERROR(playerid,"Nemate prikladnu prikolicu!");
		DisablePlayerCheckpoint(playerid);
		FarmerPlayer[playerid][FarmerCP[playerid]] = CreatePlayerObject(playerid,FARMER_OBJEKT,FarmerObjekti[FarmerCP[playerid]][0],FarmerObjekti[FarmerCP[playerid]][1],FarmerObjekti[FarmerCP[playerid]][2],FarmerObjekti[FarmerCP[playerid]][3],FarmerObjekti[FarmerCP[playerid]][4],FarmerObjekti[FarmerCP[playerid]][5]);
		FarmerCP[playerid]++;
		if(FarmerCP[playerid] >= sizeof(FarmerObjekti))
		{
			GameTextForPlayer(playerid,"~p~Sad idite u kombajn i obavite zetvu~n~~p~svega sto ste posijali!",10000,3);
			SetVehicleToRespawn(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
			SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			FarmerState[playerid] = 2;
			FarmerCP[playerid] = 0;
		}
		else
		{
			new str[50];
			format(str,sizeof(str),"~p~%d/%d~n~~p~Nastavite dalje!",FarmerCP[playerid],sizeof(FarmerObjekti));
			GameTextForPlayer(playerid,str,3000,3);
        	SetPlayerCheckpoint(playerid,FarmerObjekti[FarmerCP[playerid]][0],FarmerObjekti[FarmerCP[playerid]][1],FarmerObjekti[FarmerCP[playerid]][2],2.0);
		}
	}
	//--------------------------------------------------------------------------
	switch(GradevinarCP[playerid])
	{
	    case 1:
	    {
	        new id = -1;
			for(new i=0;i<sizeof(GradevinarVozilo);i++)
			{
			    if(GetPlayerVehicleID(playerid) == GradevinarVozilo[i])
			    {
			        id = i;
					break;
			    }
			}
			if(id == -1) { ERROR(playerid,"Niste u poslovnom kamionu!"); return 1; }
            DisablePlayerCheckpoint(playerid);
            GameTextForPlayer(playerid,"~p~Utovar...",7000,3);
            SetTimerEx("gradevinar",7000,false,"d",playerid);
            TogglePlayerControllable(playerid,0);
		}
		case 2:
	    {
	        if(gradevinarutovar[0]) return 1;
	        new id = -1;
			for(new i=0;i<sizeof(GradevinarVozilo);i++)
			{
			    if(GetPlayerVehicleID(playerid) == GradevinarVozilo[i])
			    {
			        id = i;
					break;
			    }
			}
			if(id == -1) { ERROR(playerid,"Niste u poslovnom kamionu!"); return 1; }
            DisablePlayerCheckpoint(playerid);
            gradevinarutovar[0] = true;
            GameTextForPlayer(playerid,"~p~Istovar...",7000,3);
            SetTimerEx("gradevinar1",7000,false,"d",playerid);
            TogglePlayerControllable(playerid,0);
            SetVehiclePos(GetPlayerVehicleID(playerid), 1274.2433,-1333.3479,14.1403);
            SetVehicleZAngle(GetPlayerVehicleID(playerid), 181.4292);
            gradevinarobject[playerid] = CreateObject( 18672,0,0,0,0,0,0,80 );
			AttachObjectToVehicle( gradevinarobject[playerid], GetPlayerVehicleID(playerid), 2.400000, -3.899998, -1.400000, 32.000000, 0.000000, 271.000000 );
		}
		case 3:
	    {
	        if(gradevinarutovar[1]) return 1;
	        new id = -1;
			for(new i=0;i<sizeof(GradevinarVozilo);i++)
			{
			    if(GetPlayerVehicleID(playerid) == GradevinarVozilo[i])
			    {
			        id = i;
					break;
			    }
			}
			if(id == -1) { ERROR(playerid,"Niste u poslovnom kamionu!"); return 1; }
            DisablePlayerCheckpoint(playerid);
            gradevinarutovar[1] = true;
            GameTextForPlayer(playerid,"~p~Istovar...",7000,3);
            SetTimerEx("gradevinar2",7000,false,"d",playerid);
            TogglePlayerControllable(playerid,0);
            SetVehiclePos(GetPlayerVehicleID(playerid), 1284.1842,-1333.2246,14.1385);
            SetVehicleZAngle(GetPlayerVehicleID(playerid),181.7194);
            gradevinarobject[playerid] = CreateObject( 18672,0,0,0,0,0,0,80 );
			AttachObjectToVehicle( gradevinarobject[playerid], GetPlayerVehicleID(playerid), 2.400000, -3.899998, -1.400000, 32.000000, 0.000000, 271.000000 );
		}
		case 4:
	    {
	        if(gradevinarutovar[2]) return 1;
	        new id = -1;
			for(new i=0;i<sizeof(GradevinarVozilo);i++)
			{
			    if(GetPlayerVehicleID(playerid) == GradevinarVozilo[i])
			    {
			        id = i;
					break;
			    }
			}
			if(id == -1) { ERROR(playerid,"Niste u poslovnom kamionu!"); return 1; }
            DisablePlayerCheckpoint(playerid);
            gradevinarutovar[2] = true;
            GameTextForPlayer(playerid,"~p~Istovar...",7000,3);
            SetTimerEx("gradevinar3",7000,false,"d",playerid);
            TogglePlayerControllable(playerid,0);
            SetVehiclePos(GetPlayerVehicleID(playerid), 1293.2577,-1333.2360,14.1349);
            SetVehicleZAngle(GetPlayerVehicleID(playerid),179.3306);
            gradevinarobject[playerid] = CreateObject( 18672,0,0,0,0,0,0,80 );
			AttachObjectToVehicle( gradevinarobject[playerid], GetPlayerVehicleID(playerid), 2.400000, -3.899998, -1.400000, 32.000000, 0.000000, 271.000000 );
		}
	}
	//--------------------------------------------------------------------------
	switch(RudarCP[playerid])
	{
	    case 1:
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerAttachedObject( playerid, RUDAR_SLOT, 337, 6, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        GameTextForPlayer(playerid,"~p~Kopanje.",999,3);
	        TogglePlayerControllable(playerid,0);
	        RudarTimer[playerid] = SetTimerEx("kopanje",1000,true,"d",playerid);
	        SetPlayerFacingAngle(playerid,199.0426);
	        ApplyAnimation(playerid, "Flowers", "Flower_attack", 4.1, 0, 0, 1, 1, 999, 1);
	    }
	    case 2:
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerAttachedObject( playerid, RUDAR_SLOT, 337, 6, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        GameTextForPlayer(playerid,"~p~Kopanje.",999,3);
	        TogglePlayerControllable(playerid,0);
	        RudarTimer[playerid] = SetTimerEx("kopanje",1000,true,"d",playerid);
	        SetPlayerFacingAngle(playerid,190.2692);
	        ApplyAnimation(playerid, "Flowers", "Flower_attack", 4.1, 0, 0, 1, 1, 999, 1);
	    }
	    case 3:
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerAttachedObject( playerid, RUDAR_SLOT, 337, 6, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        GameTextForPlayer(playerid,"~p~Kopanje.",999,3);
	        TogglePlayerControllable(playerid,0);
	        RudarTimer[playerid] = SetTimerEx("kopanje",1000,true,"d",playerid);
	        SetPlayerFacingAngle(playerid,186.8225);
	        ApplyAnimation(playerid, "Flowers", "Flower_attack", 4.1, 0, 0, 1, 1, 999, 1);
	    }
	    case 4:
	    {
	        DisablePlayerCheckpoint(playerid);
	        SetPlayerAttachedObject( playerid, RUDAR_SLOT, 337, 6, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        GameTextForPlayer(playerid,"~p~Kopanje.",999,3);
	        TogglePlayerControllable(playerid,0);
	        RudarTimer[playerid] = SetTimerEx("kopanje",1000,true,"d",playerid);
	        SetPlayerFacingAngle(playerid,203.7426);
	        ApplyAnimation(playerid, "Flowers", "Flower_attack", 4.1, 0, 0, 1, 1, 999, 1);
	    }
	    case 5:
	    {
	        DisablePlayerCheckpoint(playerid);
	        GameTextForPlayer(playerid,"~p~Idite pokupiti zlato!",3000,3);
            SetPlayerCheckpoint(playerid,617.2206,891.3222,-42.8480,3.0);
            RudarCP[playerid]++;
	    }
	    case 6:
	    {
	        DisablePlayerCheckpoint(playerid);
  			RudarCP[playerid] = 0;
   			Kopanje[playerid] = 0;
   			Radi[playerid] = false;
   			new placa = JobInfo[PlayerInfo[playerid][pPosao]][jPlaca]+PlayerInfo[playerid][pStaz]*10;
	  		PlayerInfo[playerid][pZlato] += placa;
            UpdateBankaZlatoTD(playerid);
	        DisablePlayerCheckpoint(playerid);
			new str[200];
			format(str,sizeof(str),"Uspjesno ste zavrsili kopanje i dobili %dg zlata! Vas bonus zbog staza je %dg. Ukupno %dg!",JobInfo[PlayerInfo[playerid][pPosao]][jPlaca],(PlayerInfo[playerid][pStaz]*10),placa);
	        JOB(playerid,str);
	        PlayerInfo[playerid][pStaz]++;
	    	SacuvajIgraca(playerid);
	    }
	}
	//--------------------------------------------------------------------------
	switch(polaganje[playerid])
	{
	    case 0:
	    {
	        if(GetPlayerVehicleID(playerid) == PolaganjeVehicle[playerid])
	        {
	        	DisablePlayerCheckpoint(playerid);
	        	SetPlayerCheckpoint(playerid,2041.4718,-1879.1968,13.2733,4.0);
	        	GameTextForPlayer(playerid,"~g~Nastavite dalje!",3500,3);
	        	polaganje[playerid]++;
	        	new Float:health;
			    GetVehicleHealth(GetPlayerVehicleID(playerid), health);
	        	if(health < 900.0)
	        	{
	        		AUTOSKOLA(playerid,"Previse ste ostetili vozilo i pali na polaganju!");
	        		SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
			        SetPlayerFacingAngle(playerid,9.0473);
					SetPlayerVirtualWorld(playerid,10);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
	        		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
					{
						DestroyVehicle(PolaganjeVehicle[playerid]);
						PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
					}
					polaganje[playerid] = -1;
					PolaganjeVrsta[playerid] = -1;
	        	}
			}
			else { ERROR(playerid,"Niste u vozilu autoskole!"); }
		}
		case 1:
	    {
	        if(GetPlayerVehicleID(playerid) == PolaganjeVehicle[playerid])
	        {
	        	DisablePlayerCheckpoint(playerid);
	        	SetPlayerCheckpoint(playerid,2047.6144,-1894.3834,13.2729,4.0);
	        	GameTextForPlayer(playerid,"~g~Parkirajte vozilo!",3500,3);
	        	polaganje[playerid]++;
	        	new Float:health;
			    GetVehicleHealth(GetPlayerVehicleID(playerid), health);
	        	if(health < 900.0)
	        	{
	        		AUTOSKOLA(playerid,"Previse ste ostetili vozilo i pali na polaganju!");
	        		SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
			        SetPlayerFacingAngle(playerid,9.0473);
					SetPlayerVirtualWorld(playerid,10);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
	        		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
					{
						DestroyVehicle(PolaganjeVehicle[playerid]);
						PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
					}
					polaganje[playerid] = -1;
					PolaganjeVrsta[playerid] = -1;
	        	}
			}
			else { ERROR(playerid,"Niste u vozilu autoskole!"); }
		}
		case 2:
	    {
	        if(GetPlayerVehicleID(playerid) == PolaganjeVehicle[playerid])
	        {
	        	DisablePlayerCheckpoint(playerid);
	        	SetPlayerCheckpoint(playerid,2040.8157,-1900.0419,13.2733,4.0);
	        	GameTextForPlayer(playerid,"~g~Idite do mjesta oznacenog na karti!",3500,3);
	        	polaganje[playerid]++;
	        	new Float:health;
			    GetVehicleHealth(GetPlayerVehicleID(playerid), health);
	        	if(health < 900.0)
	        	{
	        		AUTOSKOLA(playerid,"Previse ste ostetili vozilo i pali na polaganju!");
	        		SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
			        SetPlayerFacingAngle(playerid,9.0473);
					SetPlayerVirtualWorld(playerid,10);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
	        		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
					{
						DestroyVehicle(PolaganjeVehicle[playerid]);
						PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
					}
					polaganje[playerid] = -1;
					PolaganjeVrsta[playerid] = -1;
	        	}
			}
			else { ERROR(playerid,"Niste u vozilu autoskole!"); }
		}
		case 3:
	    {
	        if(GetPlayerVehicleID(playerid) == PolaganjeVehicle[playerid])
	        {
	        	DisablePlayerCheckpoint(playerid);
	        	SetPlayerCheckpoint(playerid,2047.1844,-1906.0662,13.2729,4.0);
	        	GameTextForPlayer(playerid,"~g~Parkirajte vozilo!",3500,3);
	        	polaganje[playerid]++;
	        	new Float:health;
			    GetVehicleHealth(GetPlayerVehicleID(playerid), health);
	        	if(health < 900.0)
	        	{
	        		AUTOSKOLA(playerid,"Previse ste ostetili vozilo i pali na polaganju!");
	        		SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
			        SetPlayerFacingAngle(playerid,9.0473);
					SetPlayerVirtualWorld(playerid,10);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
	        		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
					{
						DestroyVehicle(PolaganjeVehicle[playerid]);
						PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
					}
					polaganje[playerid] = -1;
					PolaganjeVrsta[playerid] = -1;
	        	}
			}
			else { ERROR(playerid,"Niste u vozilu autoskole!"); }
		}
		case 4:
	    {
	        if(GetPlayerVehicleID(playerid) == PolaganjeVehicle[playerid])
	        {
	        	DisablePlayerCheckpoint(playerid);
	        	SetPlayerCheckpoint(playerid,2063.8765,-1914.5068,13.2719,4.0);
	        	GameTextForPlayer(playerid,"~g~Idite do mjesta oznacenog na karti!",3500,3);
	        	polaganje[playerid]++;
	        	new Float:health;
			    GetVehicleHealth(GetPlayerVehicleID(playerid), health);
	        	if(health < 900.0)
	        	{
	        		AUTOSKOLA(playerid,"Previse ste ostetili vozilo i pali na polaganju!");
	        		SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
			        SetPlayerFacingAngle(playerid,9.0473);
					SetPlayerVirtualWorld(playerid,10);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
	        		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
					{
						DestroyVehicle(PolaganjeVehicle[playerid]);
						PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
					}
					polaganje[playerid] = -1;
					PolaganjeVrsta[playerid] = -1;
	        	}
			}
			else { ERROR(playerid,"Niste u vozilu autoskole!"); }
		}
		case 5:
	    {
	        if(GetPlayerVehicleID(playerid) == PolaganjeVehicle[playerid])
	        {
	        	DisablePlayerCheckpoint(playerid);
	        	SetPlayerCheckpoint(playerid,2023.4749,-1930.1554,13.0463,4.0);
	        	GameTextForPlayer(playerid,"~g~Sada slijedi gradska voznja!",3500,3);
	        	polaganje[playerid]++;
	        	new Float:health;
			    GetVehicleHealth(GetPlayerVehicleID(playerid), health);
	        	if(health < 900.0)
	        	{
	        		AUTOSKOLA(playerid,"Previse ste ostetili vozilo i pali na polaganju!");
	        		SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
			        SetPlayerFacingAngle(playerid,9.0473);
					SetPlayerVirtualWorld(playerid,10);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
	        		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
					{
						DestroyVehicle(PolaganjeVehicle[playerid]);
						PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
					}
					polaganje[playerid] = -1;
					PolaganjeVrsta[playerid] = -1;
	        	}
			}
			else { ERROR(playerid,"Niste u vozilu autoskole!"); }
		}
		case 6:
	    {
	        if(GetPlayerVehicleID(playerid) == PolaganjeVehicle[playerid])
	        {
	        	DisablePlayerCheckpoint(playerid);
	        	SetPlayerCheckpoint(playerid,1823.8907,-1912.5997,13.0848,4.0);
	        	GameTextForPlayer(playerid,"~g~Idite do mjesta oznacenog na karti!",3500,3);
	        	polaganje[playerid]++;
	        	new Float:health;
			    GetVehicleHealth(GetPlayerVehicleID(playerid), health);
	        	if(health < 900.0)
	        	{
	        		AUTOSKOLA(playerid,"Previse ste ostetili vozilo i pali na polaganju!");
	        		SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
			        SetPlayerFacingAngle(playerid,9.0473);
					SetPlayerVirtualWorld(playerid,10);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
	        		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
					{
						DestroyVehicle(PolaganjeVehicle[playerid]);
						PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
					}
					polaganje[playerid] = -1;
					PolaganjeVrsta[playerid] = -1;
	        	}
			}
			else { ERROR(playerid,"Niste u vozilu autoskole!"); }
		}
		case 7:
	    {
	        if(GetPlayerVehicleID(playerid) == PolaganjeVehicle[playerid])
	        {
	        	DisablePlayerCheckpoint(playerid);
	        	SetPlayerCheckpoint(playerid,1978.9188,-1754.6317,13.0873,4.0);
	        	GameTextForPlayer(playerid,"~g~Idite do mjesta oznacenog na karti!",3500,3);
	        	polaganje[playerid]++;
	        	new Float:health;
			    GetVehicleHealth(GetPlayerVehicleID(playerid), health);
	        	if(health < 900.0)
	        	{
	        		AUTOSKOLA(playerid,"Previse ste ostetili vozilo i pali na polaganju!");
	        		SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
			        SetPlayerFacingAngle(playerid,9.0473);
					SetPlayerVirtualWorld(playerid,10);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
	        		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
					{
						DestroyVehicle(PolaganjeVehicle[playerid]);
						PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
					}
					polaganje[playerid] = -1;
					PolaganjeVrsta[playerid] = -1;
	        	}
			}
			else { ERROR(playerid,"Niste u vozilu autoskole!"); }
		}
		case 8:
	    {
	        if(GetPlayerVehicleID(playerid) == PolaganjeVehicle[playerid])
	        {
	        	DisablePlayerCheckpoint(playerid);
	        	SetPlayerCheckpoint(playerid,2113.6277,-1761.3750,13.1025,4.0);
	        	GameTextForPlayer(playerid,"~g~Idite do mjesta oznacenog na karti!",3500,3);
	        	polaganje[playerid]++;
	        	new Float:health;
			    GetVehicleHealth(GetPlayerVehicleID(playerid), health);
	        	if(health < 900.0)
	        	{
	        		AUTOSKOLA(playerid,"Previse ste ostetili vozilo i pali na polaganju!");
	        		SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
			        SetPlayerFacingAngle(playerid,9.0473);
					SetPlayerVirtualWorld(playerid,10);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
	        		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
					{
						DestroyVehicle(PolaganjeVehicle[playerid]);
						PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
					}
					polaganje[playerid] = -1;
					PolaganjeVrsta[playerid] = -1;
	        	}
			}
			else { ERROR(playerid,"Niste u vozilu autoskole!"); }
		}
		case 9:
	    {
	        if(GetPlayerVehicleID(playerid) == PolaganjeVehicle[playerid])
	        {
	        	DisablePlayerCheckpoint(playerid);
	        	SetPlayerCheckpoint(playerid,2122.4514,-1783.7649,13.0923,4.0);
	        	GameTextForPlayer(playerid,"~g~Parkirajte!",3500,3);
	        	polaganje[playerid]++;
	        	new Float:health;
			    GetVehicleHealth(GetPlayerVehicleID(playerid), health);
	        	if(health < 900.0)
	        	{
	        		AUTOSKOLA(playerid,"Previse ste ostetili vozilo i pali na polaganju!");
	        		SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
			        SetPlayerFacingAngle(playerid,9.0473);
					SetPlayerVirtualWorld(playerid,10);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
	        		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
					{
						DestroyVehicle(PolaganjeVehicle[playerid]);
						PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
					}
					polaganje[playerid] = -1;
					PolaganjeVrsta[playerid] = -1;
	        	}
			}
			else { ERROR(playerid,"Niste u vozilu autoskole!"); }
		}
		case 10:
	    {
	        if(GetPlayerVehicleID(playerid) == PolaganjeVehicle[playerid])
	        {
	        	DisablePlayerCheckpoint(playerid);
	        	SetPlayerCheckpoint(playerid,2068.1626,-1911.8616,13.2734,4.0);
	        	GameTextForPlayer(playerid,"~g~Idite do mjesta oznacenog na karti!",3500,3);
	        	polaganje[playerid]++;
	        	new Float:health;
			    GetVehicleHealth(GetPlayerVehicleID(playerid), health);
	        	if(health < 900.0)
	        	{
	        		AUTOSKOLA(playerid,"Previse ste ostetili vozilo i pali na polaganju!");
	        		SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
			        SetPlayerFacingAngle(playerid,9.0473);
					SetPlayerVirtualWorld(playerid,10);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
	        		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
					{
						DestroyVehicle(PolaganjeVehicle[playerid]);
						PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
					}
					polaganje[playerid] = -1;
					PolaganjeVrsta[playerid] = -1;
	        	}
			}
			else { ERROR(playerid,"Niste u vozilu autoskole!"); }
		}
		case 11:
	    {
	        if(GetPlayerVehicleID(playerid) == PolaganjeVehicle[playerid])
	        {
	        	DisablePlayerCheckpoint(playerid);
	        	new Float:health;
			    GetVehicleHealth(GetPlayerVehicleID(playerid), health);
	        	if(health < 900.0)
	        	{
	        		AUTOSKOLA(playerid,"Previse ste ostetili vozilo i pali na polaganju!");
	        		SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
			        SetPlayerFacingAngle(playerid,9.0473);
					SetPlayerVirtualWorld(playerid,10);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
	        		if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
					{
						DestroyVehicle(PolaganjeVehicle[playerid]);
						PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
					}
					polaganje[playerid] = -1;
					PolaganjeVrsta[playerid] = -1;
	        	}
	        	else
	        	{
	        	    GameTextForPlayer(playerid,"~g~Uspjesno ste polozili!",3500,3);
	        	    if(PolaganjeVrsta[playerid] == 0)
	        	    {
	        	        AUTOSKOLA(playerid,"Uspjesno ste polozili i dobili vozacku dozvolu!");
	        	        PlayerInfo[playerid][pVozackaDozvola] = true;
						SacuvajIgraca(playerid);
	        	    }
	        	    else if(PolaganjeVrsta[playerid] == 1)
	        	    {
	        	        AUTOSKOLA(playerid,"Uspjesno ste polozili i dobili dozvolu za motor!");
	        	        PlayerInfo[playerid][pMotorDozvola] = true;
						SacuvajIgraca(playerid);
	        	    }
	        	    else if(PolaganjeVrsta[playerid] == 2)
	        	    {
	        	        AUTOSKOLA(playerid,"Uspjesno ste polozili i dobili dozvolu za kamion!");
	        	        PlayerInfo[playerid][pKamionDozvola] = true;
						SacuvajIgraca(playerid);
	        	    }
	        	    SetPlayerPos(playerid,-2029.7234,-119.4169,1035.1719);
			        SetPlayerFacingAngle(playerid,9.0473);
					SetPlayerVirtualWorld(playerid,10);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
					if(PolaganjeVehicle[playerid] != INVALID_VEHICLE_ID)
					{
						DestroyVehicle(PolaganjeVehicle[playerid]);
						PolaganjeVehicle[playerid] = INVALID_VEHICLE_ID;
					}
	        	    polaganje[playerid] = -1;
					PolaganjeVrsta[playerid] = -1;
	        	}
			}
			else { ERROR(playerid,"Niste u vozilu autoskole!"); }
		}
	}
	//--------------------------------------------------------------------------
	return 1;
}
//==============================================================================
public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(EditujeBankomat[playerid] != -1)
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
		    new id = EditujeBankomat[playerid], str[100];
			if(id != -1)
			{
				BankomatInfo[id][bX] = x;
				BankomatInfo[id][bY] = y;
				BankomatInfo[id][bZ] = z;
				BankomatInfo[id][bXX] = rx;
				BankomatInfo[id][bYY] = ry;
				BankomatInfo[id][bZZ] = rz;
				DestroyDynamicObject(BankomatInfo[id][bObjekt]);
				KreirajBankomat(id);
				SacuvajBankomat(id);
				format(str,sizeof(str),"Bankomat id %d je uspjesno editovan!",id);
				INFO(playerid,str);
				SCM(playerid,-1,str);
				EditujeBankomat[playerid] = -1;
			}
		}
	}
	return 1;
}
//==============================================================================
public OnVehicleSpawn(vehicleid)
{
	for(new i;i<MAX_VOZILA;i++)
	{
 		if(VoziloInfo[i][vID] == vehicleid)
   		{
   		    if(VoziloInfo[i][vOwned])
   		    {
   		    	Delete3DTextLabel(vehtxt[VoziloInfo[i][vID]]);
			}
			ModVehicle(vehicleid);
			ChangeVehicleColor(vehicleid, VoziloInfo[i][vBoja1], VoziloInfo[i][vBoja2]);
			if(VoziloInfo[i][vPaintJob] != -1)
            {
				ChangeVehiclePaintjob(vehicleid, VoziloInfo[i][vPaintJob]);
			}
		}
	}
	return 1;
}
//==============================================================================
public OnVehicleMod(playerid, vehicleid, componentid)
{
	for(new i=0;i<MAX_VOZILA;i++)
	{
	    if(VoziloInfo[i][vID] == vehicleid)
	    {
	        SaveComponent(vehicleid, componentid);
 		}
	}
	return 1;
}
//==============================================================================
public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	for(new i=0;i<MAX_VOZILA;i++)
	{
	    if(VoziloInfo[i][vID] == vehicleid)
	    {
	        VoziloInfo[i][vPaintJob] = paintjobid;
	        SacuvajVozilo(i);
 		}
	}
	return 1;
}
//==============================================================================
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	for(new i=0;i<MAX_VOZILA;i++)
	{
	    if(VoziloInfo[i][vID] == vehicleid)
	    {
	        VoziloInfo[i][vBoja1] = color1;
	        VoziloInfo[i][vBoja2] = color2;
	        SacuvajVozilo(i);
 		}
	}
	return 1;
}
//==============================================================================
public OnEnterExitModShop(playerid, enterexit, interiorid)
{
    if(enterexit == 0)
    {
        GivePlayerMoney(playerid, -5000);
        PlayerInfo[playerid][pMoney] -= 5000;
    }
    return 1;
}
//==============================================================================
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(source == 0 && PlayerInfo[playerid][pAdmin] >= 4)
	{
		ShowStats(playerid,clickedplayerid);
	}
	return 1;
}
//==============================================================================
public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
	if(weaponid == 23 && Tazer[playerid] && PlayerInfo[playerid][pOrgID] == POLICIJA)
	{
	    new Float:health;
	    GetPlayerHealth(damagedid,health);
	    if(health+amount >= 100.0) { SetPlayerHealth(damagedid,99.0); }
	    else { SetPlayerHealth(damagedid,health+amount); }
	    Tazed[damagedid] = true;
	    ClearAnimations(damagedid);
		ApplyAnimation(damagedid,"PED","KO_skid_front",4.1,0,1,1,1,0);
		TogglePlayerControllable(damagedid,0);
		SetTimerEx("untazed",10000,false,"d",damagedid);
	}
    return 1;
}
//==============================================================================
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == BULLET_HIT_TYPE_OBJECT)
	{
	    if(hitid == masina[0] || hitid == masina[1] || hitid == masina[2] || hitid == masina[3])
		{
		    if(!bankavratastate)
			{
				MoveDynamicObject(bankavrata,659.18378, 412.19119, 651.57263, 10.0,  0.00000, 0.00000, 150.50317);
				bankavratastate = true;
			}
			if(hitid == masina[0] && !iskrestate[0]) { iskre[0] = CreateDynamicObject(18717, 643.866333, 405.646179, 650.282653-2, 0.000000, 0.000000, 0.000000); iskrestate[0] = true; }
			if(hitid == masina[1] && !iskrestate[1]) { iskre[1] = CreateDynamicObject(18717, 643.866333, 405.646179, 651.032470-2, 0.000000, 0.000000, 0.000000); iskrestate[1] = true; }
			if(hitid == masina[2] && !iskrestate[2]) { iskre[2] = CreateDynamicObject(18717, 643.866333, 406.716217, 651.032470-2, 0.000000, 0.000000, 0.000000); iskrestate[2] = true; }
			if(hitid == masina[3] && !iskrestate[3]) { iskre[3] = CreateDynamicObject(18717, 643.866333, 406.716217, 650.342285-2, 0.000000, 0.000000, 0.000000); iskrestate[3] = true; }
		}
	}
	else if(hittype == BULLET_HIT_TYPE_PLAYER_OBJECT)
	{
	    if(hitid == streljanaobject[playerid])
	    {
			if(Trenira[playerid] == -1)
			{
			    DestroyPlayerObject(playerid,streljanaobject[playerid]);
			    streljanaobject[playerid] = INVALID_OBJECT_ID;
			    Trenira[playerid] = -1;
          		TreniraState[playerid] = -1;
          		new id = PlayerInfo[playerid][pUbizzu];
                SetPlayerPos(playerid,BiznisInfo[id][bIzlazX], BiznisInfo[id][bIzlazY], BiznisInfo[id][bIzlazZ]);
				SetPlayerVirtualWorld(playerid,BiznisInfo[id][bVW]);
				SetPlayerInterior(playerid,BiznisInfo[id][bInterior]);
				Freeze(playerid);
				PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
			}
			else if(Trenira[playerid] == 0)
			{
			    Trenira[playerid]++;
			    DestroyPlayerObject(playerid,streljanaobject[playerid]);
			    streljanaobject[playerid] = CreatePlayerObject(playerid,1486, 708.41986, 145.95079, -3.63650,   0.00000, 0.00000, 0.00000);
			    GameTextForPlayer(playerid,"~g~Nastavite dalje!",3000,3);
			    PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
			}
			else if(Trenira[playerid] == 1)
			{
			    Trenira[playerid]++;
			    DestroyPlayerObject(playerid,streljanaobject[playerid]);
			    streljanaobject[playerid] = CreatePlayerObject(playerid,1486, 709.85059, 145.24200, -3.63650,   0.00000, 0.00000, 0.00000);
			    GameTextForPlayer(playerid,"~g~Nastavite dalje!",3000,3);
			    PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
			}
			else if(Trenira[playerid] == 2)
			{
			    Trenira[playerid]++;
			    DestroyPlayerObject(playerid,streljanaobject[playerid]);
			    streljanaobject[playerid] = CreatePlayerObject(playerid,1486, 710.28943, 146.21544, -3.63650,   0.00000, 0.00000, 0.00000);
			    GameTextForPlayer(playerid,"~g~Nastavite dalje!",3000,3);
			    PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
			}
			else if(Trenira[playerid] == 3)
			{
			    Trenira[playerid]++;
			    DestroyPlayerObject(playerid,streljanaobject[playerid]);
			    streljanaobject[playerid] = CreatePlayerObject(playerid,1486, 713.14612, 144.70699, -3.63650,   0.00000, 0.00000, 0.00000);
			    GameTextForPlayer(playerid,"~g~Nastavite dalje!",3000,3);
			    PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
			}
			else if(Trenira[playerid] == 4)
			{
			    Trenira[playerid]++;
			    DestroyPlayerObject(playerid,streljanaobject[playerid]);
			    streljanaobject[playerid] = CreatePlayerObject(playerid,1486, 713.85712, 145.54448, -3.63650,   0.00000, 0.00000, 0.00000);
			    GameTextForPlayer(playerid,"~g~Nastavite dalje!",3000,3);
			    PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
			}
			else if(Trenira[playerid] == 5)
			{
			    Trenira[playerid]++;
			    DestroyPlayerObject(playerid,streljanaobject[playerid]);
			    streljanaobject[playerid] = CreatePlayerObject(playerid,1486, 715.73169, 146.22801, -3.63650,   0.00000, 0.00000, 0.00000);
			    GameTextForPlayer(playerid,"~g~Nastavite dalje!",3000,3);
			    PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
			}
			else if(Trenira[playerid] == 6)
			{
			    DestroyPlayerObject(playerid,streljanaobject[playerid]);
			    streljanaobject[playerid] = INVALID_OBJECT_ID;
			    Trenira[playerid] = -1;
          		new id = PlayerInfo[playerid][pUbizzu];
                SetPlayerPos(playerid,BiznisInfo[id][bIzlazX], BiznisInfo[id][bIzlazY], BiznisInfo[id][bIzlazZ]);
				SetPlayerVirtualWorld(playerid,BiznisInfo[id][bVW]);
				SetPlayerInterior(playerid,BiznisInfo[id][bInterior]);
				Freeze(playerid);
				ResetPlayerWeapons(playerid);
				for(new i=0;i<13;i++)
				{
				    GivePlayerWeapon(playerid,oldWeapons[playerid][i],oldAmmo[playerid][i]);
				    oldWeapons[playerid][i] = 0;
				    oldAmmo[playerid][i] = 0;
				}
				if((PlayerInfo[playerid][pWeaponSkill][TreniraState[playerid]] + 10) > 999) { PlayerInfo[playerid][pWeaponSkill][TreniraState[playerid]] = 999; }
				else { PlayerInfo[playerid][pWeaponSkill][TreniraState[playerid]] += 10; }
				TreniraState[playerid] = -1;
				for(new i=0;i<11;i++) { SetPlayerSkillLevel(playerid, i, PlayerInfo[playerid][pWeaponSkill][i]); }
				SacuvajIgraca(playerid);
				new str[50];
				format(str,sizeof(str),"~g~Uspjesno ste istrenirali skill! (+10)");
			    GameTextForPlayer(playerid,str,3000,3);
			    format(str,sizeof(str),"Uspjesno ste istrenirali skill! (+10)");
			    INFO(playerid,str);
			    PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
			}
	    }
	}
	
    return 1;
}
//==============================================================================
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(strfind(inputtext, "%", true) != -1)
	{
   		Kickaj(playerid,"Ne pokusavaj!");
        return 1;
	}
    switch(dialogid)
	{
	    case DIALOG_LOGIN:
	    {
	        if(!response) return Kickaj(playerid,"Prekinuta prijava!");
	        if(response)
	        {
	            if(udb_hash(inputtext) == PlayerInfo[playerid][pPass])
	            {
	                INI_ParseFile(UserPath(playerid),"LoadUser_%s",.bExtra = true,.extra = playerid);

	                if(!PlayerInfo[playerid][pRegistriran])
					{
   						SetupRegistration(playerid);
		   			}
	                else
	                {
	                    ResetPlayerMoney(playerid);
	                    GivePlayerMoney(playerid,PlayerInfo[playerid][pMoney]);
	                    SetPlayerScore(playerid,PlayerInfo[playerid][pLevel]);
	                	SetSpawnInfo(playerid,0,0,211.8062,-1451.3707,13.1172,225.0263,0,0,0,0,0,0);
        				SpawnPlayer(playerid);
						Ulogovan[playerid] = true;
					}
				}
				else
				{
				    pwfail[playerid]++;
				    new str[100];
				    format(str,sizeof(str),""crvena"Upisali ste pogresnu lozinku (%d/3)!\n"bijela"Molimo vas upisite ispravnu lozinku.",pwfail[playerid]);
				    if(pwfail[playerid] >= 3)
				    {
				        Kickaj(playerid,"Pogrijesili ste lozinku 3 puta!");
				    }
				    ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_INPUT,""plava""IME" - Login:",str,"Login","Izlaz");
				}
				return 1;
			}
	    }
		case DIALOG_REGISTER:
		{
		    if(!response) return 1;
	        if(response)
	        {
         		if(!strlen(inputtext)) return ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,""plava""IME" - Registracija:",""bijela"Molimo vas upisite zeljenu lozinku.","Dalje","Odustani");
				if(strlen(inputtext) < 6 || strlen(inputtext) > 21) return ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,""plava""IME" - Registracija:",""crvena"Ne mozete manje od 6 ili više od 21 slova!\n"bijela"Molimo vas upisite zeljenu lozinku.","Dalje","Odustani");
				new INI:File = INI_Open(UserPath(playerid));
				INI_SetTag(File,"data");
				INI_WriteInt(File,"Password",udb_hash(inputtext));
				INI_Close(File);
				SacuvajIgraca(playerid);

				new str1[50];
				format(str1,sizeof(str1),"%s",inputtext);
				PlayerTextDrawSetString(playerid, regp[0][playerid], str1);
				new str[120];
				format(str,sizeof(str),""plava"["TAG"] "bijela"Vasa lozinka je %s.",inputtext);
				SCM(playerid,-1,str);
				RegistracijaInfo[playerid][pLozinka] = 1;
			}
			return 1;
		}
		case DIALOG_GODINE:
		{
		    if(!response) return 1;
		    if(response)
		    {
		        new god = strval(inputtext);
		        if(god < MIN_GOD) return ShowPlayerDialog(playerid,DIALOG_GODINE,DIALOG_STYLE_INPUT,""plava""IME" - Registracija:",""crvena"Ne mozete manje od 10\n"bijela"Molimo vas upisite koliko imate godina.","Dalje","Odustani");
                if(god > MAX_GOD) return ShowPlayerDialog(playerid,DIALOG_GODINE,DIALOG_STYLE_INPUT,""plava""IME" - Registracija:",""crvena"Ne mozete vise od 70\n"bijela"Molimo vas upisite koliko imate godina.","Dalje","Odustani");
				PlayerInfo[playerid][pGodine] = god;
				new str[120];
				format(str,sizeof(str),""plava"["TAG"] "bijela"Imate %d godina.",god);
				SCM(playerid,-1,str);
				RegistracijaInfo[playerid][pGodine] = 1;
				new str1[3];
				format(str1,sizeof(str1),"%d",god);
				PlayerTextDrawSetString(playerid, regp[2][playerid], str1);
			}
			return 1;
		}
		case DIALOG_DRZAVA:
		{
		    if(!response) return 1;
		    if(response)
		    {
		        new dtxt[24];
		        switch(listitem)
		        {
              		case 0:
		            {
		                PlayerInfo[playerid][pDrzava] = 0;
		                dtxt = "Hrvatska";
					}
					case 1:
		            {
		                PlayerInfo[playerid][pDrzava] = 1;
		                dtxt = "Srbija";
					}
					case 2:
		            {
		                PlayerInfo[playerid][pDrzava] = 2;
		                dtxt = "BIH";
					}
					case 3:
		            {
		                PlayerInfo[playerid][pDrzava] = 3;
		                dtxt = "Ostalo";
					}
		        }
		        new str[120];
				format(str,sizeof(str),""plava"["TAG"] "bijela"Vasa drzava je %s.",dtxt);
				SCM(playerid,-1,str);
				RegistracijaInfo[playerid][pDrzava] = 1;
				PlayerTextDrawSetString(playerid, regp[3][playerid], dtxt);
			}
			return 1;
		}
		case DIALOG_MAIL:
		{
		    if(!response) return 1;
		    if(response)
		    {
		        new text[50];
			    if(sscanf(inputtext,"s[50]",text)) return 1;
				if(strfind(text,"@",true)!= -1 && strfind(text,".",true)!= -1)
				{
				    if(strlen(text) < 12) return ShowPlayerDialog(playerid,DIALOG_MAIL,DIALOG_STYLE_INPUT,""plava""IME" - Registracija:",""crvena"Mail ne postoji!\n"bijela"Molimo vas upisite vas mail.","Dalje","Odustani");
					strmid(PlayerInfo[playerid][pMail], text, 0, strlen(text), 255);
					new str[120];
					format(str,sizeof(str),""plava"["TAG"] "bijela"Vas mail je %s.",PlayerInfo[playerid][pMail]);
					SCM(playerid,-1,str);
					RegistracijaInfo[playerid][pMail] = 1;
					/*if(strfind(text,"gmail",true) != -1) { strdel(text, strlen(text)-10, strlen(text)); }
					else if(strfind(text,"hotmail",true) != -1) { strdel(text, strlen(text)-12, strlen(text)); }*/
					PlayerTextDrawSetString(playerid, regp[1][playerid], text);
				}
		    }
		    return 1;
		}
		case DIALOG_PROVJERA:
		{
		    if(!response) return 1;
			if(response)
			{
			    PlayerInfo[playerid][pRegistriran] = true;
			    Ulogovan[playerid] = true;
			    //pocetni stats
			    ResetPlayerMoney(playerid);
			    GivePlayerMoney(playerid,150000);
			    PlayerInfo[playerid][pMoney] = 150000;
			    PlayerInfo[playerid][pAdmin] = 0;
			    PlayerInfo[playerid][pLevel] = 1;
			    SetPlayerScore(playerid,PlayerInfo[playerid][pLevel]);

                new skinid = 0;
				if(RegistracijaInfo[playerid][pNumb] == 0) { skinid = 23; }
				else if(RegistracijaInfo[playerid][pNumb] == 1) { skinid = 12; }
		        else if(RegistracijaInfo[playerid][pNumb] == 2) { skinid = 26; }
		        else if(RegistracijaInfo[playerid][pNumb] == 3) { skinid = 40; }
		        else if(RegistracijaInfo[playerid][pNumb] == 4) { skinid = 46; }
		        else if(RegistracijaInfo[playerid][pNumb] == 5) { skinid = 55; }
		        else { skinid = 23; RegistracijaInfo[playerid][pNumb] = 0; }
		        PlayerInfo[playerid][pSkin] = skinid;
		        SetPlayerSkin(playerid,skinid);
				for(new i=0;i<sizeof(reg);i++) { TextDrawHideForPlayer(playerid,reg[i]); }
				for(new i=0;i<sizeof(regp);i++) { PlayerTextDrawHide(playerid,regp[i][playerid]); }
				CancelSelectTextDraw(playerid);
				new lgg[200];
				format(lgg,sizeof(lgg),"[REG] | %s |",GetName(playerid));
				Log(REG_LOG,lgg);
				format(lgg,sizeof(lgg),""zelena"[REGISTRACIJA] "zuta"Igrac %s se upravo registrirao!",GetName(playerid));
				SendAdminMessage(lgg);
				ClearChat(playerid);
				SetSpawnInfo(playerid,0,0,211.8062,-1451.3707,13.1172,225.0263,0,0,0,0,0,0);
				
				new mje,god,dan,sat,minu,sec;
				getdate(god,mje,dan);
				gettime(sat,minu,sec);
				PlayerInfo[playerid][pRegGod] = god;
    			PlayerInfo[playerid][pRegMje] = mje;
    			PlayerInfo[playerid][pRegDan] = dan;
    			PlayerInfo[playerid][pRegSat] = sat;
    			PlayerInfo[playerid][pRegMin] = minu;
    			PlayerInfo[playerid][pRegSec] = sec;
    			
				SpawnPlayer(playerid);
			}
			return 1;
		}
		case DIALOG_SPOL:
		{
		    if(response)
		    {
		        PlayerInfo[playerid][pSpol] = 1;
			    new str[120];
				format(str,sizeof(str),""plava"["TAG"] "bijela"Vi ste musko.",PlayerInfo[playerid][pMail]);
				SCM(playerid,-1,str);
				RegistracijaInfo[playerid][pSpol] = 1;
				PlayerTextDrawSetString(playerid, regp[4][playerid], "Musko");
		    }
		    else
		    {
		        PlayerInfo[playerid][pSpol] = 2;
			    new str[120];
				format(str,sizeof(str),""plava"["TAG"] "bijela"Vi ste zensko.",PlayerInfo[playerid][pMail]);
				SCM(playerid,-1,str);
				RegistracijaInfo[playerid][pSpol] = 1;
				PlayerTextDrawSetString(playerid, regp[4][playerid], "Zensko");
		    }
		    return 1;
		}
		case DIALOG_PODESAVANJA:
		{
		    if(!response) return 1;
		    if(response)
		    {
				switch(listitem)
				{
				    case 0:
				    {
						if(ServerInfo[sRegistracija])
						{
		    				ServerInfo[sRegistracija] = false;
					    	INFO(playerid,"Iskljucili ste registraciju.");
						}
						else if(!ServerInfo[sRegistracija])
						{
		    				ServerInfo[sRegistracija] = true;
						    INFO(playerid,"Ukljucili ste registraciju.");
						}
						SacuvajServer();
				    }
				    case 1:
				    {
						if(ServerInfo[sLogin])
						{
		    				ServerInfo[sLogin] = false;
					    	INFO(playerid,"Iskljucili ste prijavu.");
						}
						else if(!ServerInfo[sLogin])
						{
		    				ServerInfo[sLogin] = true;
		    				INFO(playerid,"Ukljucili ste prijavu.");
						}
						SacuvajServer();
					}
					case 2:
				    {
						if(dupliexp)
						{
		    				dupliexp = false;
					    	INFO(playerid,"Iskljucio si dupli EXP.");
						}
						else if(!dupliexp)
						{
		    				dupliexp = true;
		    				INFO(playerid,"Ukljucio si dupli EXP.");
						}
						SacuvajServer();
					}
					case 3:
				    {
						if(ServerInfo[sBiznisPlace])
						{
		    				ServerInfo[sBiznisPlace] = false;
					    	INFO(playerid,"Iskljucili ste place za biznise.");
						}
						else if(!ServerInfo[sBiznisPlace])
						{
		    				ServerInfo[sBiznisPlace] = true;
		    				INFO(playerid,"Ukljucili ste place za biznise.");
						}
						SacuvajServer();
					}
					case 4:
				    {
						if(ServerInfo[sSalon])
						{
		    				ServerInfo[sSalon] = false;
					    	INFO(playerid,"Iskljucili ste kupovinu u salonima.");
						}
						else if(!ServerInfo[sSalon])
						{
		    				ServerInfo[sSalon] = true;
		    				INFO(playerid,"Ukljucili ste kupovinu u salonima.");
						}
						SacuvajServer();
					}
					case 5:
				    {
						if(ServerInfo[sSajam])
						{
		    				ServerInfo[sSajam] = false;
					    	INFO(playerid,"Iskljucili ste kupovinu na sajmu.");
						}
						else if(!ServerInfo[sSajam])
						{
		    				ServerInfo[sSajam] = true;
		    				INFO(playerid,"Ukljucili ste kupovinu na sajmu.");
						}
						SacuvajServer();
					}
					case 6:
				    {
						ShowPlayerDialog(playerid,DIALOG_RENTCIJENA,DIALOG_STYLE_INPUT,""plava""IME" - Rent Cijena:!","Upisite novu cijenu renta!","Promijeni","Odustani");
					}
					case 7:
				    {
						if(ServerInfo[sZauzimanjeZona])
						{
		    				ServerInfo[sZauzimanjeZona] = false;
					    	INFO(playerid,"Iskljucili ste zauzimanje zona.");
						}
						else if(!ServerInfo[sZauzimanjeZona])
						{
		    				ServerInfo[sZauzimanjeZona] = true;
		    				INFO(playerid,"Ukljucili ste zauzimanje zona.");
						}
						SacuvajServer();
					}
					case 8:
				    {
						if(ServerInfo[sZonaPlace])
						{
		    				ServerInfo[sZonaPlace] = false;
					    	INFO(playerid,"Iskljucili ste place za zone.");
						}
						else if(!ServerInfo[sZonaPlace])
						{
		    				ServerInfo[sZonaPlace] = true;
		    				INFO(playerid,"Ukljucili ste place za zone.");
						}
						SacuvajServer();
					}
				}
		    }
		    return 1;
		}
		case DIALOG_BIZNIS:
		{
		    if(!response) return 1;
		    if(response)
		    {
		        if(PlayerInfo[playerid][pBizzID] == -1) return ERROR(playerid,"Nemate biznis!");
		        switch(listitem)
		        {
		        	case 0:
		        	{
					    new id = PlayerInfo[playerid][pBizzID];
						if(BiznisInfo[id][bLocked])
						{
					    	BiznisInfo[id][bLocked] = false;
					    	GameTextForPlayer(playerid,"~g~Otkljucano!",1000,3);
					    	SacuvajBiznis(id);
						}
				 		else if(!BiznisInfo[id][bLocked])
				 		{
				   			BiznisInfo[id][bLocked] = true;
				    		GameTextForPlayer(playerid,"~r~Zakljucano!",1000,3);
					    	SacuvajBiznis(id);
						}
		        	}
		        	case 1:
		        	{
		        	    new str[150];
	    				new novac = BiznisInfo[PlayerInfo[playerid][pBizzID]][bPrice]/2;
	    				format(str,sizeof(str),""bijela"Jeste li sigurni da zelite prodati biznis drzavi za "zuta"%d$",novac);
	    				ShowPlayerDialog(playerid,DIALOG_BIZNIS7,DIALOG_STYLE_MSGBOX,""plava""IME" - Biznis:",str,"Prodaj","Odustani");
		        	}
					case 2:
					{
					    new id = PlayerInfo[playerid][pBizzID];
						new str[500];
						format(str,sizeof(str),""plava"Vlasnik: "bijela"%s\n"plava"Ime: "bijela"%s\n"plava"Level: "bijela"%d\n"plava"Cijena: "bijela"%d$\n"plava"Novac: "bijela"%d$",BiznisInfo[id][bOwnerName],BiznisInfo[id][bName],BiznisInfo[id][bLevel],BiznisInfo[id][bPrice],BiznisInfo[id][bMoney]);
						ShowPlayerDialog(playerid,DIALOG_BIZNIS2,DIALOG_STYLE_MSGBOX,""plava""IME" - Biznis:",str,"Ok","");
					}
					case 3:
					{
	    				ShowPlayerDialog(playerid,DIALOG_BIZNIS5,DIALOG_STYLE_INPUT,""plava""IME" - Biznis:",""bijela"Upisite novo ime biznisa:","Promijeni","Odustani");
					}
					case 4:
					{
					    ShowPlayerDialog(playerid,DIALOG_BIZNIS6,DIALOG_STYLE_LIST,""plava""IME" - Biznis:",""bijela"Uzmi novac\n"bijela"Ostavi novac","Dalje","Odustani");
					}
				}
				return 1;
		    }
		    return 1;
		}
		case DIALOG_BIZNIS6:
		{
		    if(!response) return 1;
		    if(response)
			{
				switch(listitem)
				{
	                case 0:
					{
	    				if(PlayerInfo[playerid][pBizzID] == -1) return ERROR(playerid,"Nemate biznis!");
	        			ShowPlayerDialog(playerid,DIALOG_BIZNIS3,DIALOG_STYLE_INPUT,""plava""IME" - Biznis:",""bijela"Upisite koliko novca zelite uzeti.","Uzmi","Odustani");
					}
					case 1:
					{
	    				if(PlayerInfo[playerid][pBizzID] == -1) return ERROR(playerid,"Nemate biznis!");
	        			ShowPlayerDialog(playerid,DIALOG_BIZNIS4,DIALOG_STYLE_INPUT,""plava""IME" - Biznis:",""bijela"Upisite koliko novca zelite ostaviti u biznisu.","Ostavi","Odustani");
					}
				}
			}
			return 1;
		}
		case DIALOG_BIZNIS3:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pBizzID] == -1) return ERROR(playerid,"Nemate biznis!");
			    new id = PlayerInfo[playerid][pBizzID];
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_BIZNIS3,DIALOG_STYLE_INPUT,""plava""IME" - Biznis:",""bijela"Upisite koliko novca zelite uzeti.","Uzmi","Odustani");
				if(money > BiznisInfo[id][bMoney]) return ShowPlayerDialog(playerid,DIALOG_BIZNIS3,DIALOG_STYLE_INPUT,""plava""IME" - Biznis:",""crvena"ERROR\n"crvena"Upisali ste previse novca!\n"bijela"Upiste koliko novca zelite uzeti.","Uzmi","Odustani");
				BiznisInfo[id][bMoney] -= money;
				GivePlayerMoney(playerid,money);
				PlayerInfo[playerid][pMoney] += money;
				INFO(playerid,"Uspjesno ste uzeli novac!");
				SacuvajBiznis(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_BIZNIS4:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pBizzID] == -1) return ERROR(playerid,"Nemate biznis!");
			    new id = PlayerInfo[playerid][pBizzID];
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_BIZNIS4,DIALOG_STYLE_INPUT,""plava""IME" - Biznis:",""bijela"Upiste koliko novca zelite ostaviti u biznisu.","Ostavi","Odustani");
				if(money > PlayerInfo[playerid][pMoney]) return ShowPlayerDialog(playerid,DIALOG_BIZNIS4,DIALOG_STYLE_INPUT,""plava""IME" - Biznis:",""crvena"ERROR\n"crvena"Upisali ste previse novca!\n"bijela"Upisi koliko novca zelite ostaviti u biznisu.","Ostavi","Odustani");
				BiznisInfo[id][bMoney] += money;
				GivePlayerMoney(playerid,-money);
				PlayerInfo[playerid][pMoney] -= money;
				INFO(playerid,"Uspjesno ste ostavili novac u biznisu!");
				SacuvajBiznis(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_BIZNIS5:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pBizzID] == -1) return ERROR(playerid,"Nemate biznis!");
			    new id = PlayerInfo[playerid][pBizzID];
				new text[24];
			    if(sscanf(inputtext,"s[24]",text)) return ShowPlayerDialog(playerid,DIALOG_BIZNIS5,DIALOG_STYLE_INPUT,""plava""IME" - Biznis:",""bijela"Upisite novo ime biznisa.","Promijeni","Odustani");
				strmid(BiznisInfo[id][bName], text, 0, strlen(text), MAX_PLAYER_NAME);
				BiznisLP(id);
				SacuvajBiznis(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_BIZNIS7:
		{
		    if(!response) return 1;
		    if(PlayerInfo[playerid][pBizzID] == -1) return ERROR(playerid,"Nemate biznis!");
		    new id = PlayerInfo[playerid][pBizzID];
			BiznisInfo[id][bOwned] = false;
			strmid(BiznisInfo[id][bOwnerName], "Drzava", 0, strlen("Drzava"), MAX_PLAYER_NAME);
			BiznisLP(id);
			BiznisInfo[id][bLocked] = false;
			new novac = BiznisInfo[id][bPrice]/2;
			GivePlayerMoney(playerid,novac);
			PlayerInfo[playerid][pMoney] += novac;
			PlayerInfo[playerid][pBizzID] = -1;
			SacuvajBiznis(id);
			SacuvajIgraca(playerid);
			new str[70];
			format(str,sizeof(str),"Uspjesno ste prodali biznis drzavi za "zelena"%d$"bijela".",novac);
			INFO(playerid,str);
			return 1;
		}
		case DIALOG_HELP:
		{
		    if(!response) return 1;
			{
				new str[2000],str1[150];
				switch(listitem)
				{
					case 0:
					{
					    format(str1,sizeof(str1),""zuta"Komande za biznis:\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/biznis "bijela"- komanda koja sluzi za upravljanje vasim biznisom.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/kupibiznis "bijela"- komanda koja sluzi za kupovinu biznisa.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/kupi "bijela"- komanda koja sluzi za kupovinu u biznisima.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/kladionica "bijela"- komanda koja sluzi za kladenje u kladionici.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/uplati "bijela"- komanda koja sluzi za uplatu na bankovni racun u postama.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/sellbiznisto "bijela"- komanda koja sluzi za prodavanje biznisa drugom igracu.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""bijela"Za ulazak u biznis pritisnite '"plava"F"bijela"' ili '"plava"ENTER"bijela"'.\n");
					    strcat(str,str1);
					}
					case 1:
					{
                        format(str1,sizeof(str1),""zuta"Komande za banku:\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/banka "bijela"- komanda koja sluzi za upravljanje vasim bankovnim racunom u banci.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/transfer "bijela"- komanda koja sluzi za slanje novca sa vaseg bankovnog racuna nekom igracu.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/kredit "bijela"- komanda koja sluzi za podizanje kredita u banci.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/otplatikredit "bijela"- komanda koja sluzi za otplacivanje kredita u banci.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/bankomat "bijela"- komanda koja sluzi za pregled stanja vase bankovnog racuna i podzianje novca na bankomatima.\n");
					    strcat(str,str1);
					}
					case 2:
					{
					    format(str1,sizeof(str1),""roza"Komande za posao:\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""roza"/oprema "bijela"- komanda koja sluzi za uzimanje poslovne opreme i alata.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""roza"/otkaz "bijela"- komanda koja sluzi za davanje otkaza.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""roza"/poslovi "bijela"- komanda koja sluzi za pregled i lociranje poslova.\n");
					    strcat(str,str1);
					    if(PlayerInfo[playerid][pPosao] == KAMIONDZIJA)
					    {
					        format(str1,sizeof(str1),""roza"/isporuka "bijela"- komanda koja sluzi za pokretanje posla.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""roza"/gettrailerid "bijela"- komanda koja vam daje id vase prikolice.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""roza"/loactemytrailer "bijela"- komanda koja sluzi za lociranje vase prikolice.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""roza"/prekiniisporuku "bijela"- komanda koja sluzi za prekidanje isporuke.\n");
					    	strcat(str,str1);
					    }
					    else if(PlayerInfo[playerid][pPosao] == FARMER)
					    {
					       	format(str1,sizeof(str1),""roza"/zakvaci "bijela"- komanda kojom se zakvaci prikolica.\n");
				    		strcat(str,str1);
				    		format(str1,sizeof(str1),""roza"/fzapocni "bijela"- komanda kojom se zapocinje posao.\n");
				    		strcat(str,str1);
				    		format(str1,sizeof(str1),""roza"/fprekini "bijela"- komanda kojom se prekida posao.\n");
				    		strcat(str,str1);
					    }
					    else if(PlayerInfo[playerid][pPosao] == GRADEVINAR)
					    {
					       	format(str1,sizeof(str1),""roza"/gradevinar "bijela"- komanda kojom se zapocinje posao.\n");
				    		strcat(str,str1);
				    		format(str1,sizeof(str1),""roza"/gprekini "bijela"- komanda kojom se prekida posao.\n");
				    		strcat(str,str1);
					    }
					    else if(PlayerInfo[playerid][pPosao] == RUDAR)
					    {
					       	format(str1,sizeof(str1),""roza"/kopajzlato "bijela"- komanda kojom se zapocinje posao.\n");
				    		strcat(str,str1);
				    		format(str1,sizeof(str1),""roza"/prekinikopanje "bijela"- komanda kojom se prekida posao.\n");
				    		strcat(str,str1);
					    }
					    else if(PlayerInfo[playerid][pPosao] == ZAVARIVAC)
					    {
					       	format(str1,sizeof(str1),""roza"/zavari "bijela"- komanda kojom se zapocinje posao.\n");
				    		strcat(str,str1);
				    		format(str1,sizeof(str1),""roza"/prekinivarenje "bijela"- komanda kojom se prekida posao.\n");
				    		strcat(str,str1);
					    }
					    else
					    {
                            format(str1,sizeof(str1),""roza"Vise komandi o vasem poslu cete dobit kad se zaposlite!\n");
					    	strcat(str,str1);
					    }
					}
					case 3:
					{
					    format(str1,sizeof(str1),""zuta"Komande za kucu:\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/kuca "bijela"- komanda koja sluzi za upravljanje vasom kucom.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/kupikucu "bijela"- komanda koja sluzi za kupovinu kuce.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/sellkucato "bijela"- komanda koja sluzi za prodavanje kuce drugom igracu.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""bijela"Za ulazak u kucu pritisnite '"plava"F"bijela"' ili '"plava"ENTER"bijela"'.\n");
					    strcat(str,str1);
					}
					case 4:
					{
					    format(str1,sizeof(str1),""zuta"Komande za vozila:\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/kupivozilo "bijela"- komanda koja sluzi za kupovanje vozila na sajmu.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/v "bijela"- komanda koja sluzi za upravljanje vasim vozilima.\n");
					    strcat(str,str1);
                        format(str1,sizeof(str1),""plava"/katalog "bijela"- komanda koja sluzi za kupovanje vaseg vozila u salonu.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/izlaz "bijela"- komanda koja sluzi za izaci iz vozila u koje udete na sajmu.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/gepek "bijela"- komanda koja sluzi za otvaranje gepeka na vozilima.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/gmenu "bijela"- komanda koja sluzi za uzimanje i ostavljanje stvari u gepeku osobnih vozila.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/sellcarto "bijela"- komanda koja sluzi za prodavanje vaseg vozila drugom igracu.\n");
					    strcat(str,str1);
					}
					case 5:
					{
						if(PlayerInfo[playerid][pAdmin] >= 1)
						{
							strcat(str, ""zuta"Admin Level 1 | "bijela"/specon /specoff /count /aduty /apopravi /cc /kick /goto /slap /freeze /unfreeze /rtc /mlista /ajail /pustipjesmu\n", sizeof(str));
							strcat(str, ""zuta"Admin Level 1 | "bijela"/akill /gethere /sethp /avozilo /a /ao /nitro /ban /pm /jlista /port /pitanja(/pp, /questions) /pustipjesmu2\n", sizeof(str));
					        strcat(str, ""zuta"Admin Level 1 | "bijela"/rcc /portmyvehicle /g /setvw /setint /portdobiznisa /portdokuce /portdobenzinske /portdoorganizacije \n\n", sizeof(str));
                            strcat(str, ""zuta"Admin Level 1 | "bijela"/aspawn /afklista /astats /ubaciuvozilo /asl /setubizu /setukuci /setuorg /vc /portdobankomata /portdoposla /setustanu\n\n", sizeof(str));
						}
						if(PlayerInfo[playerid][pAdmin] >= 2)
						{
							strcat(str, ""zuta"Admin Level 2 | "bijela"/mute /rac /uvozilo /getvozilo /getvoziloid /gpvid /respawntrailers /updateonlinerekord\n\n", sizeof(str));
                            strcat(str, ""zuta"Admin Level 2 | "bijela"/pokrenievent /stopevent /eventcount\n\n", sizeof(str));
						}
						if(PlayerInfo[playerid][pAdmin] >= 3)
						{
							strcat(str, ""zuta"Admin Level 3 | "bijela"/gotopos /unmute /bojavozila /aocistidosije /aotkaz\n\n", sizeof(str));
						}
						if(PlayerInfo[playerid][pAdmin] >= 4)
						{
							strcat(str, ""zuta"Admin Level 4 | "bijela"/setskin /unban /anapuni /jetpack /setarmour /vipfix /offban\n\n", sizeof(str));
						}
						if(PlayerInfo[playerid][pAdmin] >= 5)
						{
							strcat(str, ""zuta"Admin Level 5 | "bijela"/adozvole /adajsvima /sacuvajigrace /unjail /veh /postavilidera /dpostaviadmina /adajoruzje\n\n", sizeof(str));
						}
						if(PlayerInfo[playerid][pAdmin] >= 6)
						{
							strcat(str, ""zuta"Admin Level 6 | "bijela"/postaviadmina /postavigamemastera /givemoney /setmoney /kreirajbiznis /kreirajkucu /kreirajkucuex\n", sizeof(str));
							strcat(str, ""zuta"Admin Level 6 | "bijela"/setstats /kreirajteleport /kreirajgps /kreirajvozilo /dajvip /resetgangzoneowners\n", sizeof(str));
					        strcat(str, ""zuta"Admin Level 6 | "bijela"/izbrisibiznis /izbrisikucu /izbrisistan /getbiznisid /getkucaid /getstanid /erent /resetbankrob\n", sizeof(str));
					        strcat(str, ""zuta"Admin Level 6 | "bijela"/izbrisiteleport /izbrisigps /spodesavanja /camera /cameraoff /getbankomatid \n", sizeof(str));
					        strcat(str, ""zuta"Admin Level 6 | "bijela"/kreirajbenzinsku /izbrisibenzinsku /getbenzinskaid /izbrisibankomat /kreirajstan /kreirajstanex \n", sizeof(str));
					        strcat(str, ""zuta"Admin Level 6 | "bijela"/addspecnick /deletespecnick\n", sizeof(str));
						}
					}
					case 6:
					{
					    if(PlayerInfo[playerid][pAdmin] >= 5 || PlayerInfo[playerid][pGameMaster] >= 1)
						{
							strcat(str, ""zelena"GameMaster Level 1 | "bijela"/count /cc /goto /slap /unfreeze /rtc /mlista /ajail /avozilo /pustipjesmu /apopravi /g\n", sizeof(str));
					        strcat(str, ""zelena"GameMaster Level 1 | "bijela"/pm /jlista /port /gmduty /mute /kick /pitanja(/pp, /questions) /pustipjesmu2 /portmyvehicle\n", sizeof(str));
						}
						if(PlayerInfo[playerid][pAdmin] >= 5 || PlayerInfo[playerid][pGameMaster] >= 2)
						{
					        strcat(str, ""zelena"GameMaster Level 2 | "bijela"/freeze /gethere /nitro\n", sizeof(str));
						}
						if(PlayerInfo[playerid][pAdmin] >= 5 || PlayerInfo[playerid][pGameMaster] >= 3)
						{
					        strcat(str, ""zelena"GameMaster Level 3 | "bijela"/ao /rac /postavigamemastera /specon /specoff /pokrenievent /stopevent /eventcount\n", sizeof(str));
						}
					}
					case 7:
					{
					    format(str1,sizeof(str1),""zuta"Osnovne komande:\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/askq "bijela"- komanda koja sluzi za slanje pitanja adminima.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/staff "bijela"- komanda koja sluzi za prikazivanje admina i gamemastera na duznosti.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/offmusic "bijela"- komanda koja sluzi za prekidanje pjesme.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/gps "bijela"- komanda koja sluzi za pregled gps-a.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/gpsoff "bijela"- komanda koja sluzi za gasenje gps-a.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/smoke "bijela"- komanda koja sluzi za pusenje cigareta.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/natoci "bijela"- komanda koja sluzi za tocenje goriva na benzinskama.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/p(romijeni)spawn "bijela"- komanda koja sluzi za mijenjanje mjesta spawna.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/sellzlatoto "bijela"- komanda koja sluzi za prodavanje zlata drugom igracu.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/w "bijela"- komanda koja sluzi za saptanje.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/s "bijela"- komanda koja sluzi za vikanje.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/me "bijela"- komanda koja sluzi za pokazivanje radnja.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/do "bijela"- komanda koja sluzi za pokazivanje radnja.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/b "bijela"- komanda koja sluzi za ooc chat.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/stats "bijela"- komanda koja sluzi za gledanje vlastite statistike.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/izbaciizvozila "bijela"- komanda koja sluzi za izbacivanje igraca iz vozila.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""plava"/ss "bijela"- komanda koja sluzi za pokazivanje statsa drugom igracu.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/pay "bijela"- komanda koja sluzi za davanje novca nekom igracu.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/daj "bijela"- komanda koja sluzi za davanje stvari drugom igracu.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/unrentaj "bijela"- komanda koja sluzi za vracanje rentanog vozila.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/settings "bijela"- komanda koja sluzi za podesavanje profila.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/refresh "bijela"- komanda koja sluzi za refresh igre.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/weaponskills "bijela"- komanda koja sluzi za gledanje skillova oruzja.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/showweaponskills "bijela"- komanda koja sluzi za pokazivanje skillova oruzja drugom igracu.\n");
					    strcat(str,str1);
					}
					case 8:
					{
					    format(str1,sizeof(str1),""smeda"Komande za organizaciju:\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""smeda"/onlinelideri "bijela"- komanda koja sluzi za gledanje liste lidera.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""smeda"/f "bijela"- komanda koja sluzi za komuniciranje unutar organizacije.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""smeda"/koristidrogu "bijela"- komanda koja sluzi za konzumiranje.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""smeda"/selldrogato "bijela"- komanda koja sluzi za prodavanje droge drugom igracu.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""smeda"/sellmatsto "bijela"- komanda koja sluzi za prodavanje matsa drugom igracu.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""smeda"/marama "bijela"- komanda koja sluzi za stavljanje marame.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""smeda"/attackzone "bijela"- komanda koja sluzi za pokretanje zauzimanja zone.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""smeda"/zoneinfo "bijela"- komanda koja sluzi za informacije o zoni.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""smeda"/zavezi "bijela"- komanda koja sluzi za vezanje igraca.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""smeda"/odvezi "bijela"- komanda koja sluzi za odvezivanje zavezanog igraca.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""smeda"/vuci2 "bijela"- komanda koja sluzi za vucu zavezanog igraca.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""smeda"/prestanivuci2 "bijela"- komanda koja sluzi za prestajanje vuce igraca.\n");
					    strcat(str,str1);
					    if(PlayerInfo[playerid][pOrgID] == POLICIJA)
					    {
					        format(str1,sizeof(str1),""smeda"POLICIJA\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/pdduznost "bijela"- komanda koja sluzi za uzimanje duznosti.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/pdoprema "bijela"- komanda koja sluzi za uzimanje opreme.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/su "bijela"- komanda koja sluzi za davanje wanted levela.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/cuff "bijela"- komanda koja sluzi za stavljanje lisica.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/uncuff "bijela"- komanda koja sluzi za skidanje lisica.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/vuci "bijela"- komanda koja sluzi za vucu igraca.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/prestanivuci "bijela"- komanda koja sluzi za prekidanje vuce igraca.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/ubaciuvozilo "bijela"- komanda koja sluzi za ubacivanje igraca u vozilo.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/izbaciizvozila "bijela"- komanda koja sluzi za izbacivanje igraca iz vozila.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/uhapsi "bijela"- komanda koja sluzi za hapsenje igraca.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/lociraj "bijela"- komanda koja sluzi za lociranje igraca.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/megafon "bijela"- komanda koja sluzi za govor na daleko.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/pretresi "bijela"- komanda koja sluzi za pretres igraca.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/oduzmi "bijela"- komanda koja sluzi za oduzimanje zabranjenih stvari.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"Biljka droge "bijela"- da unistite biljku droge pritisnite Y.\n");
					    	strcat(str,str1);
					    	if(PlayerInfo[playerid][pRank] >= 5)
							{
					    		format(str1,sizeof(str1),""plava"/najava "bijela"- komanda koja sluzi za najave svima igracima.\n");
					    		strcat(str,str1);
					    		format(str1,sizeof(str1),""plava"/orginfo "bijela"- komanda koja sluzi za pregled informacija o organizaciji.\n");
					    		strcat(str,str1);
							}
						}
					    if(PlayerInfo[playerid][pOrgID] != -1 && PlayerInfo[playerid][pRank] == 6)
					    {
					        format(str1,sizeof(str1),""smeda"/ubaci "bijela"- komanda koja sluzi za ubacivanje clanova.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/izbaci "bijela"- komanda koja sluzi za izbacivanje clanova.\n");
					    	strcat(str,str1);
					    	format(str1,sizeof(str1),""smeda"/dodijelirank "bijela"- komanda koja sluzi za mijenanje ranka igraca.\n");
					    	strcat(str,str1);
					    }
					}
					case 9:
					{
	    				format(str1,sizeof(str1),""zuta"Komande za dozvole:\n");
				    	strcat(str,str1);
	                    format(str1,sizeof(str1),""plava"/kupidozvoluo "bijela"- komanda koja sluzi za kupovinu dozvole za oruzje.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""plava"/polaganje "bijela"- komanda koja sluzi za polaganje dozvole u autoskoli.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""plava"/prekinipolaganje "bijela"- komanda koja sluzi za prekid polaganja.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""plava"/sl "bijela"- komanda koja sluzi za pokazivanje svojih dozvola.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""plava"/dozvole "bijela"- komanda koja sluzi za pregled polozenih dozvola.\n");
				    	strcat(str,str1);
					}
					case 10:
					{
	    				format(str1,sizeof(str1),""zuta"Komande za mobitel:\n");
				    	strcat(str,str1);
	                    format(str1,sizeof(str1),""zelena"/call "bijela"- komanda koja sluzi za poziv.\n");
				    	strcat(str,str1);
                        format(str1,sizeof(str1),""zelena"/p "bijela"- komanda koja sluzi za javljanje.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""zelena"/h "bijela"- komanda koja sluzi za prekid poziva.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""zelena"/sms "bijela"- komanda koja sluzi za slanje poruke.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""zelena"/smsoglas "bijela"- komanda koja sluzi za postavljanje oglasa.\n");
				    	strcat(str,str1);
					}
					case 11:
					{
	    				format(str1,sizeof(str1),""zuta"Komande za crno trziste:\n");
				    	strcat(str,str1);
	                    format(str1,sizeof(str1),""smeda"/ckupioruzje "bijela"- komanda koja sluzi za kupovinu oruzja.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""smeda"/ckupidrogu "bijela"- komanda koja sluzi za kupovinu droge.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""smeda"/cprodajdrogu "bijela"- komanda koja sluzi za prodavaju droge.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""smeda"/ckupimats "bijela"- komanda koja sluzi za kupovinu matsa.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""smeda"/cprodajmats "bijela"- komanda koja sluzi za prodaju matsa.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""smeda"/cnapravioruzje "bijela"- komanda koja sluzi za izradu orzuja.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""smeda"/ckupisjeme "bijela"- komanda koja sluzi za kupovinu sjemena droge.\n");
				    	strcat(str,str1);
				    	format(str1,sizeof(str1),""smeda"/posadidrogu "bijela"- komanda koja sluzi za sadenje droge.\n");
				    	strcat(str,str1);
					}
					case 12:
					{
					    if(PlayerInfo[playerid][pAdmin] >= 5 || PlayerInfo[playerid][pVip] >= 1)
					    {
					    	format(str1,sizeof(str1),""zuta"Komande za vipove:\n");
				    		strcat(str,str1);
	                    	format(str1,sizeof(str1),""roza"/portmyvehicle "bijela"- komanda koja sluzi za portanje privatnog vozila.\n");
				    		strcat(str,str1);
        					format(str1,sizeof(str1),""roza"/vc "bijela"- vip chat.\n");
				    		strcat(str,str1);
				    		format(str1,sizeof(str1),""roza"/port "bijela"- komanda koja sluzi za portanje do vaznijih lokacija.\n");
				    		strcat(str,str1);
				    		format(str1,sizeof(str1),""roza"/vipfix "bijela"- komanda koja sluzi za popravak vozila.\n");
				    		strcat(str,str1);
						}
					}
					case 13:
					{
					    format(str1,sizeof(str1),""zuta"Komande za stan:\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/stan "bijela"- komanda koja sluzi za upravljanje vasim stanom.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/kupistan "bijela"- komanda koja sluzi za kupovinu stana.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""plava"/sellstanto "bijela"- komanda koja sluzi za prodavanje stana drugom igracu.\n");
					    strcat(str,str1);
					    format(str1,sizeof(str1),""bijela"Za ulazak u stan pritisnite '"plava"F"bijela"' ili '"plava"ENTER"bijela"'.\n");
					    strcat(str,str1);
					}
				}
				ShowPlayerDialog(playerid,DIALOG_HELP2,DIALOG_STYLE_MSGBOX,""plava""IME" - Help",str,"Ok","");
			}
			return 1;
		}
		case DIALOG_TELEPORT:
		{
		    if(!response) return 1;
		    if(response)
		    {
		        new id = listitem;
		        new str1[20];
 				format(str1,sizeof(str1),TPATH,id);
				if(!fexist(str1)) return ERROR(playerid,"Ova lokacija ne postoji!");
		        if(!IsPlayerInAnyVehicle(playerid))
		        {
					SetPlayerPos(playerid,TeleportInfo[id][tX],TeleportInfo[id][tY],TeleportInfo[id][tZ]);
					SetPlayerFacingAngle(playerid,TeleportInfo[id][tAZ]);
					SetPlayerInterior(playerid,TeleportInfo[id][tInt]);
					SetPlayerVirtualWorld(playerid,TeleportInfo[id][tVW]);
					PlayerInfo[playerid][pUbizzu] = -1;
					PlayerInfo[playerid][pUkuci] = -1;
					PlayerInfo[playerid][pUorg] = -1;
					PlayerInfo[playerid][pUstanu] = -1;
					new str[50+MAX_PLAYER_NAME];
					format(str,sizeof(str),""zuta"Teleportovani ste do "bijela"%s.",TeleportInfo[id][tName]);
					SCM(playerid,-1,str);
					Freeze(playerid);
				}
				else
				{
				    new vehid = GetPlayerVehicleID(playerid);
	  				SetVehiclePos(vehid,TeleportInfo[id][tX],TeleportInfo[id][tY],TeleportInfo[id][tZ]);
					SetVehicleZAngle(vehid,TeleportInfo[id][tAZ]);
					SetPlayerInterior(playerid,TeleportInfo[id][tInt]);
					SetPlayerVirtualWorld(playerid,TeleportInfo[id][tVW]);
					LinkVehicleToInterior(vehid, TeleportInfo[id][tInt]);
					SetVehicleVirtualWorld(vehid, TeleportInfo[id][tVW]);
					PlayerInfo[playerid][pUbizzu] = -1;
					PlayerInfo[playerid][pUkuci] = -1;
					PlayerInfo[playerid][pUorg] = -1;
					PlayerInfo[playerid][pUstanu] = -1;
					new str[50+MAX_PLAYER_NAME];
					format(str,sizeof(str),""zuta"Teleportovani ste do "bijela"%s.",TeleportInfo[id][tName]);
					SCM(playerid,-1,str);
					Freeze(playerid);
				}
		    }
		}
		case DIALOG_PITANJA:
		{
			if(!response) return Pitanja[playerid] = -1;
			if(response)
			{
				new id = listitem;
				if(AskInfo[id][aUse])
				{
					new str[150];
					format(str,sizeof(str),""zuta"Pitanje\n"bijela"%s[%d] ( %s )\n"zuta"Odgovor:",AskInfo[id][aPostavio],AskInfo[id][aPostavioID],AskInfo[id][aPitanje]);
					ShowPlayerDialog(playerid,DIALOG_PITANJA1,DIALOG_STYLE_INPUT,""bijela"Pitanje:",str,""bijela"Posalji",""bijela"Odustani");
					Pitanja[playerid] = id;
				}
				else return Pitanja[playerid] = -1;
			}
		}
		case DIALOG_PITANJA1:
		{
			if(!response) return Pitanja[playerid] = -1;
			if(response)
			{
				new id = Pitanja[playerid];
				if(AskInfo[id][aUse])
				{
					new text[100];
					if(sscanf(inputtext, "s[100]", text)) return 1;
					new str[200];
					if(PlayerInfo[playerid][pAdmin] >= 1)
					{ format(str,sizeof(str),""zuta"Admin %s vam je odgovorio na pitanje!\n"crvena"Odgovor: "bijela"%s.",GetName(playerid),text); }
					else { format(str,sizeof(str),""zuta"GameMaster %s vam je odgovorio na pitanje!\n"crvena"Odgovor: "bijela"%s.",GetName(playerid),text); }
					ShowPlayerDialog(AskInfo[id][aPostavioID],DIALOG_PITANJA2,DIALOG_STYLE_MSGBOX,""plava""IME" - Odgovor:",str,"Ok","");
					format(str,sizeof(str),""zuta"Odgovorili ste igracu "bijela"%s "zuta"( "bijela"%s "zuta")!",AskInfo[id][aPostavio],text);
					SCM(playerid,-1,str);
					AskInfo[id][aUse] = false;
		            strmid(AskInfo[id][aPostavio], "~n~", 0, strlen("~n~"), 24);
	             	strmid(AskInfo[id][aPitanje], "~n~", 0, strlen("~n~"), 50);
	             	AskInfo[id][aPostavioID] = -1;
					Pitanja[playerid] = -1;
				}
				else return ERROR(playerid,"Netko je odgovorio na vase pitanje u meduvremenu!"),Pitanja[playerid] = -1;
			}
		}
		case DIALOG_GPS:
		{
		    if(!response) return 1;
		    if(response)
		    {
		        new id = listitem;
		        new str1[20];
 				format(str1,sizeof(str1),GPATH,id);
				if(!fexist(str1)) return ERROR(playerid,"Ova lokacija ne postoji!");
				SetPlayerCheckpoint(playerid,GpsInfo[id][tX],GpsInfo[id][tY],GpsInfo[id][tZ],3.0);
				new str[100+MAX_PLAYER_NAME];
				format(str,sizeof(str),""zuta"Posatvili ste marker do "bijela"%s.",GpsInfo[id][tName]);
				SCM(playerid,-1,str);
				GPSON[playerid] = true;
		    }
		}
		case DIALOG_BANKA:
		{
		    if(!response) return 1;
		    switch(listitem)
			{
			    case 0:
			    {
			        if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate otvoreni racun u banci!");
			    	new str[120];
			   	 	format(str,sizeof(str),""zelena"Ime: "bijela"%s\n"zelena"Stanje na racunu: "bijela"%d$\n"zelena"Kredit za otplatiti: "bijela"%d$",GetName(playerid),PlayerInfo[playerid][pBankMoney],PlayerInfo[playerid][pKolicinaKredita]);
					ShowPlayerDialog(playerid,DIALOG_BANKA4,DIALOG_STYLE_MSGBOX,""zelena""IME" - Banka:",str,"Ok","");
					return 1;
				}
				case 1:
				{
				    if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate otvoreni racun u banci!");
					new str[120];
					format(str,sizeof(str),""bijela"Upisite koliko novca zelite ostaviti u banci.\n"zelena"Stanje na racunu je "bijela"%d$.",PlayerInfo[playerid][pBankMoney]);
					ShowPlayerDialog(playerid,DIALOG_BANKA3,DIALOG_STYLE_INPUT,""zelena""IME" - Banka:",str,"Ostavi","Odustani");
					return 1;
				}
				case 2:
				{
				    if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate otvoreni racun u banci!");
				    new str[120];
			   		format(str,sizeof(str),""bijela"Upisite koliko novca zelite podignuti.\n"zelena"Stanje na racunu je "bijela"%d$.",PlayerInfo[playerid][pBankMoney]);
					ShowPlayerDialog(playerid,DIALOG_BANKA2,DIALOG_STYLE_INPUT,""zelena""IME" - Banka:",str,"Podigni","Odustani");
					return 1;
				}
				case 3:
				{
				    if(PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Vec imate otvoreni racun u banci!");
					PlayerInfo[playerid][pBankovniRacun] = true;
					//PlayerInfo[playerid][pBankMoney] = 0;
				    INFO(playerid,"Uspjesno ste otvorili bankovni racun i uzeli vasu karticu!");
				    UpdateBankaZlatoTD(playerid);
				    SacuvajIgraca(playerid);
				    return 1;
				}
			}
		    return 1;
		}
		case DIALOG_BANKA2:
		{
			if(!response) return 1;
			if(response)
			{
                if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate otvoreni racun u banci!");
                new str[120];
       			format(str,sizeof(str),""bijela"Upisite koliko novca zelite podignuti.\n"zelena"Stanje na racunu je "bijela"%d$.",PlayerInfo[playerid][pBankMoney]);
				new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_BANKA2,DIALOG_STYLE_INPUT,""zelena""IME" - Banka:",str,"Podigni","Odustani");
				if(money > PlayerInfo[playerid][pBankMoney]) return ShowPlayerDialog(playerid,DIALOG_BANKA2,DIALOG_STYLE_INPUT,""zelena""IME" - Banka:",str,"Podigni","Odustani");
				PlayerInfo[playerid][pBankMoney] -= money;
				GivePlayerMoney(playerid,money);
				PlayerInfo[playerid][pMoney] += money;
				UpdateBankaZlatoTD(playerid);
				INFO(playerid,"Uspjesno ste podignuli novac!");
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_BANKA3:
		{
			if(!response) return 1;
			if(response)
			{
			   	if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate otvoreni racun u banci!");
			    new str[120];
		    	format(str,sizeof(str),""bijela"Upisite koliko novca zelite ostaviti u banci.\n"zelena"Stanje na racunu je "bijela"%d$.",PlayerInfo[playerid][pBankMoney]);
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_BANKA3,DIALOG_STYLE_INPUT,""zelena""IME" - Banka:",str,"Ostavi","Odustani");
				if(money > PlayerInfo[playerid][pMoney]) return ShowPlayerDialog(playerid,DIALOG_BANKA3,DIALOG_STYLE_INPUT,""zelena""IME" - Banka:",str,"Ostavi","Odustani");
				PlayerInfo[playerid][pBankMoney] += money;
			    PlayerInfo[playerid][pMoney] -= money;
				GivePlayerMoney(playerid,-money);
				UpdateBankaZlatoTD(playerid);
				INFO(playerid,"Uspjesno ste ostavili novac u banci!");
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_BANKA5:
  		{
			if(!response) return 1;
			if(response)
			{
			    switch(listitem)
			    {
			        case 0:
			        {
			            if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
					    if(PlayerInfo[playerid][pLevel] < 5) return ERROR(playerid,"Za podizanje ovog kredita potreban vam je level 5!");
					    if(!IsPlayerInRangeOfPoint(playerid,2,653.2974,390.6435,668.6772)) return ERROR(playerid,"Niste na salteru za podizanje kredita!");
					    if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate otvoreni racun u banci!");
					   	if(PlayerInfo[playerid][pImaKredit]) return ERROR(playerid,"Vec otplacujete kredit!");
                        PlayerInfo[playerid][pImaKredit] = true;
                        PlayerInfo[playerid][pKolicinaKredita] = 50000;
                        PlayerInfo[playerid][pBankMoney] += 50000;
                        PlayerInfo[playerid][pRataKredita] = 5000;
                        ClearChat(playerid,20);
                        UpdateBankaZlatoTD(playerid);
                        INFO(playerid,"Uspjesno ste podigli kredit!");
                        INFO(playerid,"Vasih 50000$ je uplaceno na vas racun!");
                        INFO(playerid,"Rata vaseg kredita je 5000$!");
                        INFO(playerid,"Smatrate li da necete moci otplacivati kredit vratite ga sad dok jos nije kasno!");
                        SacuvajIgraca(playerid);
                        new lgg[200];
						format(lgg,sizeof(lgg),"[DIZANJE] | Igraca %s | Kolicina %d | Novo stanje %d |",GetName(playerid), PlayerInfo[playerid][pKolicinaKredita], PlayerInfo[playerid][pBankMoney]);
						Log(KREDIT_LOG,lgg);
						return 1;
					}
					case 1:
			        {
			            if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
					    if(PlayerInfo[playerid][pLevel] < 10) return ERROR(playerid,"Za podizanje ovog kredita potreban vam je level 10!");
					    if(!IsPlayerInRangeOfPoint(playerid,2,653.2974,390.6435,668.6772)) return ERROR(playerid,"Niste na salteru za podizanje kredita!");
					    if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate otvoreni racun u banci!");
					   	if(PlayerInfo[playerid][pImaKredit]) return ERROR(playerid,"Vec otplacujete kredit!");
                        PlayerInfo[playerid][pImaKredit] = true;
                        PlayerInfo[playerid][pKolicinaKredita] = 1000000;
                        PlayerInfo[playerid][pBankMoney] += 1000000;
                        PlayerInfo[playerid][pRataKredita] = 50000;
                        ClearChat(playerid,20);
                        UpdateBankaZlatoTD(playerid);
                        INFO(playerid,"Uspjesno ste podigli kredit!");
                        INFO(playerid,"Vasih 1000000$ je uplaceno na vas racun!");
                        INFO(playerid,"Rata vaseg kredita je 50000$!");
                        INFO(playerid,"Smatrate li da necete moci otplacivati kredit vratite ga sad dok jos nije kasno!");
                        SacuvajIgraca(playerid);
                        new lgg[200];
						format(lgg,sizeof(lgg),"[DIZANJE] | Igraca %s | Kolicina %d | Novo stanje %d |",GetName(playerid), PlayerInfo[playerid][pKolicinaKredita], PlayerInfo[playerid][pBankMoney]);
						Log(KREDIT_LOG,lgg);
						return 1;
					}
					case 2:
			        {
			            if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
					    if(PlayerInfo[playerid][pLevel] < 13) return ERROR(playerid,"Za podizanje ovog kredita potreban vam je level 13!");
					    if(!IsPlayerInRangeOfPoint(playerid,2,653.2974,390.6435,668.6772)) return ERROR(playerid,"Niste na salteru za podizanje kredita!");
					    if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate otvoreni racun u banci!");
					   	if(PlayerInfo[playerid][pImaKredit]) return ERROR(playerid,"Vec otplacujete kredit!");
                        PlayerInfo[playerid][pImaKredit] = true;
                        PlayerInfo[playerid][pKolicinaKredita] = 1500000;
                        PlayerInfo[playerid][pBankMoney] += 1500000;
                        PlayerInfo[playerid][pRataKredita] = 100000;
                        ClearChat(playerid,20);
                        UpdateBankaZlatoTD(playerid);
                        INFO(playerid,"Uspjesno ste podigli kredit!");
                        INFO(playerid,"Vasih 1500000$ je uplaceno na vas racun!");
                        INFO(playerid,"Rata vaseg kredita je 100000$!");
                        INFO(playerid,"Smatrate li da necete moci otplacivati kredit vratite ga sad dok jos nije kasno!");
                        SacuvajIgraca(playerid);
                        new lgg[200];
						format(lgg,sizeof(lgg),"[DIZANJE] | Igraca %s | Kolicina %d | Novo stanje %d |",GetName(playerid), PlayerInfo[playerid][pKolicinaKredita], PlayerInfo[playerid][pBankMoney]);
						Log(KREDIT_LOG,lgg);
						return 1;
					}
					case 3:
			        {
			            if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
					    if(PlayerInfo[playerid][pLevel] < 13) return ERROR(playerid,"Za podizanje ovog kredita potreban vam je level 20!");
					    if(!IsPlayerInRangeOfPoint(playerid,2,653.2974,390.6435,668.6772)) return ERROR(playerid,"Niste na salteru za podizanje kredita!");
					    if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate otvoreni racun u banci!");
					   	if(PlayerInfo[playerid][pImaKredit]) return ERROR(playerid,"Vec otplacujete kredit!");
                        PlayerInfo[playerid][pImaKredit] = true;
                        PlayerInfo[playerid][pKolicinaKredita] = 1500000;
                        PlayerInfo[playerid][pBankMoney] += 1500000;
                        PlayerInfo[playerid][pRataKredita] = 100000;
                        ClearChat(playerid,20);
                        UpdateBankaZlatoTD(playerid);
                        INFO(playerid,"Uspjesno ste podigli kredit!");
                        INFO(playerid,"Vasih 1500000$ je uplaceno na vas racun!");
                        INFO(playerid,"Rata vaseg kredita je 100000$!");
                        INFO(playerid,"Smatrate li da necete moci otplacivati kredit vratite ga sad dok jos nije kasno!");
                        SacuvajIgraca(playerid);
                        new lgg[200];
						format(lgg,sizeof(lgg),"[DIZANJE] | Igraca %s | Kolicina %d | Novo stanje %d |",GetName(playerid), PlayerInfo[playerid][pKolicinaKredita], PlayerInfo[playerid][pBankMoney]);
						Log(KREDIT_LOG,lgg);
						return 1;
					}
					case 4:
			        {
			            if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
					    if(PlayerInfo[playerid][pLevel] < 20) return ERROR(playerid,"Za podizanje ovog kredita potreban vam je level 20!");
					    if(!IsPlayerInRangeOfPoint(playerid,2,653.2974,390.6435,668.6772)) return ERROR(playerid,"Niste na salteru za podizanje kredita!");
					    if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate otvoreni racun u banci!");
					   	if(PlayerInfo[playerid][pImaKredit]) return ERROR(playerid,"Vec otplacujete kredit!");
                        PlayerInfo[playerid][pImaKredit] = true;
                        PlayerInfo[playerid][pKolicinaKredita] = 2200000;
                        PlayerInfo[playerid][pBankMoney] += 2200000;
                        PlayerInfo[playerid][pRataKredita] = 200000;
                        ClearChat(playerid,20);
                        UpdateBankaZlatoTD(playerid);
                        INFO(playerid,"Uspjesno ste podigli kredit!");
                        INFO(playerid,"Vasih 2200000$ je uplaceno na vas racun!");
                        INFO(playerid,"Rata vaseg kredita je 200000$!");
                        INFO(playerid,"Smatrate li da necete moci otplacivati kredit vratite ga sad dok jos nije kasno!");
                        SacuvajIgraca(playerid);
                        new lgg[200];
						format(lgg,sizeof(lgg),"[DIZANJE] | Igraca %s | Kolicina %d | Novo stanje %d |",GetName(playerid), PlayerInfo[playerid][pKolicinaKredita], PlayerInfo[playerid][pBankMoney]);
						Log(KREDIT_LOG,lgg);
						return 1;
					}
				}
			}
			return 1;
		}
		case DIALOG_BANKA6:
		{
			if(!response) return 1;
			if(response)
			{
			    new i = GetBankomatID(playerid);
	           	if(i == -1) return ERROR(playerid,"Niste kod bankomata!");
				new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_BANKA6,DIALOG_STYLE_INPUT,""zelena""IME" - Bankomat:",""bijela"Upisite koliko novca zelite podignuti","Podigni","Odustani");
				if(money > PlayerInfo[playerid][pBankMoney]) return ShowPlayerDialog(playerid,DIALOG_BANKA6,DIALOG_STYLE_INPUT,""zelena""IME" - Bankomat:",""crvena"Upisali ste previse!\n"bijela"Upisite koliko novca zelite podignuti","Podigni","Odustani");
				PlayerInfo[playerid][pBankMoney] -= money;
				GivePlayerMoney(playerid,money);
				PlayerInfo[playerid][pMoney] += money;
				UpdateBankaZlatoTD(playerid);
				INFO(playerid,"Uspjesno ste podignuli novac!");
				SacuvajIgraca(playerid);
				return 1;
			}
		}
		case DIALOG_POSAO:
		{
			if(!response) return 1;
		    if(PosaoID[playerid] == -1) return ERROR(playerid,"Greska sa biranjem posla!");
	     	if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
		    if(PlayerInfo[playerid][pPosao] != -1) return ERROR(playerid,"Vec imate posao!");
		    if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Prvo otvorite racun u banci da mozete primati placu!");
			new id = PosaoID[playerid];
		    if(PlayerInfo[playerid][pLevel] < JobInfo[id][jLevel]) return ERROR(playerid,"Nemate dovoljan level za ovaj posao!");
		    PlayerInfo[playerid][pPosao] = id;
		    PlayerInfo[playerid][pStaz] = 0;
		    SacuvajIgraca(playerid);
			JOB(playerid,"Uspjesno ste se zaposlili!");
			JOB(playerid,"Vise informacija o poslu mozete vidjeti na '"roza"/help"bijela"'!");
		}
		case DIALOG_POSLOVI:
		{
			if(!response) return 1;
			GPSON[playerid] = true;
			SetPlayerCheckpoint(playerid,JobInfo[listitem][jX],JobInfo[listitem][jY],JobInfo[listitem][jZ],2.0);
			new str[150];
			format(str,sizeof(str),"Posao "zuta"%s "bijela"je oznacen na mapi!",JobInfo[listitem][jName]);
			INFO(playerid,str);
		}
		case DIALOG_KUCA:
		{
		    if(!response) return 1;
		    if(response)
		    {
		        if(PlayerInfo[playerid][pKucaID] == -1) return ERROR(playerid,"Nemate kucu!");
		        switch(listitem)
		        {
		        	case 0:
		        	{
					    new id = PlayerInfo[playerid][pKucaID];
						if(KucaInfo[id][kLocked])
						{
					    	KucaInfo[id][kLocked] = false;
					    	GameTextForPlayer(playerid,"~g~Otkljucano!",1000,3);
					    	SacuvajKucu(id);
						}
				 		else if(!KucaInfo[id][kLocked])
				 		{
				   			KucaInfo[id][kLocked] = true;
				    		GameTextForPlayer(playerid,"~r~Zakljucano!",1000,3);
					    	SacuvajKucu(id);
						}
		        	}
		        	case 1:
		        	{
                        new str[250];
					    new novac = KucaInfo[PlayerInfo[playerid][pKucaID]][kPrice]/2;
					    format(str,sizeof(str),""crvena"NAPOMENA: "bijela"Prije prodaje provjerite jeste li uzeli sve stvari iz vase kuce!\n"bijela"Jeste li sigurni da zelite prodati kucu za "zuta"%d$",novac);
					    ShowPlayerDialog(playerid,DIALOG_KUCA7,DIALOG_STYLE_MSGBOX,""zelena""IME" - Kuca:",str,"Prodaj","Odustani");
		        	}
					case 2:
					{
					    new id = PlayerInfo[playerid][pKucaID];
						new str[500],or[24],or1[24],or2[24],str1[700];
						if(KucaInfo[id][kOruzje][0] != -1)
						{ GetWeaponName(KucaInfo[id][kOruzje][0],or,sizeof(or)); format(or,sizeof(or),"%s (%d)",or,KucaInfo[id][kMunicija][0]); }
						else { or = "Nema"; }
				        if(KucaInfo[id][kOruzje][1] != -1) { GetWeaponName(KucaInfo[id][kOruzje][1],or1,sizeof(or1)); format(or1,sizeof(or1),"%s (%d)",or1,KucaInfo[id][kMunicija][1]); }
						else { or1 = "Nema"; }
				        if(KucaInfo[id][kOruzje][2] != -1) { GetWeaponName(KucaInfo[id][kOruzje][2],or2,sizeof(or2)); format(or2,sizeof(or2),"%s (%d)",or2,KucaInfo[id][kMunicija][2]);}
						else { or2 = "Nema"; }
						format(str,sizeof(str),""zelena"Vlasnik: "bijela"%s\n"zelena"Ime: "bijela"%s\n"zelena"Level: "bijela"%d\n"zelena"Cijena: "bijela"%d$\n"zelena"Novac: "bijela"%d$\n"zelena"Oruzje 1: "bijela"%s\n"zelena"Oruzje 2: "bijela"%s\n"zelena"Oruzje 3: "bijela"%s\n",KucaInfo[id][kOwnerName],KucaInfo[id][kName],KucaInfo[id][kLevel],KucaInfo[id][kPrice],KucaInfo[id][kMoney],or,or1,or2);
						strcat(str1,str);
						format(str,sizeof(str),""zelena"Droga: "bijela"%dg\n"zelena"Mats: "bijela"%dg\n",KucaInfo[id][kDroga],KucaInfo[id][kMats]);
						strcat(str1,str);
						ShowPlayerDialog(playerid,DIALOG_KUCA2,DIALOG_STYLE_MSGBOX,""zelena""IME" - Kuca:",str1,"Ok","");
					}
					case 3:
					{
	    				ShowPlayerDialog(playerid,DIALOG_KUCA5,DIALOG_STYLE_INPUT,""zelena""IME"- Kuca:",""bijela"Upiste novo ime kuce!","Promijeni","Odustani");
					}
					case 4:
					{
					    ShowPlayerDialog(playerid,DIALOG_KUCA6,DIALOG_STYLE_LIST,""zelena""IME"- Kuca:",""bijela"Uzmi novac\n"zelena"Ostavi novac\n"bijela"Uzmi oruzje\n"zelena"Ostavi oruzje\n"bijela"Uzmi oruzje 2\n"zelena"Ostavi oruzje 2\n"bijela"Uzmi oruzje 3\n"zelena"Ostavi oruzje 3\n"bijela"Uzmi drogu\n"zelena"Ostavi drogu\n"bijela"Uzmi mats\n"zelena"Ostavi mats","Dalje","Odustani");
					}
				}
				return 1;
		    }
		    return 1;
		}
        case DIALOG_KUCA6:
		{
		    if(!response) return 1;
		    if(response)
			{
				if(PlayerInfo[playerid][pKucaID] == -1) return ERROR(playerid,"Nemate kucu!");
				new id = PlayerInfo[playerid][pKucaID];
				switch(listitem)
				{
	                case 0:
					{
	        			ShowPlayerDialog(playerid,DIALOG_KUCA3,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""bijela"Upisite koliko novca zelite uzeti!","Uzmi","Odustani");
					}
					case 1:
					{
	        			ShowPlayerDialog(playerid,DIALOG_KUCA4,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""bijela"Upisite koliko novca zelite ostaviti u kuci!","Ostavi","Odustani");
					}
					case 2:
					{
					    new slot = 0;
					    if(KucaInfo[id][kOruzje][slot] == -1) return ERROR(playerid,"Nemate oruzje na tom slotu!");
						GivePlayerWeapon(playerid,KucaInfo[id][kOruzje][slot],KucaInfo[id][kMunicija][slot]);
						KucaInfo[id][kOruzje][slot] = -1;
						KucaInfo[id][kMunicija][slot] = 0;
						SacuvajIgraca(playerid);
						SacuvajKucu(id);
						INFO(playerid,"Uspjesno ste uzeli oruzje iz kuce!");
					}
					case 3:
					{
					    new slot = 0;
					    if(KucaInfo[id][kOruzje][slot] != -1) return ERROR(playerid,"Slot za oruzje je popunjen!");
						if(GetPlayerWeapon(playerid) <= 0) return ERROR(playerid,"Nemate oruzje!");
						KucaInfo[id][kOruzje][slot] = GetPlayerWeapon(playerid);
						KucaInfo[id][kMunicija][slot] = GetPlayerAmmo(playerid);
						SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
						SacuvajIgraca(playerid);
						SacuvajKucu(id);
						INFO(playerid,"Uspjesno ste ostavili oruzje u kuci!");
					}
					case 4:
					{
					    new slot = 1;
					    if(KucaInfo[id][kOruzje][slot] == -1) return ERROR(playerid,"Nemate oruzje na tom slotu!");
						GivePlayerWeapon(playerid,KucaInfo[id][kOruzje][slot],KucaInfo[id][kMunicija][slot]);
						KucaInfo[id][kOruzje][slot] = -1;
						KucaInfo[id][kMunicija][slot] = 0;
						SacuvajKucu(id);
						SacuvajIgraca(playerid);
						INFO(playerid,"Uspjesno ste uzeli oruzje iz kuce!");
					}
					case 5:
					{
					    new slot = 1;
					    if(KucaInfo[id][kOruzje][slot] != -1) return ERROR(playerid,"Slot za oruzje je popunjen!");
						if(GetPlayerWeapon(playerid) <= 0) return ERROR(playerid,"Nemate oruzje!");
						KucaInfo[id][kOruzje][slot] = GetPlayerWeapon(playerid);
						KucaInfo[id][kMunicija][slot] = GetPlayerAmmo(playerid);
						SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
						SacuvajKucu(id);
						INFO(playerid,"Uspjesno ste ostavili oruzje u kuci!");
					}
					case 6:
					{
					    new slot = 2;
					    if(KucaInfo[id][kOruzje][slot] == -1) return ERROR(playerid,"Nemate oruzje na tom slotu!");
						GivePlayerWeapon(playerid,KucaInfo[id][kOruzje][slot],KucaInfo[id][kMunicija][slot]);
						KucaInfo[id][kOruzje][slot] = -1;
						KucaInfo[id][kMunicija][slot] = 0;
						SacuvajKucu(id);
						SacuvajIgraca(playerid);
						INFO(playerid,"Uspjesno ste uzeli oruzje iz kuce!");
					}
					case 7:
					{
					    new slot = 2;
					    if(KucaInfo[id][kOruzje][slot] != -1) return ERROR(playerid,"Slot za oruzje je popunjen!");
						if(GetPlayerWeapon(playerid) <= 0) return ERROR(playerid,"Nemate oruzje!");
						KucaInfo[id][kOruzje][slot] = GetPlayerWeapon(playerid);
						KucaInfo[id][kMunicija][slot] = GetPlayerAmmo(playerid);
						SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
						SacuvajKucu(id);
						INFO(playerid,"Uspjesno ste ostavili oruzje u kuci!");
					}
					case 8:
					{
                        ShowPlayerDialog(playerid,DIALOG_KUCA8,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""bijela"Upisite koliko droge zelite uzeti!","Uzmi","Odustani");
					}
					case 9:
					{
					    ShowPlayerDialog(playerid,DIALOG_KUCA9,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""bijela"Upisite koliko droge zelite ostaviti u kuci!","Ostavi","Odustani");
					}
					case 10:
					{
                        ShowPlayerDialog(playerid,DIALOG_KUCA10,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""bijela"Upisite koliko matsa zelite uzeti!","Uzmi","Odustani");
					}
					case 11:
					{
					    ShowPlayerDialog(playerid,DIALOG_KUCA11,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""bijela"Upisite koliko matsa zelite ostaviti u kuci!","Ostavi","Odustani");
					}
				}
			}
		}
		case DIALOG_KUCA3:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pKucaID] == -1) return ERROR(playerid,"Nemate kucu!");
			    new id = PlayerInfo[playerid][pKucaID];
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_KUCA3,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""bijela"Upiste koliko novca zelite uzeti!","Uzmi","Odustani");
				if(money > KucaInfo[id][kMoney]) return ShowPlayerDialog(playerid,DIALOG_KUCA3,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""crvena"Upisali ste previse!\n"bijela"Upisite koliko novca zelite uzeti!","Uzmi","Odustani");
				KucaInfo[id][kMoney] -= money;
				GivePlayerMoney(playerid,money);
				PlayerInfo[playerid][pMoney] += money;
				INFO(playerid,"Uspjesno ste uzeli novac!");
				SacuvajKucu(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_KUCA4:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pKucaID] == -1) return ERROR(playerid,"Nemate kucu!");
			    new id = PlayerInfo[playerid][pKucaID];
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_KUCA4,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""bijela"Upisite koliko novca zelite ostaviti u kuci!","Ostavi","Odustani");
				if(money > PlayerInfo[playerid][pMoney]) return ShowPlayerDialog(playerid,DIALOG_KUCA4,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""crvena"Nemate toliko novca!\n"bijela"Upisite koliko novca zelite ostaviti u kuci!","Ostavi","Odustani");
				KucaInfo[id][kMoney] += money;
				GivePlayerMoney(playerid,-money);
				PlayerInfo[playerid][pMoney] -= money;
				INFO(playerid,"Uspjesno ste ostavili novac u kuci!");
				SacuvajKucu(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_KUCA5:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pKucaID] == -1) return ERROR(playerid,"Nemate kucu!");
			    new id = PlayerInfo[playerid][pKucaID];
				new text[24];
			    if(sscanf(inputtext,"s[24]",text)) return ShowPlayerDialog(playerid,DIALOG_KUCA5,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""bijela"Upisite novo ime kuce!","Promijeni","Odustani");
				strmid(KucaInfo[id][kName], text, 0, strlen(text), MAX_PLAYER_NAME);
				KucaLP(id);
				SacuvajKucu(id);
				SacuvajIgraca(playerid);
				INFO(playerid,"Uspjesno ste promijenili ime kuce!");
			}
			return 1;
		}
		case DIALOG_KUCA7:
		{
		    if(!response) return 1;
		    if(PlayerInfo[playerid][pKucaID] == -1) return ERROR(playerid,"Nemate kucu!");
		    new id = PlayerInfo[playerid][pKucaID];
			KucaInfo[id][kOwned] = false;
			strmid(KucaInfo[id][kOwnerName], "Drzava", 0, strlen("Drzava"), MAX_PLAYER_NAME);
			KucaLP(id);
			KucaInfo[id][kLocked] = true;
			new novac = KucaInfo[id][kPrice]-1500;
			GivePlayerMoney(playerid,novac);
			PlayerInfo[playerid][pMoney] += novac;
			PlayerInfo[playerid][pKucaID] = -1;
			SacuvajKucu(id);
			SacuvajIgraca(playerid);
			INFO(playerid,"Uspjesno ste prodali kucu drzavi.");
		}
		case DIALOG_KUCA8:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pKucaID] == -1) return ERROR(playerid,"Nemate kucu!");
			    new id = PlayerInfo[playerid][pKucaID];
			    new kol = strval(inputtext);
			    if(kol < 1) return ShowPlayerDialog(playerid,DIALOG_KUCA8,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""bijela"Upiste koliko droge zelite uzeti!","Uzmi","Odustani");
				if(kol > KucaInfo[id][kDroga]) return ShowPlayerDialog(playerid,DIALOG_KUCA8,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""crvena"Upisali ste previse!\n"bijela"Upiste koliko droge zelite uzeti!","Uzmi","Odustani");
				KucaInfo[id][kDroga] -= kol;
				PlayerInfo[playerid][pDroga] += kol;
				INFO(playerid,"Uspjesno ste uzeli drogu!");
				SacuvajKucu(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_KUCA9:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pKucaID] == -1) return ERROR(playerid,"Nemate kucu!");
			    new id = PlayerInfo[playerid][pKucaID];
			    new kol = strval(inputtext);
			    if(kol < 1) return ShowPlayerDialog(playerid,DIALOG_KUCA9,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""bijela"Upiste koliko droge zelite ostaviti u kuci!","Ostavi","Odustani");
				if(kol > PlayerInfo[playerid][pDroga]) return ShowPlayerDialog(playerid,DIALOG_KUCA9,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""crvena"Nemate toliko droge!\n"bijela"Upiste koliko droge zelite ostaviti u kuci!","Ostavi","Odustani");
				KucaInfo[id][kDroga] += kol;
				PlayerInfo[playerid][pDroga] -= kol;
				INFO(playerid,"Uspjesno ste ostavili drogu u kuci!");
				SacuvajKucu(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_KUCA10:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pKucaID] == -1) return ERROR(playerid,"Nemate kucu!");
			    new id = PlayerInfo[playerid][pKucaID];
			    new kol = strval(inputtext);
			    if(kol < 1) return ShowPlayerDialog(playerid,DIALOG_KUCA8,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""bijela"Upiste koliko matsa zelite uzeti!","Uzmi","Odustani");
				if(kol > KucaInfo[id][kMats]) return ShowPlayerDialog(playerid,DIALOG_KUCA8,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""crvena"Upisali ste previse!\n"bijela"Upiste koliko matsa zelite uzeti!","Uzmi","Odustani");
				KucaInfo[id][kMats] -= kol;
				PlayerInfo[playerid][pMats] += kol;
				INFO(playerid,"Uspjesno ste uzeli mats!");
				SacuvajKucu(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_KUCA11:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pKucaID] == -1) return ERROR(playerid,"Nemate kucu!");
			    new id = PlayerInfo[playerid][pKucaID];
			    new kol = strval(inputtext);
			    if(kol < 1) return ShowPlayerDialog(playerid,DIALOG_KUCA9,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""bijela"Upiste koliko matsa zelite ostaviti u kuci!","Ostavi","Odustani");
				if(kol > PlayerInfo[playerid][pMats]) return ShowPlayerDialog(playerid,DIALOG_KUCA9,DIALOG_STYLE_INPUT,""zelena""IME" - Kuca:",""crvena"Nemate toliko matsa!\n"bijela"Upisite koliko matsa zelite ostaviti u kuci!","Ostavi","Odustani");
				KucaInfo[id][kMats] += kol;
				PlayerInfo[playerid][pMats] -= kol;
				INFO(playerid,"Uspjesno ste ostavili mats u kuci!");
				SacuvajKucu(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_PLACANJE:
		{
		    if(response)
		    {
		        if(!PlayerInfo[playerid][pBankovniRacun]) return ShowPlayerDialog(playerid,DIALOG_PLACANJE,DIALOG_STYLE_MSGBOX,""siva""IME" - Placanje",""bijela"Izaberite nacin placanja:\n"zuta"'ENTER'"bijela" za placanje bankovnom karticom.\n"zuta"'ESC'"bijela" za pljacanje gotovinom.","Karticom","Gotovinom");
			    if(PlayerInfo[playerid][pBankMoney] < PlacanjeInfo[playerid][pPrice]) return ShowPlayerDialog(playerid,DIALOG_PLACANJE,DIALOG_STYLE_MSGBOX,""siva""IME" - Placanje",""bijela"Izaberite nacin placanja:\n"zuta"'ENTER'"bijela" za placanje bankovnom karticom.\n"zuta"'ESC'"bijela" za pljacanje gotovinom.","Karticom","Gotovinom");
				if(PlacanjeInfo[playerid][pBiznisID] != -1)
				{
					BiznisNovac(PlacanjeInfo[playerid][pBiznisID],PlacanjeInfo[playerid][pPrice]);
				}
				PlayerInfo[playerid][pBankMoney] -= PlacanjeInfo[playerid][pPrice];
				PlacanjeInfo[playerid][pBiznisID] = -1;
				PlacanjeInfo[playerid][pPrice] = 0;
				UpdateBankaZlatoTD(playerid);
		    }
		    else
		    {
                if(GetPlayerMoney(playerid) < PlacanjeInfo[playerid][pPrice]) return ShowPlayerDialog(playerid,DIALOG_PLACANJE,DIALOG_STYLE_MSGBOX,""siva""IME" - Placanje",""bijela"Izaberite nacin placanja:\n"zuta"'ENTER'"bijela" za placanje bankovnom karticom.\n"zuta"'ESC'"bijela" za pljacanje gotovinom.","Karticom","Gotovinom");
                if(PlacanjeInfo[playerid][pBiznisID] != -1)
				{
					BiznisNovac(PlacanjeInfo[playerid][pBiznisID],PlacanjeInfo[playerid][pPrice]);
				}
				GivePlayerMoney(playerid,-PlacanjeInfo[playerid][pPrice]);
				PlayerInfo[playerid][pMoney] -= PlacanjeInfo[playerid][pPrice];
				PlacanjeInfo[playerid][pBiznisID] = -1;
 				PlacanjeInfo[playerid][pPrice] = 0;
 				UpdateBankaZlatoTD(playerid);
			}
		    return 1;
		}
		case DIALOG_SHOP:
		{
		    if(!response) return 1;
			if(PlayerInfo[playerid][pUbizzu] == -1) return 1;
			new id = listitem;
			if(GetPlayerMoney(playerid) >= ShopInfo[id][sPrice] || PlayerInfo[playerid][pBankMoney] >= ShopInfo[id][sPrice] )
			{
				Placanje(playerid,PlayerInfo[playerid][pUbizzu],ShopInfo[id][sPrice]);
			}
			else return ERROR(playerid,"Nemate dovoljno novca!");
			new str[60];
			format(str,sizeof(str),"je kupio %s.",ShopInfo[id][sName]);
			Aktivnost(playerid,str);
			if(id == 0)
			{
			    PlayerInfo[playerid][pMobitel] = true;
			    PlayerInfo[playerid][pMobitelUkljucen] = false;
			    PlayerInfo[playerid][pMobilniKredit] = 50;
			    SacuvajIgraca(playerid);
			}
			else if(id == 1)
			{
			    PlayerInfo[playerid][pUpaljac] += 1;
			    SacuvajIgraca(playerid);
			}
            else if(id == 2)
			{
			    PlayerInfo[playerid][pCigarete] += 5;
			    SacuvajIgraca(playerid);
			}
			else if(id == 3)
			{
			    PlayerInfo[playerid][pMobilniKredit] += 100;
			    SacuvajIgraca(playerid);
			}
			else if(id == 4)
			{
            	if(PlayerInfo[playerid][pUze] <= 0) { PlayerInfo[playerid][pUze] = 1; } else { PlayerInfo[playerid][pUze]++; }
			    SacuvajIgraca(playerid);
			}
			else if(id == 5)
			{
			    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
			}
			else if(id == 6)
			{
			    GivePlayerWeapon(playerid,14,1);
			    SacuvajIgraca(playerid);
			}
			else if(id == 7)
			{
   				if(PlayerInfo[playerid][pMarama] <= 0) { PlayerInfo[playerid][pMarama] = 1; } else { PlayerInfo[playerid][pMarama]++; }
   				SacuvajIgraca(playerid);
			}
		    return 1;
		}
		case DIALOG_SEX_SHOP:
		{
			if(!response) return 1;
			if(PlayerInfo[playerid][pUbizzu] == -1) return 1;
            switch(listitem)
			{
				case 0:
				{
					if(GetPlayerMoney(playerid) >= 100 || PlayerInfo[playerid][pBankMoney] >= 100)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],100);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					GivePlayerWeapon(playerid, 13, 1);
					SacuvajIgraca(playerid);
				    Aktivnost(playerid,"je kupio sivi vibrator.");
				}
				case 1:
				{
					if(GetPlayerMoney(playerid) >= 110 || PlayerInfo[playerid][pBankMoney] >= 110)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],11);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					GivePlayerWeapon(playerid, 11, 1);
					SacuvajIgraca(playerid);
				    Aktivnost(playerid,"je kupio bijeli vibrator.");
				}
				case 2:
				{
					if(GetPlayerMoney(playerid) >= 150 || PlayerInfo[playerid][pBankMoney] >= 150)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],15);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					GivePlayerWeapon(playerid, 10, 1);
					SacuvajIgraca(playerid);
				    Aktivnost(playerid,"je kupio ljubicasti vibrator.");
				}
			}
		}
		case DIALOG_AMMUNATION:
		{
		    if(!response) return 1;
		    if(PlayerInfo[playerid][pUbizzu] == -1) return 1;
			switch(listitem)
			{
			    case 0:
				{
				    if(GetPlayerMoney(playerid) >= 100 || PlayerInfo[playerid][pBankMoney] >= 100)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],100);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					GivePlayerWeapon(playerid,4,1);
					SacuvajIgraca(playerid);
					Aktivnost(playerid,"je kupio Knife.");
				}
				case 1:
				{
				    if(GetPlayerMoney(playerid) >= 300 || PlayerInfo[playerid][pBankMoney] >= 300)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],300);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					GivePlayerWeapon(playerid,5,1);
					SacuvajIgraca(playerid);
					Aktivnost(playerid,"je kupio Baseball bat.");
				}
				case 2:
				{
				    if(GetPlayerMoney(playerid) >= 40000 || PlayerInfo[playerid][pBankMoney] >= 40000)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],40000);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					GivePlayerWeapon(playerid,25,50);
					SacuvajIgraca(playerid);
					Aktivnost(playerid,"je kupio Shootgun.");
				}
				case 3:
				{
				    if(GetPlayerMoney(playerid) >= 20000 || PlayerInfo[playerid][pBankMoney] >= 20000)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],20000);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					GivePlayerWeapon(playerid,24,25);
					SacuvajIgraca(playerid);
					Aktivnost(playerid,"je kupio Desert Eagle.");
				}
				case 4:
				{
				    if(GetPlayerMoney(playerid) >= 50000 || PlayerInfo[playerid][pBankMoney] >= 50000)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],50000);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					GivePlayerWeapon(playerid,31,50);
					SacuvajIgraca(playerid);
					Aktivnost(playerid,"je kupio M4.");
				}
				case 5:
				{
				    if(GetPlayerMoney(playerid) >= 100000 || PlayerInfo[playerid][pBankMoney] >= 100000)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],100000);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					GivePlayerWeapon(playerid,34,15);
					SacuvajIgraca(playerid);
					Aktivnost(playerid,"je kupio Sniper.");
				}
				case 6:
				{
				    if(GetPlayerMoney(playerid) >= 500 || PlayerInfo[playerid][pBankMoney] >= 500)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],500);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					GivePlayerWeapon(playerid,46,1);
					SacuvajIgraca(playerid);
					Aktivnost(playerid,"je kupio Padobran.");
				}
			}
			return 1;
		}
		case DIALOG_BINCO:
		{
		    if(!response) return 1;
		    if(PlayerInfo[playerid][pUbizzu] == -1) return 1;
		    new id = listitem;
		    if(GetPlayerMoney(playerid) >= SkinInfo[id][sPrice] || PlayerInfo[playerid][pBankMoney] >= SkinInfo[id][sPrice])
			{
				Placanje(playerid,PlayerInfo[playerid][pUbizzu],SkinInfo[id][sPrice]);
			}
			else return ERROR(playerid,"Nemate dovoljno novca!");
			if(PlayerInfo[playerid][pOrgID] != -1)
			{
			    if(PlayerInfo[playerid][pRank] == 1) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin1]); }
				else if(PlayerInfo[playerid][pRank] == 2) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin2]);  }
		        else if(PlayerInfo[playerid][pRank] == 3) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin3]);  }
		        else if(PlayerInfo[playerid][pRank] == 4) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin4]);  }
		        else if(PlayerInfo[playerid][pRank] == 5) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin5]);  }
		        else if(PlayerInfo[playerid][pRank] == 6) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin6]);  }
			}
			else
			{
				SetPlayerSkin(playerid,SkinInfo[id][sID]);
			}
			PlayerInfo[playerid][pSkin] = SkinInfo[id][sID];
		    return 1;
		}
		case DIALOG_BAR:
		{
			if(!response) return 1;
            switch(listitem)
			{
				case 0:
				{
					if(GetPlayerMoney(playerid) >= 100 || PlayerInfo[playerid][pBankMoney] >= 100)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],100);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					Aktivnost(playerid,"pije pivo.");
				    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
				    new Float:hp;
				    GetPlayerHealth(playerid,hp);
				    new Float:hpp;
				    if(hp+5 > 99.0) { hpp = 99.0; } else { hpp = hp+5; }
					SetPlayerHealth(playerid,hpp);
				}
				case 1:
				{
					if(GetPlayerMoney(playerid) >= 150 || PlayerInfo[playerid][pBankMoney] >= 150)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],150);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					Aktivnost(playerid,"pije vino.");
				    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
				    new Float:hp;
				    GetPlayerHealth(playerid,hp);
				    new Float:hpp;
				    if(hp+10 > 99.0) { hpp = 99.0; } else { hpp = hp+10; }
					SetPlayerHealth(playerid,hpp);
				}
				case 2:
				{
					if(GetPlayerMoney(playerid) >= 300 || PlayerInfo[playerid][pBankMoney] >= 300)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],300);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					Aktivnost(playerid,"pije viski.");
				    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
				    new Float:hp;
				    GetPlayerHealth(playerid,hp);
				    new Float:hpp;
				    if(hp+15 > 99.0) { hpp = 99.0; } else { hpp = hp+15; }
					SetPlayerHealth(playerid,hpp);
				}
				case 3:
				{
					if(GetPlayerMoney(playerid) >= 250 || PlayerInfo[playerid][pBankMoney] >= 250)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],250);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					Aktivnost(playerid,"pije votku.");
				    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
				    new Float:hp;
				    GetPlayerHealth(playerid,hp);
				    new Float:hpp;
				    if(hp+14 > 99.0) { hpp = 99.0; } else { hpp = hp+14; }
					SetPlayerHealth(playerid,hpp);
				}
				case 4:
				{
					Aktivnost(playerid,"pije vodu.");
				    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
				    new Float:hp;
				    GetPlayerHealth(playerid,hp);
				    new Float:hpp;
				    if(hp+3 > 99.0) { hpp = 99.0; } else { hpp = hp+3; }
					SetPlayerHealth(playerid,hpp);
				}
				case 5:
				{
					if(GetPlayerMoney(playerid) >= 20 || PlayerInfo[playerid][pBankMoney] >= 20)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],20);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					Aktivnost(playerid,"pije sok.");
				    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_SPRUNK);
				    new Float:hp;
				    GetPlayerHealth(playerid,hp);
				    new Float:hpp;
				    if(hp+4 > 99.0) { hpp = 99.0; } else { hpp = hp+4; }
					SetPlayerHealth(playerid,hpp);
				}
			}
			return 1;
		}
		case DIALOG_PIZZA:
		{
		    if(!response) return 1;
		    switch(listitem)
			{
				case 0:
				{
					if(GetPlayerMoney(playerid) >= 50 || PlayerInfo[playerid][pBankMoney] >= 50)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],50);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					Aktivnost(playerid,"jede hamburger.");
                    ApplyAnimation(playerid, "VENDING", "vend_eat1_P", 4.1, 0, 1, 1, 1, 3000, 1);
				    new Float:hp;
				    GetPlayerHealth(playerid,hp);
				    new Float:hpp;
				    if(hp+70 > 99.0) { hpp = 99.0; } else { hpp = hp+70; }
					SetPlayerHealth(playerid,hpp);
				}
				case 1:
				{
					if(GetPlayerMoney(playerid) >= 100 || PlayerInfo[playerid][pBankMoney] >= 100)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],100);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					Aktivnost(playerid,"jede pizzu.");
                    ApplyAnimation(playerid, "VENDING", "vend_eat1_P", 4.1, 0, 1, 1, 1, 3000, 1);
				    new Float:hp;
				    GetPlayerHealth(playerid,hp);
				    new Float:hpp;
				    if(hp+80 > 99.0) { hpp = 99.0; } else { hpp = hp+80; }
					SetPlayerHealth(playerid,hpp);
				}
				case 2:
				{
					if(GetPlayerMoney(playerid) >= 40 || PlayerInfo[playerid][pBankMoney] >= 40)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],40);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					Aktivnost(playerid,"jede sendvic.");
                    ApplyAnimation(playerid, "VENDING", "vend_eat1_P", 4.1, 0, 1, 1, 1, 3000, 1);
				    new Float:hp;
				    GetPlayerHealth(playerid,hp);
				    new Float:hpp;
				    if(hp+60 > 99.0) { hpp = 99.0; } else { hpp = hp+60; }
					SetPlayerHealth(playerid,hpp);
				}
				case 3:
				{
					if(GetPlayerMoney(playerid) >= 100 || PlayerInfo[playerid][pBankMoney] >= 100)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],100);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					Aktivnost(playerid,"jede pohanu piletinu.");
                    ApplyAnimation(playerid, "VENDING", "vend_eat1_P", 4.1, 0, 1, 1, 1, 3000, 1);
				    new Float:hp;
				    GetPlayerHealth(playerid,hp);
				    new Float:hpp;
				    if(hp+90 > 99.0) { hpp = 99.0; } else { hpp = hp+90; }
					SetPlayerHealth(playerid,hpp);
				}
				case 4:
				{
					if(GetPlayerMoney(playerid) >= 120 || PlayerInfo[playerid][pBankMoney] >= 120)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],120);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					Aktivnost(playerid,"jede svinjetinu.");
                    ApplyAnimation(playerid, "VENDING", "vend_eat1_P", 4.1, 0, 1, 1, 1, 3000, 1);
				    new Float:hp;
				    GetPlayerHealth(playerid,hp);
				    new Float:hpp;
				    if(hp+92 > 99.0) { hpp = 99.0; } else { hpp = hp+92; }
					SetPlayerHealth(playerid,hpp);
				}
				case 5:
				{
					if(GetPlayerMoney(playerid) >= 150 || PlayerInfo[playerid][pBankMoney] >= 150)
					{
						Placanje(playerid,PlayerInfo[playerid][pUbizzu],150);
					}
					else return ERROR(playerid,"Nemate dovoljno novca!");
					Aktivnost(playerid,"jede janjetinu.");
                    ApplyAnimation(playerid, "VENDING", "vend_eat1_P", 4.1, 0, 1, 1, 1, 3000, 1);
				    new Float:hp;
				    GetPlayerHealth(playerid,hp);
				    new Float:hpp;
				    if(hp+98 > 99.0) { hpp = 99.0; } else { hpp = hp+98; }
					SetPlayerHealth(playerid,hpp);
				}
			}
			return 1;
		}
		case DIALOG_VKUPOVINA:
		{
		    if(!response) return 1;
		    if(listitem == 0)
		    {
		        if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate bankovni racun!");
	            if(PlayerInfo[playerid][pBankMoney] < KatalogInfo[katalogid[playerid]][kPrice]) return ERROR(playerid,"Nemate dovoljno novca na bankovnom racunu!");
	            ktype[playerid] = 1;
	            ShowPlayerDialog(playerid,DIALOG_VKUPOVINA1,DIALOG_STYLE_LIST,""plava""IME" - Boja vozila:",""bijela"Bijela\n"plava"Plava\n"crna"Crna\n"crvena"Crvena\n"zelena"Zelena\n"zuta"Zuta","Izaberi","Odustani");
			}
		    else if(listitem == 1)
		    {
		        if(PlayerInfo[playerid][pMoney] < KatalogInfo[katalogid[playerid]][kPrice]) return ERROR(playerid,"Nemate dovoljno novca kod sebe!");
	            ktype[playerid] = 2;
	            ShowPlayerDialog(playerid,DIALOG_VKUPOVINA1,DIALOG_STYLE_LIST,""plava""IME" - Boja vozila:",""bijela"Bijela\n"plava"Plava\n"crna"Crna\n"crvena"Crvena\n"zelena"Zelena\n"zuta"Zuta","Izaberi","Odustani");
			}
			return 1;
		}
		case DIALOG_VKUPOVINA1:
		{
		    if(!response) return 1;
		    new slot = -1;
		    for(new i=0;i<MAX_SLOTS;i++) { if(PlayerInfo[playerid][pVozilo][i] == -1) { slot = i; break; } }
		    if(slot == -1) return ERROR(playerid,"Imate popunjena sva tri slota za vozila!");
		    new id = -1;
			for(new i=0;i<MAX_VOZILA;i++)
			{
		        new vFile[50];
		        format(vFile, sizeof(vFile), VPATH, i);
		        if(!fexist(vFile))
		        {
		            id=i;
		            break;
		        }
			}
			if(id == -1) return ERROR(playerid,"Server je presao limit osobnih vozila!");
		    if(ktype[playerid] == 1)
		    {
		        if(!PlayerInfo[playerid][pBankovniRacun]) return ERROR(playerid,"Nemate bankovni racun!");
		        if(PlayerInfo[playerid][pBankMoney] < KatalogInfo[katalogid[playerid]][kPrice]) return ERROR(playerid,"Nemate dovoljno novca na bankovnom racunu!");
		        PlayerInfo[playerid][pBankMoney] -= KatalogInfo[katalogid[playerid]][kPrice];
		        UpdateBankaZlatoTD(playerid);
			}
			else
			{
			    if(PlayerInfo[playerid][pMoney] < KatalogInfo[katalogid[playerid]][kPrice]) return ERROR(playerid,"Nemate dovoljno novca kod sebe!");
				GivePlayerMoney(playerid,-KatalogInfo[katalogid[playerid]][kPrice]);
				PlayerInfo[playerid][pMoney] -= KatalogInfo[katalogid[playerid]][kPrice];
			}
		    new boja;
		    switch(listitem)
		    {
		        case 0: boja = 1;
		        case 1: boja = 2;
		        case 2: boja = 0;
		        case 3: boja = 3;
		        case 4: boja = 128;
		        case 5: boja = 6;
		    }
			VoziloInfo[id][vModel] = KatalogInfo[katalogid[playerid]][kID];
			VoziloInfo[id][vPrice] = KatalogInfo[katalogid[playerid]][kPrice];
			VoziloInfo[id][vBoja1] = boja; VoziloInfo[id][vBoja2] = boja;
			VoziloInfo[id][vOwned] = true; VoziloInfo[id][vLocked] = 1;
   			VoziloInfo[id][vOruzje][0] = -1; VoziloInfo[id][vOruzje][1] = -1;
    		VoziloInfo[id][vOruzje][2] = -1; VoziloInfo[id][vMunicija][0] = 0;
    		VoziloInfo[id][vMunicija][1] = 0; VoziloInfo[id][vMunicija][2] = 0;
    		VoziloInfo[id][vDroga] = 0; VoziloInfo[id][vMats] = 0;
    		VoziloInfo[id][vMoney] = 0; VoziloInfo[id][vPaintJob] = -1;
			new Float:x,Float:y,Float:z,Float:az;
			if(VoziloJeAvion(VoziloInfo[id][vModel]))
			{
			    new p = random(sizeof(RandomKupovinaSpawnAvioni));
				x = RandomKupovinaSpawnAvioni[p][0];
				y = RandomKupovinaSpawnAvioni[p][1];
				z = RandomKupovinaSpawnAvioni[p][2];
				az = RandomKupovinaSpawnAvioni[p][3];
			}
			else if(VoziloJeBrod(VoziloInfo[id][vModel]))
			{
			    new p = random(sizeof(RandomKupovinaSpawnBrodovi));
				x = RandomKupovinaSpawnBrodovi[p][0];
				y = RandomKupovinaSpawnBrodovi[p][1];
				z = RandomKupovinaSpawnBrodovi[p][2];
				az = RandomKupovinaSpawnBrodovi[p][3];
			}
			else
			{
				new p = random(sizeof(RandomKupovinaSpawn));
				x = RandomKupovinaSpawn[p][0];
				y = RandomKupovinaSpawn[p][1];
				z = RandomKupovinaSpawn[p][2];
				az = RandomKupovinaSpawn[p][3];
			}
			VoziloInfo[id][vX] = x;
			VoziloInfo[id][vY] = y;
			VoziloInfo[id][vZ] = z;
			VoziloInfo[id][vAZ] = az;
			VoziloInfo[id][vID] = CreateVehicle(VoziloInfo[id][vModel],VoziloInfo[id][vX],VoziloInfo[id][vY],VoziloInfo[id][vZ],VoziloInfo[id][vAZ],VoziloInfo[id][vBoja1],VoziloInfo[id][vBoja2],30000);
            SetGorivo(VoziloInfo[id][vID]);
			strmid(VoziloInfo[id][vOwnerName], GetName(playerid), 0, strlen(GetName(playerid)), 60); SacuvajVozilo(id);
		    VoziloInfo[id][vVW] = 0;
			SetVehicleVirtualWorld(VoziloInfo[id][vID],VoziloInfo[id][vVW]);
		    Locked[VoziloInfo[id][vID]] = VoziloInfo[id][vLocked];
			GPSON[playerid] = true;
			SetPlayerCheckpoint(playerid,x,y,z,5.0);
			SacuvajVozilo(id);
			PlayerInfo[playerid][pVozilo][slot] = id;
			SacuvajIgraca(playerid);
			ClearChat(playerid);
			INFO(playerid,"Cestitamo na kupovini vaseg novog vozila!");
			INFO(playerid,"Za upravljanje vozila koristite "zuta"'/v'"bijela".");
			INFO(playerid,"Vase vozilo je oznaceno crvenim na mapi.");
			return 1;
		}
		case DIALOG_GEPEK:
		{
		    if(!response) return 1;
		    if(response)
			{
				new Float:vx,Float:vy,Float:vz;
			    new id2 = -1;
				for(new i=0;i<MAX_VEHICLES;i++)
				{
				    GetPosBehindVehicle(i, vx, vy, vz);
				    if(IsPlayerInRangeOfPoint(playerid,3.0,vx,vy,vz))
				    {
				        id2 = i;
				        break;
				    }
				}
				if(id2 == -1) return ERROR(playerid,"Niste kod gepeka niti jednog vozila!");
                if(!IsTrunkOpened(id2)) return ERROR(playerid,"Vozilo ima zatvoren gepek!");
				new id = -1;
				for(new i=0;i<MAX_VOZILA;i++)
				{
					if(VoziloInfo[i][vID] == id2)
					{
					    id = i;
					    break;
					}
				}
				if(id == -1) return ERROR(playerid,"Ovo nije osobno vozilo!");
			    if(!VoziloInfo[id][vOwned]) return ERROR(playerid,"Nemozete uzimat stvari iz vozila koje se prodaje!");
				switch(listitem)
				{
	                case 0:
					{
	        			ShowPlayerDialog(playerid,DIALOG_GEPEK1,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""bijela"Upisite koliko novca zelite uzeti!","Uzmi","Odustani");
					}
					case 1:
					{
	        			ShowPlayerDialog(playerid,DIALOG_GEPEK2,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""bijela"Upisite koliko novca zelite ostaviti u gepeku!","Ostavi","Odustani");
					}
					case 2:
					{
					    new slot = 0;
					    if(VoziloInfo[id][vOruzje][slot] == -1) return ERROR(playerid,"Nemate oruzje na tom slotu!");
						GivePlayerWeapon(playerid,VoziloInfo[id][vOruzje][slot],VoziloInfo[id][vMunicija][slot]);
						VoziloInfo[id][vOruzje][slot] = -1;
						VoziloInfo[id][vMunicija][slot] = 0;
						SacuvajVozilo(id);
						SacuvajIgraca(playerid);
						INFO(playerid,"Uspjesno ste uzeli ruzje iz vozila!");
					}
					case 3:
					{
					    new slot = 0;
					    if(VoziloInfo[id][vOruzje][slot] != -1) return ERROR(playerid,"Slot za oruzje je popunjen!");
						if(GetPlayerWeapon(playerid) <= 0) return ERROR(playerid,"Nemate oruzje!");
						VoziloInfo[id][vOruzje][slot] = GetPlayerWeapon(playerid);
						VoziloInfo[id][vMunicija][slot] = GetPlayerAmmo(playerid);
						SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
						SacuvajVozilo(id);
						INFO(playerid,"Uspjesno ste ostavili oruzje u gepeku!");
					}
					case 4:
					{
					    new slot = 1;
					    if(VoziloInfo[id][vOruzje][slot] == -1) return ERROR(playerid,"Nemate oruzje na tom slotu!");
						GivePlayerWeapon(playerid,VoziloInfo[id][vOruzje][slot],VoziloInfo[id][vMunicija][slot]);
						VoziloInfo[id][vOruzje][slot] = -1;
						VoziloInfo[id][vMunicija][slot] = 0;
						SacuvajVozilo(id);
						SacuvajIgraca(playerid);
						INFO(playerid,"Uspjesno ste uzeli oruzje iz vozila!");
					}
					case 5:
					{
					    new slot = 1;
					    if(VoziloInfo[id][vOruzje][slot] != -1) return ERROR(playerid,"Slot za oruzje je popunjn!");
						if(GetPlayerWeapon(playerid) <= 0) return ERROR(playerid,"Nemate Oruzje!");
						VoziloInfo[id][vOruzje][slot] = GetPlayerWeapon(playerid);
						VoziloInfo[id][vMunicija][slot] = GetPlayerAmmo(playerid);
						SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
						SacuvajVozilo(id);
						INFO(playerid,"Uspjesno ste ostavili oruzje u gepeku!");
					}
					case 6:
					{
					    new slot = 2;
					    if(VoziloInfo[id][vOruzje][slot] == -1) return ERROR(playerid,"Nemate oruzje na tom slotu!");
						GivePlayerWeapon(playerid,VoziloInfo[id][vOruzje][slot],VoziloInfo[id][vMunicija][slot]);
						VoziloInfo[id][vOruzje][slot] = -1;
						VoziloInfo[id][vMunicija][slot] = 0;
						SacuvajVozilo(id);
						SacuvajIgraca(playerid);
						INFO(playerid,"Uspjesno ste uzeli oruzje iz vozila!");
					}
					case 7:
					{
					    new slot = 2;
					    if(VoziloInfo[id][vOruzje][slot] != -1) return ERROR(playerid,"Slot za oruzje je popunjen!");
						if(GetPlayerWeapon(playerid) <= 0) return ERROR(playerid,"Nemate Oruzje!");
						VoziloInfo[id][vOruzje][slot] = GetPlayerWeapon(playerid);
						VoziloInfo[id][vMunicija][slot] = GetPlayerAmmo(playerid);
						SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
						SacuvajVozilo(id);
						INFO(playerid,"Uspjesno ste ostavili oruzje u gepeku!");
					}
					case 8:
					{
                        ShowPlayerDialog(playerid,DIALOG_GEPEK3,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""bijela"Upisite koliko droge zelite uzeti!","Uzmi","Odustani");
					}
					case 9:
					{
					    ShowPlayerDialog(playerid,DIALOG_GEPEK4,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""bijela"Upisite koliko droge zelite ostaviti u gepeku!","Ostavi","Odustani");
					}
					case 10:
					{
                        ShowPlayerDialog(playerid,DIALOG_GEPEK5,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""bijela"Upisite koliko matsa zelite uzeti!","Uzmi","Odustani");
					}
					case 11:
					{
					    ShowPlayerDialog(playerid,DIALOG_GEPEK6,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""bijela"Upisite koliko matsa zelite ostaviti u gepeku!","Ostavi","Odustani");
					}
					case 12:
					{
						new str[500],or[24],or1[24],or2[24],str1[700];
						if(VoziloInfo[id][vOruzje][0] != -1)
						{ GetWeaponName(VoziloInfo[id][vOruzje][0],or,sizeof(or)); format(or,sizeof(or),"%s (%d)",or,VoziloInfo[id][vMunicija][0]); }
						else { or = "Nema"; }
				        if(VoziloInfo[id][vOruzje][1] != -1) { GetWeaponName(VoziloInfo[id][vOruzje][1],or1,sizeof(or1)); format(or1,sizeof(or1),"%s (%d)",or1,VoziloInfo[id][vMunicija][1]); }
						else { or1 = "Nema"; }
				        if(VoziloInfo[id][vOruzje][2] != -1) { GetWeaponName(VoziloInfo[id][vOruzje][2],or2,sizeof(or2)); format(or2,sizeof(or2),"%s (%d)",or2,VoziloInfo[id][vMunicija][2]);}
						else { or2 = "Nema"; }
						format(str,sizeof(str),""plava"Novac: "bijela"%d$\n"plava"Oruzje 1: "bijela"%s\n"plava"Oruzje 2: "bijela"%s\n"plava"Oruzje 3: "bijela"%s\n",VoziloInfo[id][vMoney],or,or1,or2);
						strcat(str1,str);
						format(str,sizeof(str),""plava"Droga: "bijela"%dg\n"plava"Mats: "bijela"%dg\n",VoziloInfo[id][vDroga],VoziloInfo[id][vMats]);
						strcat(str1,str);
						ShowPlayerDialog(playerid,DIALOG_GEPEK7,DIALOG_STYLE_MSGBOX,""plava""IME" - Gepek:",str1,"Ok","");
					}
				}
			}
		}
		case DIALOG_GEPEK1:
		{
			if(!response) return 1;
			if(response)
			{
			    new Float:vx,Float:vy,Float:vz;
			    new id2 = -1;
				for(new i=0;i<MAX_VEHICLES;i++)
				{
				    GetPosBehindVehicle(i, vx, vy, vz);
				    if(IsPlayerInRangeOfPoint(playerid,3.0,vx,vy,vz))
				    {
				        id2 = i;
				        break;
				    }
				}
				if(id2 == -1) return ERROR(playerid,"Niste kod gepeka niti jednog vozila!");
                if(!IsTrunkOpened(id2)) return ERROR(playerid,"Vozilo ima zatvoren gepek!");
				new id = -1;
				for(new i=0;i<MAX_VOZILA;i++)
				{
					if(VoziloInfo[i][vID] == id2)
					{
					    id = i;
					    break;
					}
				}
				if(id == -1) return ERROR(playerid,"Ovo nije osobno vozilo!");
			    if(!VoziloInfo[id][vOwned]) return ERROR(playerid,"Nemozete uzimati stvari iz vozila koje se prodaje!");
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_GEPEK1,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""bijela"Upisite koliko novca zelite uzeti!","Uzmi","Odustani");
				if(money > VoziloInfo[id][vMoney]) return ShowPlayerDialog(playerid,DIALOG_GEPEK1,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""crvena"Upisali ste previse!\n"bijela"Upisite koliko novca zelite uzeti!","Uzmi","Odustani");
				VoziloInfo[id][vMoney] -= money;
				GivePlayerMoney(playerid,money);
				PlayerInfo[playerid][pMoney] += money;
				INFO(playerid,"Uspjesno ste uzeli novac!");
				SacuvajVozilo(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_GEPEK2:
		{
			if(!response) return 1;
			if(response)
			{
			    new Float:vx,Float:vy,Float:vz;
			    new id2 = -1;
				for(new i=0;i<MAX_VEHICLES;i++)
				{
				    GetPosBehindVehicle(i, vx, vy, vz);
				    if(IsPlayerInRangeOfPoint(playerid,3.0,vx,vy,vz))
				    {
				        id2 = i;
				        break;
				    }
				}
				if(id2 == -1) return ERROR(playerid,"Niste kod gepeka niti jednog vozila!");
                if(!IsTrunkOpened(id2)) return ERROR(playerid,"Vozilo ima zatvoren gepek!");
				new id = -1;
				for(new i=0;i<MAX_VOZILA;i++)
				{
					if(VoziloInfo[i][vID] == id2)
					{
					    id = i;
					    break;
					}
				}
				if(id == -1) return ERROR(playerid,"Ovo nije osobno vozilo!");
			    if(!VoziloInfo[id][vOwned]) return ERROR(playerid,"Nemozete uzimati stvari iz vozila koje se prodaje!");
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_GEPEK2,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""bijela"Upiste koliko novca zelite ostaviti u gepeku!","Ostavi","Odustani");
				if(money > PlayerInfo[playerid][pMoney]) return ShowPlayerDialog(playerid,DIALOG_GEPEK2,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""crvena"Nemate toliko novca kod sebe!\n"bijela"Upisite koliko novca zelite ostaviti u gepeku!","Ostavi","Odustani");
				VoziloInfo[id][vMoney] += money;
				GivePlayerMoney(playerid,-money);
				PlayerInfo[playerid][pMoney] -= money;
				INFO(playerid,"Uspjesno ste ostavili novac u vozilu!");
				SacuvajVozilo(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_GEPEK3:
		{
			if(!response) return 1;
			if(response)
			{
			    new Float:vx,Float:vy,Float:vz;
			    new id2 = -1;
				for(new i=0;i<MAX_VEHICLES;i++)
				{
				    GetPosBehindVehicle(i, vx, vy, vz);
				    if(IsPlayerInRangeOfPoint(playerid,3.0,vx,vy,vz))
				    {
				        id2 = i;
				        break;
				    }
				}
				if(id2 == -1) return ERROR(playerid,"Niste kod gepeka niti jednog vozila!");
                if(!IsTrunkOpened(id2)) return ERROR(playerid,"Vozilo ima zatvoren gepek!");
				new id = -1;
				for(new i=0;i<MAX_VOZILA;i++)
				{
					if(VoziloInfo[i][vID] == id2)
					{
					    id = i;
					    break;
					}
				}
				if(id == -1) return ERROR(playerid,"Ovo nije osobno vozilo!");
			    if(!VoziloInfo[id][vOwned]) return ERROR(playerid,"Nemozete uzimati stvari iz vozila koje se prodaje!");
			    new kol = strval(inputtext);
			    if(kol < 1) return ShowPlayerDialog(playerid,DIALOG_GEPEK3,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""bijela"Upisite koliko droge zelite uzeti!","Uzmi","Odustani");
				if(kol > VoziloInfo[id][vDroga]) return ShowPlayerDialog(playerid,DIALOG_GEPEK3,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""crvena"Upisali ste previse!\n"bijela"Upisite koliko droge zelite uzeti!","Uzmi","Odustani");
				VoziloInfo[id][vDroga] -= kol;
				PlayerInfo[playerid][pDroga] += kol;
				INFO(playerid,"Uspjesno ste uzeli drogu!");
				SacuvajVozilo(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_GEPEK4:
		{
			if(!response) return 1;
			if(response)
			{
			    new Float:vx,Float:vy,Float:vz;
			    new id2 = -1;
				for(new i=0;i<MAX_VEHICLES;i++)
				{
				    GetPosBehindVehicle(i, vx, vy, vz);
				    if(IsPlayerInRangeOfPoint(playerid,3.0,vx,vy,vz))
				    {
				        id2 = i;
				        break;
				    }
				}
				if(id2 == -1) return ERROR(playerid,"Niste kod gepeka niti jednog vozila!");
                if(!IsTrunkOpened(id2)) return ERROR(playerid,"Vozilo ima zatvoren gepek!");
				new id = -1;
				for(new i=0;i<MAX_VOZILA;i++)
				{
					if(VoziloInfo[i][vID] == id2)
					{
					    id = i;
					    break;
					}
				}
				if(id == -1) return ERROR(playerid,"Ovo nije osobno vozilo!");
			    if(!VoziloInfo[id][vOwned]) return ERROR(playerid,"Nemozete uzimati stvari iz vozila koje se prodaje!");
			    new kol = strval(inputtext);
			    if(kol < 1) return ShowPlayerDialog(playerid,DIALOG_GEPEK4,DIALOG_STYLE_INPUT,""plava""IME"- Gepek:",""bijela"Upisite koliko droge zelite ostaviti u gepeku!","Ostavi","Odustani");
				if(kol > PlayerInfo[playerid][pDroga]) return ShowPlayerDialog(playerid,DIALOG_GEPEK4,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""crvena"Nemate toliko droge u gepeku!\n"bijela"Upisite koliko droge zelite ostaviti u gepeku!","Ostavi","Odustani");
				VoziloInfo[id][vDroga] += kol;
				PlayerInfo[playerid][pDroga] -= kol;
    			ERROR(playerid,"Uspjesno ste ostavili drogu u vozilu!");
				SacuvajVozilo(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_GEPEK5:
		{
			if(!response) return 1;
			if(response)
			{
                new Float:vx,Float:vy,Float:vz;
			    new id2 = -1;
				for(new i=0;i<MAX_VEHICLES;i++)
				{
				    GetPosBehindVehicle(i, vx, vy, vz);
				    if(IsPlayerInRangeOfPoint(playerid,3.0,vx,vy,vz))
				    {
				        id2 = i;
				        break;
				    }
				}
				if(id2 == -1) return ERROR(playerid,"Niste kod gepeka niti jednog vozila!");
                if(!IsTrunkOpened(id2)) return ERROR(playerid,"Vozilo ima zatvoren gepek!");
				new id = -1;
				for(new i=0;i<MAX_VOZILA;i++)
				{
					if(VoziloInfo[i][vID] == id2)
					{
					    id = i;
					    break;
					}
				}
				if(id == -1) return ERROR(playerid,"Ovo nije osobno vozilo!");
			    if(!VoziloInfo[id][vOwned]) return ERROR(playerid,"Nemozete uzimati stvari iz vozila koje se prodaje!");
			    new kol = strval(inputtext);
			    if(kol < 1) return ShowPlayerDialog(playerid,DIALOG_GEPEK5,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""bijela"Upisite koliko matsa zelite uzeti!","Uzmi","Odustani");
				if(kol > VoziloInfo[id][vMats]) return ShowPlayerDialog(playerid,DIALOG_GEPEK5,DIALOG_STYLE_INPUT,""plava""IME "- Gepek:",""crvena"Upisali ste previse!\n"bijela"Upisite koliko matsa zelite uzeti!","Uzmi","Odustani");
				VoziloInfo[id][vMats] -= kol;
				PlayerInfo[playerid][pMats] += kol;
				INFO(playerid,"Uspjesno ste uzeli mats!");
				SacuvajVozilo(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_GEPEK6:
		{
			if(!response) return 1;
			if(response)
			{
			    new Float:vx,Float:vy,Float:vz;
			    new id2 = -1;
				for(new i=0;i<MAX_VEHICLES;i++)
				{
				    GetPosBehindVehicle(i, vx, vy, vz);
				    if(IsPlayerInRangeOfPoint(playerid,3.0,vx,vy,vz))
				    {
				        id2 = i;
				        break;
				    }
				}
				if(id2 == -1) return ERROR(playerid,"Niste kod gepeka niti jednog vozila!");
                if(!IsTrunkOpened(id2)) return ERROR(playerid,"Vozilo ima zatvoren gepek!");
				new id = -1;
				for(new i=0;i<MAX_VOZILA;i++)
				{
					if(VoziloInfo[i][vID] == id2)
					{
					    id = i;
					    break;
					}
				}
				if(id == -1) return ERROR(playerid,"Ovo nije osobno vozilo!");
			    if(!VoziloInfo[id][vOwned]) return ERROR(playerid,"Nemozete uzimati stvari iz vozila koje se prodaje!");
			    new kol = strval(inputtext);
			    if(kol < 1) return ShowPlayerDialog(playerid,DIALOG_GEPEK6,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""bijela"Upisite koliko matsa zelite ostaviti u gepeku!","Ostavi","Odustani");
				if(kol > PlayerInfo[playerid][pMats]) return ShowPlayerDialog(playerid,DIALOG_GEPEK6,DIALOG_STYLE_INPUT,""plava""IME" - Gepek:",""crvena"Nemate toliko matsa!\n"bijela"Upisite koliko matsa zelite ostaviti u gepeku!","Ostavi","Odustani");
				VoziloInfo[id][vMats] += kol;
				PlayerInfo[playerid][pMats] -= kol;
				INFO(playerid,"Uspjesno ste ostavili mats u vozilu!");
				SacuvajVozilo(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_SELLCARTO:
		{
		    if(!response)
		    {
		        Ponudio[playerid] = INVALID_PLAYER_ID; Slot[playerid] = -1; Cijena[playerid] = 0;
		    }
		    if(response)
		    {
		        if(!strcmp(inputtext,"PRIHVATI",true))
		        {
					if(PlayerInfo[playerid][pMoney] < Cijena[playerid])
					{
					    Ponudio[playerid] = INVALID_PLAYER_ID; Slot[playerid] = -1; Cijena[playerid] = 0;
					    ERROR(playerid,"Nemate dovoljno novca!");
						return 1;
					}
					new pslot = -1;
					for(new i=0;i<MAX_SLOTS;i++)
					{
					    if(PlayerInfo[playerid][pVozilo][i] == -1) { pslot = i;  break; }
					}
					if(pslot == -1)
					{
					    Ponudio[playerid] = INVALID_PLAYER_ID; Slot[playerid] = -1; Cijena[playerid] = 0;
					    ERROR(playerid,"Nemate dostupan slot!");
						return 1;
					}
					if(PlayerInfo[Ponudio[playerid]][pVozilo][Slot[playerid]] == -1)
					{
					    Ponudio[playerid] = INVALID_PLAYER_ID; Slot[playerid] = -1; Cijena[playerid] = 0;
					    ERROR(playerid,"Igrac je vec prodao vozilo!");
						return 1;
					}
					PlayerInfo[playerid][pVozilo][pslot] = PlayerInfo[Ponudio[playerid]][pVozilo][Slot[playerid]];
					PlayerInfo[Ponudio[playerid]][pVozilo][Slot[playerid]] = -1;
					strmid(VoziloInfo[PlayerInfo[playerid][pVozilo][pslot]][vOwnerName], GetName(playerid), 0, strlen(GetName(playerid)), 60);
					SacuvajVozilo(PlayerInfo[playerid][pVozilo][pslot]);
					INFO(Ponudio[playerid],"Uspjesno ste prodali vozilo!");
					ClearChat(playerid);
					INFO(playerid,"Uspjesno ste kupili vozilo!");
					INFO(playerid,"Za upravljanje vozilo koristite "zuta"'/v'"bijela".");
					GivePlayerMoney(playerid,-Cijena[playerid]);
					PlayerInfo[playerid][pMoney] -= Cijena[playerid];
					GivePlayerMoney(Ponudio[playerid],Cijena[playerid]);
					PlayerInfo[Ponudio[playerid]][pMoney] += Cijena[playerid];
					RemovePlayerFromVehicle(Ponudio[playerid]);
					Ponudio[playerid] = INVALID_PLAYER_ID; Slot[playerid] = -1; Cijena[playerid] = 0;
		        }
		        else
		        {
		            Ponudio[playerid] = INVALID_PLAYER_ID; Slot[playerid] = -1; Cijena[playerid] = 0;
		            INFO(playerid,"Niste prihvatili ponudu!");
		            return 1;
		        }
		    }
			return 1;
		}
		case DIALOG_VSELL:
		{
		    if(!response) return vsell[playerid] = -1;
		    if(IsPlayerInRangeOfPoint(playerid, 10.0, -2053.2981,-109.8786,35.2944))
		    {
			    if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u vozilu!"), vsell[playerid] = -1;
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ERROR(playerid,"Niste na mjestu vozaca!"), vsell[playerid] = -1;
			    new slot = vsell[playerid];
			    new id = PlayerInfo[playerid][pVozilo][slot];
			    if(GetPlayerVehicleID(playerid) != VoziloInfo[id][vID]) return ERROR(playerid,"Niste u svom vozilu!"), vsell[playerid] = -1;
	      		new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				VoziloInfo[id][vOwned] = false; VoziloInfo[id][vLocked] = 0;
				Locked[VoziloInfo[id][vID]] = VoziloInfo[id][vLocked];
				new poz = random(sizeof(RandomSajamSpawn));
				VoziloInfo[id][vX] = RandomSajamSpawn[poz][0];
				VoziloInfo[id][vY] = RandomSajamSpawn[poz][1];
				VoziloInfo[id][vZ] = RandomSajamSpawn[poz][2];
				VoziloInfo[id][vAZ] = RandomSajamSpawn[poz][3];
				DestroyVehicle(VoziloInfo[id][vID]);
			 	VoziloInfo[id][vID] = CreateVehicle(VoziloInfo[id][vModel],VoziloInfo[id][vX],VoziloInfo[id][vY],VoziloInfo[id][vZ],VoziloInfo[id][vAZ],VoziloInfo[id][vBoja1],VoziloInfo[id][vBoja2],30000);
	            SetGorivo(VoziloInfo[id][vID]);
				strmid(VoziloInfo[id][vOwnerName], "Drzava", 0, strlen("Drzava"), 60); SacuvajVozilo(id);
				VoziloInfo[id][vVW] = 0;
				SetVehicleVirtualWorld(VoziloInfo[id][vID],VoziloInfo[id][vVW]);
				new str[120];
				new price;
				price = VoziloInfo[id][vPrice]/2;
				format(str,sizeof(str),""zuta"[%s]\n"zelena"Vozilo na prodaju!\n"zelena"Cijena: %d$",GetVehicleName(VoziloInfo[id][vID]),price);
				vehtxt[VoziloInfo[id][vID]] = Create3DTextLabel(str, -1, 0.0, 0.0, 0.0, 50.0, VoziloInfo[id][vVW], 0 );
				Attach3DTextLabelToVehicle(vehtxt[VoziloInfo[id][vID]], VoziloInfo[id][vID], 0.0, 0.0, 0.0);
				SetPlayerPos(playerid,x,y,z+5);
				GivePlayerMoney(playerid,price);
				PlayerInfo[playerid][pMoney] += price;
				SacuvajVozilo(id);
				ModVehicle(VoziloInfo[id][vID]);
				if(VoziloInfo[id][vPaintJob] != -1)
            	{
					ChangeVehiclePaintjob(VoziloInfo[id][vID], VoziloInfo[id][vPaintJob]);
				}
				PlayerInfo[playerid][pVozilo][slot] = -1;
				SacuvajIgraca(playerid);
				vsell[playerid] = -1;
			}
			else if(IsPlayerInRangeOfPoint(playerid, 10.0, 2958.9890,-2055.5378,-0.0533))
			{
			    if(!VoziloJeBrod(GetVehicleModel(GetPlayerVehicleID(playerid)))) return ERROR(playerid,"Niste u brodu!");
			    if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u vozilu!"), vsell[playerid] = -1;
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ERROR(playerid,"Niste na mjestu vozaca!"), vsell[playerid] = -1;
			    new slot = vsell[playerid];
			    new id = PlayerInfo[playerid][pVozilo][slot];
			    if(GetPlayerVehicleID(playerid) != VoziloInfo[id][vID]) return ERROR(playerid,"Niste u svom vozilu!"), vsell[playerid] = -1;
	      		new Float:x,Float:y,Float:z;
				GetPlayerPos(playerid,x,y,z);
				VoziloInfo[id][vOwned] = false; VoziloInfo[id][vLocked] = 0;
				Locked[VoziloInfo[id][vID]] = VoziloInfo[id][vLocked];
				DestroyVehicle(VoziloInfo[id][vID]);
				strmid(VoziloInfo[id][vOwnerName], "Drzava", 0, strlen("Drzava"), 60); SacuvajVozilo(id);
				VoziloInfo[id][vVW] = 0;
				new str[40];
				new price;
				price = VoziloInfo[id][vPrice]/2;
				format(str,sizeof(str),VPATH,id);
				fremove(str);
				SetPlayerPos(playerid,x,y,z+5);
				GivePlayerMoney(playerid,price);
				PlayerInfo[playerid][pMoney] += price;
				PlayerInfo[playerid][pVozilo][slot] = -1;
				SacuvajIgraca(playerid);
				vsell[playerid] = -1;
			}
			else return ERROR(playerid,"Niste na sajmu!"), vsell[playerid] = -1;
			return 1;
		}
		case DIALOG_UBACI:
		{
		    if(!response)
		    {
		    	PozvanUOrg[playerid] = false;
				IdOrgPozvan[playerid] = -1;
				INFO(playerid,"Odbili ste poziv u organizaciju!");
				return 1;
			}
			if(response)
			{
				if(PlayerInfo[playerid][pOrgID] != -1) return ERROR(playerid,"Vec ste u organizaciji!");
				PlayerInfo[playerid][pOrgID] = IdOrgPozvan[playerid];
				PlayerInfo[playerid][pRank] = 1;
                if(PlayerInfo[playerid][pOrgID] != -1)
				{
				    if(PlayerInfo[playerid][pRank] == 1) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin1]); }
					else if(PlayerInfo[playerid][pRank] == 2) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin2]);  }
			        else if(PlayerInfo[playerid][pRank] == 3) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin3]);  }
			        else if(PlayerInfo[playerid][pRank] == 4) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin4]);  }
			        else if(PlayerInfo[playerid][pRank] == 5) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin5]);  }
			        else if(PlayerInfo[playerid][pRank] == 6) { SetPlayerSkin(playerid,OrgInfo[PlayerInfo[playerid][pOrgID]][oRankSkin6]);  }
				}
				PozvanUOrg[playerid] = false;
				IdOrgPozvan[playerid] = -1;
				new str[100];
				format(str,sizeof(str),""bijela"Igrac %s se pridruzio organizaciji!",GetName(playerid));
				SendOrgMessage(playerid,str);
				OrgInfo2[PlayerInfo[playerid][pOrgID]][oClanovi]++;
				SacuvajOrganizaciju(PlayerInfo[playerid][pOrgID]);
			}
			return 1;
		}
		case DIALOG_SEF:
		{
		    if(!response) return 1;
		    if(response)
			{
   				if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
				if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Nisite u niti jednoj organizaciji!");
				new id = PlayerInfo[playerid][pOrgID];
				if(PlayerInfo[playerid][pRank] >= 5 || PlayerInfo[playerid][pAdmin] >= 6)
				{
					if(!OrgInfo[id][oSef]) return ERROR(playerid,"Vasa organizacija nema sef!");
					if(!IsPlayerInRangeOfPoint(playerid,2.0,OrgInfo[id][oSefX],OrgInfo[id][oSefY],OrgInfo[id][oSefZ])) return ERROR(playerid,"Niste kod sefa!");
				}
				else return 1;
				switch(listitem)
				{
	                case 0:
					{
	        			ShowPlayerDialog(playerid,DIALOG_SEF1,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""bijela"Upisite koliko novca zelite uzeti!","Uzmi","Odustani");
					}
					case 1:
					{
	        			ShowPlayerDialog(playerid,DIALOG_SEF2,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""bijela"Upisite koliko novca zelite ostaviti u sefu!","Ostavi","Odustani");
					}
					case 2:
					{
                        ShowPlayerDialog(playerid,DIALOG_SEF3,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""bijela"Upisite koliko droge zelite uzeti!","Uzmi","Odustani");
					}
					case 3:
					{
					    ShowPlayerDialog(playerid,DIALOG_SEF4,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""bijela"Upisite koliko droge zelite ostaviti u sefu!","Ostavi","Odustani");
					}
					case 4:
					{
                        ShowPlayerDialog(playerid,DIALOG_SEF5,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""bijela"Upisite koliko matsa zelite uzeti!","Uzmi","Odustani");
					}
					case 5:
					{
					    ShowPlayerDialog(playerid,DIALOG_SEF6,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""bijela"Upisite koliko matsa zelite ostaviti u sefu!","Ostavi","Odustani");
					}
					case 6:
					{
						new str[500],str1[700];
						format(str,sizeof(str),""smeda"Novac: "bijela"%d$\n",OrgInfo2[id][oMoney]);
						strcat(str1,str);
						format(str,sizeof(str),""smeda"Droga: "bijela"%dg\n"smeda"Mats: "bijela"%dg\n",OrgInfo2[id][oDroga],OrgInfo2[id][oMats]);
						strcat(str1,str);
						format(str,sizeof(str),""smeda"Clanovi: "bijela"%d\n",OrgInfo2[id][oClanovi]);
						strcat(str1,str);
						ShowPlayerDialog(playerid,DIALOG_SEF7,DIALOG_STYLE_MSGBOX,""smeda""IME" - Sef:",str1,"Ok","");
					}
				}
			}
		}
		case DIALOG_SEF1:
		{
			if(!response) return 1;
			if(response)
			{
                if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
				if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Nisite u niti jednoj organizaciji!");
				new id = PlayerInfo[playerid][pOrgID];
				if(PlayerInfo[playerid][pRank] >= 5 || PlayerInfo[playerid][pAdmin] >= 6)
				{
					if(!OrgInfo[id][oSef]) return ERROR(playerid,"Vasa organizacija nema sef!");
					if(!IsPlayerInRangeOfPoint(playerid,2.0,OrgInfo[id][oSefX],OrgInfo[id][oSefY],OrgInfo[id][oSefZ])) return ERROR(playerid,"Niste kod sefa!");
				}
				else return 1;
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_SEF1,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""bijela"Upisite koliko novca zelite uzeti!","Uzmi","Odustani");
				if(money > OrgInfo2[id][oMoney]) return ShowPlayerDialog(playerid,DIALOG_SEF1,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""crvena"Upisali ste previse!\n"bijela"Upisite koliko novca zelite uzeti!","Uzmi","Odustani");
				OrgInfo2[id][oMoney] -= money;
				GivePlayerMoney(playerid,money);
				PlayerInfo[playerid][pMoney] += money;
				INFO(playerid,"Uspjesno ste uzeli novac!");
				SacuvajOrganizaciju(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_SEF2:
		{
			if(!response) return 1;
			if(response)
			{
                if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
				if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Nisite u niti jednoj organizaciji!");
				new id = PlayerInfo[playerid][pOrgID];
				if(PlayerInfo[playerid][pRank] >= 5 || PlayerInfo[playerid][pAdmin] >= 6)
				{
					if(!OrgInfo[id][oSef]) return ERROR(playerid,"Vasa organizacija nema sef!");
					if(!IsPlayerInRangeOfPoint(playerid,2.0,OrgInfo[id][oSefX],OrgInfo[id][oSefY],OrgInfo[id][oSefZ])) return ERROR(playerid,"Niste kod sefa!");
				}
				else return 1;
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_SEF2,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""bijela"Upisite koliko novca zelite ostaviti u sefu!","Uzmi","Odustani");
				if(money > GetPlayerMoney(playerid)) return ShowPlayerDialog(playerid,DIALOG_SEF2,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""crvena"Upisali ste previse!\n"bijela"Upisite koliko novca zelite ostaviti u sefu!","Uzmi","Odustani");
				OrgInfo2[id][oMoney] += money;
				GivePlayerMoney(playerid,-money);
				PlayerInfo[playerid][pMoney] -= money;
				INFO(playerid,"Uspjesno ste ostavili novac!");
				SacuvajOrganizaciju(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_SEF3:
		{
			if(!response) return 1;
			if(response)
			{
                if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
				if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Nisite u niti jednoj organizaciji!");
				new id = PlayerInfo[playerid][pOrgID];
				if(PlayerInfo[playerid][pRank] >= 5 || PlayerInfo[playerid][pAdmin] >= 6)
				{
					if(!OrgInfo[id][oSef]) return ERROR(playerid,"Vasa organizacija nema sef!");
					if(!IsPlayerInRangeOfPoint(playerid,2.0,OrgInfo[id][oSefX],OrgInfo[id][oSefY],OrgInfo[id][oSefZ])) return ERROR(playerid,"Niste kod sefa!");
				}
				else return 1;
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_SEF3,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""bijela"Upisite koliko droge zelite uzeti!","Uzmi","Odustani");
				if(money > OrgInfo2[id][oDroga]) return ShowPlayerDialog(playerid,DIALOG_SEF3,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""crvena"Upisali ste previse!\n"bijela"Upisite koliko droge zelite uzeti!","Uzmi","Odustani");
				OrgInfo2[id][oDroga] -= money;
				PlayerInfo[playerid][pDroga] += money;
				INFO(playerid,"Uspjesno ste uzeli drogu!");
				SacuvajOrganizaciju(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_SEF4:
		{
			if(!response) return 1;
			if(response)
			{
                if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
				if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Nisite u niti jednoj organizaciji!");
				new id = PlayerInfo[playerid][pOrgID];
				if(PlayerInfo[playerid][pRank] >= 5 || PlayerInfo[playerid][pAdmin] >= 6)
				{
					if(!OrgInfo[id][oSef]) return ERROR(playerid,"Vasa organizacija nema sef!");
					if(!IsPlayerInRangeOfPoint(playerid,2.0,OrgInfo[id][oSefX],OrgInfo[id][oSefY],OrgInfo[id][oSefZ])) return ERROR(playerid,"Niste kod sefa!");
				}
				else return 1;
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_SEF4,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""bijela"Upisite koliko droge zelite ostaviti u sefu!","Uzmi","Odustani");
				if(money > PlayerInfo[playerid][pDroga]) return ShowPlayerDialog(playerid,DIALOG_SEF4,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""crvena"Upisali ste previse!\n"bijela"Upisite koliko droge zelite ostaviti u sefu!","Uzmi","Odustani");
				OrgInfo2[id][oDroga] += money;
				PlayerInfo[playerid][pDroga] -= money;
				INFO(playerid,"Uspjesno ste ostavili drogu!");
				SacuvajOrganizaciju(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_SEF5:
		{
			if(!response) return 1;
			if(response)
			{
                if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
				if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Nisite u niti jednoj organizaciji!");
				new id = PlayerInfo[playerid][pOrgID];
				if(PlayerInfo[playerid][pRank] >= 5 || PlayerInfo[playerid][pAdmin] >= 6)
				{
					if(!OrgInfo[id][oSef]) return ERROR(playerid,"Vasa organizacija nema sef!");
					if(!IsPlayerInRangeOfPoint(playerid,2.0,OrgInfo[id][oSefX],OrgInfo[id][oSefY],OrgInfo[id][oSefZ])) return ERROR(playerid,"Niste kod sefa!");
				}
				else return 1;
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_SEF5,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""bijela"Upisite koliko matsa zelite uzeti!","Uzmi","Odustani");
				if(money > OrgInfo2[id][oMats]) return ShowPlayerDialog(playerid,DIALOG_SEF5,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""crvena"Upisali ste previse!\n"bijela"Upisite koliko matsa zelite uzeti!","Uzmi","Odustani");
				OrgInfo2[id][oMats] -= money;
				PlayerInfo[playerid][pMats] += money;
				INFO(playerid,"Uspjesno ste uzeli mats!");
				SacuvajOrganizaciju(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_SEF6:
		{
			if(!response) return 1;
			if(response)
			{
                if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
				if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Nisite u niti jednoj organizaciji!");
				new id = PlayerInfo[playerid][pOrgID];
				if(PlayerInfo[playerid][pRank] >= 5 || PlayerInfo[playerid][pAdmin] >= 6)
				{
					if(!OrgInfo[id][oSef]) return ERROR(playerid,"Vasa organizacija nema sef!");
					if(!IsPlayerInRangeOfPoint(playerid,2.0,OrgInfo[id][oSefX],OrgInfo[id][oSefY],OrgInfo[id][oSefZ])) return ERROR(playerid,"Niste kod sefa!");
				}
				else return 1;
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_SEF6,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""bijela"Upisite koliko matsa zelite ostaviti u sefu!","Uzmi","Odustani");
				if(money > PlayerInfo[playerid][pMats]) return ShowPlayerDialog(playerid,DIALOG_SEF6,DIALOG_STYLE_INPUT,""smeda""IME" - Sef:",""crvena"Upisali ste previse!\n"bijela"Upisite koliko matsa zelite ostaviti u sefu!","Uzmi","Odustani");
				OrgInfo2[id][oMats] += money;
				PlayerInfo[playerid][pMats] -= money;
				INFO(playerid,"Uspjesno ste ostavili mats!");
				SacuvajOrganizaciju(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_SELLBIZNISTO:
		{
		    if(!response)
		    {
		        PonudioB[playerid] = INVALID_PLAYER_ID; CijenaB[playerid] = 0;
		    }
		    if(response)
		    {
		        if(!strcmp(inputtext,"PRIHVATI",true))
		        {
					if(PlayerInfo[playerid][pMoney] < CijenaB[playerid])
					{
					    PonudioB[playerid] = INVALID_PLAYER_ID; CijenaB[playerid] = 0;
					    ERROR(playerid,"Nemate dovoljno novca!");
						return 1;
					}
					if(PlayerInfo[playerid][pBizzID] != -1)
					{
					    PonudioB[playerid] = INVALID_PLAYER_ID; CijenaB[playerid] = 0;
					    ERROR(playerid,"Nemate dostupan slot!");
						return 1;
					}
					if(PlayerInfo[PonudioB[playerid]][pBizzID] == -1)
					{
					    PonudioB[playerid] = INVALID_PLAYER_ID; CijenaB[playerid] = 0;
					    ERROR(playerid,"Igrac je vec prodao biznis!");
						return 1;
					}
					if(!IsPlayerConnected(PonudioB[playerid]))
					{
					    PonudioB[playerid] = INVALID_PLAYER_ID; CijenaB[playerid] = 0;
					    ERROR(playerid,"Igrac je izasao sa servera!");
						return 1;
					}
					PlayerInfo[playerid][pBizzID] = PlayerInfo[PonudioB[playerid]][pBizzID];
					PlayerInfo[PonudioB[playerid]][pBizzID] = -1;
					BiznisInfo[PlayerInfo[playerid][pBizzID]][bOwnerName] = RemoveUnderLine(GetName(playerid));
					SacuvajBiznis(PlayerInfo[playerid][pBizzID]);
					BiznisLP(PlayerInfo[playerid][pBizzID]);
					INFO(Ponudio[playerid],"Uspjesno ste prodali biznis!");
					ClearChat(playerid);
					INFO(playerid,"Uspjesno ste kupili biznis!");
					INFO(playerid,"Za upravljanje biznisom koristite "zuta"'/biznis'"bijela".");
					GivePlayerMoney(playerid,-CijenaB[playerid]);
					PlayerInfo[playerid][pMoney] -= CijenaB[playerid];
					GivePlayerMoney(PonudioB[playerid],CijenaB[playerid]);
					PlayerInfo[PonudioB[playerid]][pMoney] += CijenaB[playerid];
                    PonudioB[playerid] = INVALID_PLAYER_ID; CijenaB[playerid] = 0;
		        }
		        else
		        {
		            PonudioB[playerid] = INVALID_PLAYER_ID; CijenaB[playerid] = 0;
		            INFO(playerid,"Niste prihvatili ponudu!");
		            return 1;
		        }
		    }
			return 1;
		}
		case DIALOG_SELLKUCATO:
		{
		    if(!response)
		    {
		        PonudioK[playerid] = INVALID_PLAYER_ID; CijenaK[playerid] = 0;
		    }
		    if(response)
		    {
		        if(!strcmp(inputtext,"PRIHVATI",true))
		        {
					if(PlayerInfo[playerid][pMoney] < CijenaK[playerid])
					{
					    PonudioK[playerid] = INVALID_PLAYER_ID; CijenaK[playerid] = 0;
					    ERROR(playerid,"Nemate dovoljno novca!");
						return 1;
					}
					if(PlayerInfo[playerid][pKucaID] != -1)
					{
					    PonudioK[playerid] = INVALID_PLAYER_ID; CijenaK[playerid] = 0;
					    ERROR(playerid,"Nemate dostupan slot!");
						return 1;
					}
					if(PlayerInfo[PonudioK[playerid]][pKucaID] == -1)
					{
					    PonudioK[playerid] = INVALID_PLAYER_ID; CijenaK[playerid] = 0;
					    ERROR(playerid,"Igrac je vec prodao kucu!");
						return 1;
					}
					if(!IsPlayerConnected(PonudioK[playerid]))
					{
					    PonudioK[playerid] = INVALID_PLAYER_ID; CijenaK[playerid] = 0;
					    ERROR(playerid,"Igrac je izasao sa servera!");
						return 1;
					}
					PlayerInfo[playerid][pKucaID] = PlayerInfo[PonudioK[playerid]][pKucaID];
					PlayerInfo[PonudioK[playerid]][pKucaID] = -1;
					KucaInfo[PlayerInfo[playerid][pKucaID]][kOwnerName] = RemoveUnderLine(GetName(playerid));
					SacuvajKucu(PlayerInfo[playerid][pKucaID]);
					KucaLP(PlayerInfo[playerid][pKucaID]);
					INFO(PonudioK[playerid],"Uspjesno ste prodali kucu!");
					ClearChat(playerid);
					INFO(playerid,"Uspjesno ste kupili kucu!");
					INFO(playerid,"Za upravljanje kucom koristite "zuta"'/kuca'"bijela".");
					GivePlayerMoney(playerid,-CijenaK[playerid]);
					PlayerInfo[playerid][pMoney] -= CijenaK[playerid];
					GivePlayerMoney(PonudioK[playerid],CijenaK[playerid]);
					PlayerInfo[PonudioK[playerid]][pMoney] += CijenaK[playerid];
                    PonudioK[playerid] = INVALID_PLAYER_ID; CijenaK[playerid] = 0;
		        }
		        else
		        {
		            PonudioK[playerid] = INVALID_PLAYER_ID; CijenaK[playerid] = 0;
		            INFO(playerid,"Niste prihvatili ponudu!");
		            return 1;
		        }
		    }
			return 1;
		}
        case DIALOG_SELLZLATOTO:
		{
		    if(!response)
		    {
		        PonudioZ[playerid] = INVALID_PLAYER_ID; CijenaZ[playerid] = 0; KolZ[playerid] = 0;
		    }
		    if(response)
		    {
		        if(!strcmp(inputtext,"PRIHVATI",true))
		        {
					if(PlayerInfo[playerid][pMoney] < CijenaZ[playerid])
					{
					    PonudioZ[playerid] = INVALID_PLAYER_ID; CijenaZ[playerid] = 0; KolZ[playerid] = 0;
					    ERROR(playerid,"Nemate dovoljno novca!");
						return 1;
					}
					if(PlayerInfo[PonudioZ[playerid]][pZlato] < KolZ[playerid])
					{
					    PonudioZ[playerid] = INVALID_PLAYER_ID; CijenaZ[playerid] = 0; KolZ[playerid] = 0;
					    ERROR(playerid,"Igrac nema dovoljno zlata!");
						return 1;
					}
					if(!IsPlayerConnected(PonudioZ[playerid]))
					{
					    PonudioZ[playerid] = INVALID_PLAYER_ID; CijenaZ[playerid] = 0; KolZ[playerid] = 0;
					    ERROR(playerid,"Igrac je izasao sa servera!");
						return 1;
					}
					PlayerInfo[playerid][pZlato] += KolZ[playerid];
					PlayerInfo[PonudioZ[playerid]][pZlato] -= KolZ[playerid];
					INFO(PonudioZ[playerid],"Uspjesno ste prodali zlato!");
					INFO(playerid,"Uspjesno ste kupili zlato!");
					GivePlayerMoney(playerid,-CijenaZ[playerid]);
					PlayerInfo[playerid][pMoney] -= CijenaZ[playerid];
					GivePlayerMoney(PonudioZ[playerid],CijenaZ[playerid]);
					PlayerInfo[PonudioZ[playerid]][pMoney] += CijenaZ[playerid];
					UpdateBankaZlatoTD(playerid);
					UpdateBankaZlatoTD(PonudioZ[playerid]);
                    PonudioZ[playerid] = INVALID_PLAYER_ID; CijenaZ[playerid] = 0; KolZ[playerid] = 0;
		        }
		        else
		        {
		            PonudioZ[playerid] = INVALID_PLAYER_ID; CijenaZ[playerid] = 0; KolZ[playerid] = 0;
		            INFO(playerid,"Niste prihvatili ponudu!");
		            return 1;
		        }
		    }
			return 1;
		}
		case DIALOG_SELLDROGATO:
		{
		    if(!response)
		    {
		        PonudioD[playerid] = INVALID_PLAYER_ID; CijenaD[playerid] = 0; KolD[playerid] = 0;
		    }
		    if(response)
		    {
		        if(!strcmp(inputtext,"PRIHVATI",true))
		        {
					if(PlayerInfo[playerid][pMoney] < CijenaD[playerid])
					{
					    PonudioD[playerid] = INVALID_PLAYER_ID; CijenaD[playerid] = 0; KolD[playerid] = 0;
					    ERROR(playerid,"Nemate dovoljno novca!");
						return 1;
					}
					if(PlayerInfo[PonudioD[playerid]][pDroga] < KolD[playerid])
					{
					    PonudioD[playerid] = INVALID_PLAYER_ID; CijenaD[playerid] = 0; KolD[playerid] = 0;
					    ERROR(playerid,"Igrac nema dovoljno droge!");
						return 1;
					}
                	if(!IsPlayerConnected(PonudioD[playerid]))
					{
					    PonudioD[playerid] = INVALID_PLAYER_ID; CijenaD[playerid] = 0; KolD[playerid] = 0;
					    ERROR(playerid,"Igrac je izasao sa servera!");
						return 1;
					}
					PlayerInfo[playerid][pDroga] += KolD[playerid];
					PlayerInfo[PonudioD[playerid]][pDroga] -= KolD[playerid];
					INFO(PonudioD[playerid],"Uspjesno ste prodali drogu!");
					INFO(playerid,"Uspjesno ste kupili drogu!");
					GivePlayerMoney(playerid,-CijenaD[playerid]);
					PlayerInfo[playerid][pMoney] -= CijenaD[playerid];
					GivePlayerMoney(PonudioD[playerid],CijenaD[playerid]);
					PlayerInfo[PonudioD[playerid]][pMoney] += CijenaD[playerid];
                    PonudioD[playerid] = INVALID_PLAYER_ID; CijenaD[playerid] = 0; KolD[playerid] = 0;
		        }
		        else
		        {
		            PonudioD[playerid] = INVALID_PLAYER_ID; CijenaD[playerid] = 0; KolD[playerid] = 0;
		            INFO(playerid,"Niste prihvatili ponudu!");
		            return 1;
		        }
		    }
			return 1;
		}
		case DIALOG_SELLMATSTO:
		{
		    if(!response)
		    {
		        PonudioM[playerid] = INVALID_PLAYER_ID; CijenaM[playerid] = 0; KolM[playerid] = 0;
		    }
		    if(response)
		    {
		        if(!strcmp(inputtext,"PRIHVATI",true))
		        {
					if(PlayerInfo[playerid][pMoney] < CijenaM[playerid])
					{
					    PonudioM[playerid] = INVALID_PLAYER_ID; CijenaM[playerid] = 0; KolM[playerid] = 0;
					    ERROR(playerid,"Nemate dovoljno novca!");
						return 1;
					}
					if(PlayerInfo[PonudioM[playerid]][pMats] < KolM[playerid])
					{
					    PonudioM[playerid] = INVALID_PLAYER_ID; CijenaM[playerid] = 0; KolM[playerid] = 0;
					    ERROR(playerid,"Igrac nema dovoljno matsa!");
						return 1;
					}
					if(!IsPlayerConnected(PonudioM[playerid]))
					{
					    PonudioM[playerid] = INVALID_PLAYER_ID; CijenaM[playerid] = 0; KolM[playerid] = 0;
					    ERROR(playerid,"Igrac je izasao sa servera!");
						return 1;
					}
					PlayerInfo[playerid][pMats] += KolM[playerid];
					PlayerInfo[PonudioM[playerid]][pMats] -= KolM[playerid];
					INFO(PonudioM[playerid],"Uspjesno ste prodali mats!");
					INFO(playerid,"Uspjesno ste kupili mats!");
					GivePlayerMoney(playerid,-CijenaM[playerid]);
					PlayerInfo[playerid][pMoney] -= CijenaM[playerid];
					GivePlayerMoney(PonudioM[playerid],CijenaM[playerid]);
					PlayerInfo[PonudioM[playerid]][pMoney] += CijenaM[playerid];
                    PonudioM[playerid] = INVALID_PLAYER_ID; CijenaM[playerid] = 0; KolM[playerid] = 0;
		        }
		        else
		        {
		            PonudioM[playerid] = INVALID_PLAYER_ID; CijenaM[playerid] = 0; KolM[playerid] = 0;
		            INFO(playerid,"Niste prihvatili ponudu!");
		            return 1;
		        }
		    }
			return 1;
		}
		case DIALOG_POLICIJA_OPREMA:
		{
		    if(!response) return 1;
		    if(response)
		    {
		        if(PlayerInfo[playerid][pOrgID] != POLICIJA) return ERROR(playerid,"Niste policajac!");
		        switch(listitem)
		        {
		            case 0:
		            {
						SetPlayerArmour(playerid,99.0);
						INFO(playerid,"Uzeli ste armour!");
					}
					case 1:
					{
					    if(!Tazer[playerid])
					    {
						    GivePlayerWeapon(playerid,23,10);
							Tazer[playerid] = true;
							INFO(playerid,"Uzeli ste tazer!");
						}
						else
						{
						    INFO(playerid,"Vratili ste tazer i uzeli obican pistolj!");
							Tazer[playerid] = false;
						}
					}
					case 2:
					{
					    if(PlayerInfo[playerid][pRank] != 1) return ERROR(playerid,"Niste taj rank!");
                        ResetPlayerWeapons(playerid);
                        GivePlayerWeapon(playerid,3,1);
                        GivePlayerWeapon(playerid,25,200);
                        INFO(playerid,"Vi ste prometni policajac!");
                        INFO(playerid,"Vas zadatak je paziti na sigurnost u prometu!");
					}
					case 3:
					{
					    if(PlayerInfo[playerid][pRank] != 2) return ERROR(playerid,"Niste taj rank!");
					    ResetPlayerWeapons(playerid);
                        GivePlayerWeapon(playerid,1,1);
                        GivePlayerWeapon(playerid,41,1000);
                        GivePlayerWeapon(playerid,28,1000);
                        INFO(playerid,"Vi ste undercover policajac!");
                        INFO(playerid,"Vas zadatak je ubaciti se medu kriminalce bez njihova znanja i uhapsiti ih!");
	    			}
	    			case 4:
					{
					    if(PlayerInfo[playerid][pRank] != 3) return ERROR(playerid,"Niste taj rank!");
					    ResetPlayerWeapons(playerid);
					    SetPlayerArmour(playerid,99.0);
                        GivePlayerWeapon(playerid,3,1);
                        GivePlayerWeapon(playerid,27,1000);
                        GivePlayerWeapon(playerid,31,1000);
                        GivePlayerWeapon(playerid,29,1000);
                        GivePlayerWeapon(playerid,17,1000);
						INFO(playerid,"Vi ste S.W.A.T policajac!");
                        INFO(playerid,"Zaduzeni ste za sprjecavanje najzescih pljacka i hapsenje najgorih kriminalaca!");
					}
					case 5:
					{
					    if(PlayerInfo[playerid][pRank] != 4) return ERROR(playerid,"Niste taj rank!");
					    ResetPlayerWeapons(playerid);
					    SetPlayerArmour(playerid,99.0);
                        GivePlayerWeapon(playerid,3,1);
                        GivePlayerWeapon(playerid,27,1000);
                        GivePlayerWeapon(playerid,34,1000);
						INFO(playerid,"Vi ste FBI policajac!");
                        INFO(playerid,"Zaduzeni ste za hapsenje kriminalaca!");
					}
					case 6:
					{
					    if(PlayerInfo[playerid][pRank] != 5) return ERROR(playerid,"Niste taj rank!");
                        ResetPlayerWeapons(playerid);
					    SetPlayerArmour(playerid,99.0);
                        GivePlayerWeapon(playerid,3,1);
                        GivePlayerWeapon(playerid,27,1000);
                        GivePlayerWeapon(playerid,31,1000);
                        INFO(playerid,"Vi ste zamijenik zapovijednika!");
                        INFO(playerid,"Zaduzeni ste za upravljanje policijom!");
					}
					case 7:
					{
					    if(PlayerInfo[playerid][pRank] != 6) return ERROR(playerid,"Niste taj rank!");
                        ResetPlayerWeapons(playerid);
					    SetPlayerArmour(playerid,99.0);
                        GivePlayerWeapon(playerid,3,1);
                        GivePlayerWeapon(playerid,26,50);
                        GivePlayerWeapon(playerid,31,1000);
                        INFO(playerid,"Vi ste zapovijednik!");
                        INFO(playerid,"Zaduzeni ste za upravljanje policijom i upravljanje rada ostalih rankova!");
					}
				}
			}
		    return 1;
		}
		case DIALOG_AUTOSKOLA:
		{
			if(!response) return 1;
			if(GPSON[playerid]) return ERROR(playerid,"Imate ukljucen gps!");
			if(Radi[playerid]) return ERROR(playerid,"Radite!");
			if(AdminDuty[playerid]) return ERROR(playerid,"Ne mozete biti na admin duznosti!");
		    if(GameMasterDuty[playerid]) return ERROR(playerid,"Ne mozete biti na gamemaster duznosti!");
		    if(PolicijaDuty[playerid]) return ERROR(playerid,"Ne mozete biti na policijskoj duznosti!");
   			if(polaganje[playerid] != -1) return ERROR(playerid,"Imate ukljuceno polaganje!");
   			if(Trenira[playerid] != -1) return ERROR(playerid,"Trenirate skill!");
			if(IsPlayerInRangeOfPoint(playerid,2,-2033.4346,-117.4143,1035.1719) && GetPlayerVirtualWorld(playerid) == 10)
			{
			    switch(listitem)
			    {
					case 0:
					{
					    if(PlayerInfo[playerid][pVozackaDozvola]) return ERROR(playerid,"Vec imate vozacku dozvolu!");
					    if(GetPlayerMoney(playerid) < 30000) return ERROR(playerid,"Nemate dovoljno novca kod sebe!");
					    PlayerInfo[playerid][pMoney] -= 30000;
					    GivePlayerMoney(playerid,-30000);
					    SacuvajIgraca(playerid);
					    Polaganje(playerid,0);
					}
					case 1:
					{
					    if(PlayerInfo[playerid][pMotorDozvola]) return ERROR(playerid,"Vec imate dozvolu za motor!");
					    if(GetPlayerMoney(playerid) < 15000) return ERROR(playerid,"Nemate dovoljno novca kod sebe!");
					    PlayerInfo[playerid][pMoney] -= 15000;
					    GivePlayerMoney(playerid,-15000);
					    SacuvajIgraca(playerid);
					    Polaganje(playerid,1);
					}
					case 2:
					{
					    if(PlayerInfo[playerid][pKamionDozvola]) return ERROR(playerid,"Vec imate dozvolu za kamion!");
					    if(GetPlayerMoney(playerid) < 50000) return ERROR(playerid,"Nemate dovoljno novca kod sebe!");
					    PlayerInfo[playerid][pMoney] -= 50000;
					    GivePlayerMoney(playerid,-50000);
					    SacuvajIgraca(playerid);
					    Polaganje(playerid,2);
					}
					case 3:
					{
					    if(PlayerInfo[playerid][pBrodDozvola]) return ERROR(playerid,"Vec imate dozvolu za brod!");
					    if(GetPlayerMoney(playerid) < 100000) return ERROR(playerid,"Nemate dovoljno novca kod sebe!");
					    PlayerInfo[playerid][pMoney] -= 100000;
					    GivePlayerMoney(playerid,-100000);
					    AUTOSKOLA(playerid,"Uspjesno ste kupili dozvolu za brod!");
					    PlayerInfo[playerid][pBrodDozvola] = true;
					    SacuvajIgraca(playerid);
					}
					case 4:
					{
					    if(PlayerInfo[playerid][pLetjeliceDozvola]) return ERROR(playerid,"Vec imate dozvolu za letjelice!");
					    if(GetPlayerMoney(playerid) < 500000) return ERROR(playerid,"Nemate dovoljno novca kod sebe!");
					    PlayerInfo[playerid][pMoney] -= 500000;
					    GivePlayerMoney(playerid,-500000);
					    PlayerInfo[playerid][pLetjeliceDozvola] = true;
						AUTOSKOLA(playerid,"Uspjesno ste kupili dozvolu za letjelice!");
					    SacuvajIgraca(playerid);
					}
			    }
			}
			else return ERROR(playerid,"Niste u autoskoli!");
			return 1;
		}
		case DIALOG_AVOZILO:
		{
		    if(!response) return 1;
  			if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
			if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pGameMaster] >= 1)
			{
	    		if(!AGM(playerid)) return ERROR(playerid,"Niste na duznosti!");
	    		new numb;
				switch(listitem)
				{
				    case 0: numb = 579;
				    case 1: numb = 560;
				    case 2: numb = 521;
				    case 3: numb = 567;
				    case 4: numb = 418;
				}
		  		new Float:x,Float:y,Float:z,Float:az;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,az);
            	avozilo[playerid] = CreateVehicle(numb,x,y,z,az,0,0,-1);
            	SetGorivo(avozilo[playerid]);
            	PutPlayerInVehicle(playerid,avozilo[playerid],0);
			}
			return 1;
		}
		case DIALOG_CNAPRAVIORUZJE:
		{
		    if(!response) return 1;
  			if(!Ulogovan[playerid]) return ERROR(playerid,"Niste ulogovani!");
  			if(PlayerInfo[playerid][pOrgID] == POLICIJA) return ERROR(playerid,"Vi ste policajac!");
			if(PlayerInfo[playerid][pOrgID] == -1) return ERROR(playerid,"Niste u organizaciji!");
			if(!IsPlayerInRangeOfPoint(playerid,2.0,2722.5085,2849.5295,10.8203)) return ERROR(playerid,"Niste kod crnog trzista!");
			new materijali, id, metaka;
			switch(listitem)
			{
			    case 0: materijali = 4, id = 31, metaka = 6;
			    case 1: materijali = 1, id = 4, metaka = 1;
			    case 2: materijali = 2, id = 27, metaka = 8;
			    case 3: materijali = 4, id = 30, metaka = 6;
			    case 4: materijali = 1, id = 24, metaka = 7;
			    case 5: materijali = 5, id = 34, metaka = 4;
			}
			if(PlayerInfo[playerid][pMats] < materijali) return ERROR(playerid,"Nemate dovoljno matsa!");
			PlayerInfo[playerid][pMats] -= materijali;
			GivePlayerWeapon(playerid,id,metaka);
			SacuvajIgraca(playerid);
			new str[100];
			new nm[24];
			GetWeaponName(id,nm,sizeof(nm));
			format(str,sizeof(str),""zelena"Uspjesno ste napravili oruzje %s(%d metaka) za %d materijala!",nm,metaka,materijali);
			SCM(playerid,-1,str);
			return 1;
		}
		case DIALOG_RENT:
	 	{
	 	    if(!response)
	 		{
	 		    TogglePlayerControllable(playerid,1);
	 		    RemovePlayerFromVehicle(playerid);
				return 1;
			}
			if(response)
			{
			    new vehid = GetPlayerVehicleID(playerid);
			    if(VoziloZaRent[vehid])
			    {
			        if(!RentaVozilo[playerid])
			        {
			            if(!VoziloRentano[vehid])
			            {
			                new txt = strval(inputtext);
			                if(txt >= 1)
			                {
								if(GetPlayerMoney(playerid) < (ServerInfo[sRentCijena]*txt)) return ERROR(playerid,"Nemate dovoljno novca!");
			    				VoziloRentano[vehid] = true;
								RentaVozilo[playerid] = true;
								IdRentVozila[playerid] = vehid;
								TogglePlayerControllable(playerid,1);
								GivePlayerMoney(playerid,-(ServerInfo[sRentCijena]*txt));
								PlayerInfo[playerid][pMoney] -= (ServerInfo[sRentCijena]*txt);
								RentVrijeme[playerid] = txt;
								RentTimer[playerid] = SetTimerEx("RentVrijemeTimer",60000,true,"d",playerid);
								new str[100];
								format(str,sizeof(str),"Uspjesno ste rentali vozilo za %d$!",(ServerInfo[sRentCijena]*txt));
								INFO(playerid,str);
								INFO(playerid,"Da ga unrentate koristite '/unrentaj'!");
						    }
						    else
						    {
						        ERROR(playerid,"Cijena ne moze biti manja od 1$!");
		    					TogglePlayerControllable(playerid,1);
			    				RemovePlayerFromVehicle(playerid);
						    }
						}
						else
						{
	                        ERROR(playerid,"Ovo vozilo je vec rentano!");
	    					TogglePlayerControllable(playerid,1);
		    				RemovePlayerFromVehicle(playerid);
						}
					}
					else
					{
					    ERROR(playerid,"Vec rentate vozilo!");
			     		TogglePlayerControllable(playerid,1);
	   					RemovePlayerFromVehicle(playerid);
	   				}
				}
				else
				{
	   				ERROR(playerid,"Ovo nije rent vozilo!");
		     		TogglePlayerControllable(playerid,1);
					RemovePlayerFromVehicle(playerid);
				}
			}
			return 1;
		}
	 	case DIALOG_RENT1:
	 	{
	 	    if(!response) return 1;
			if(response)
			{
			    switch(listitem)
			    {
			        case 0:
			        {
			            if(IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Izadite iz vozila prvo!");
			            ShowPlayerDialog(playerid,DIALOG_RENT2,DIALOG_STYLE_INPUT,""plava""IME" - Kreiranje vozila:",""bijela"Upisite id vozila koje zelite kreirati!","Dalje","Odustani");
			        }
			        case 1:
			        {
			            if(IsPlayerInAnyVehicle(playerid))
			            {
			                new vehid = GetPlayerVehicleID(playerid);
							new vehidd;
							if(VoziloZaRent[vehid])
			    			{
							    new Float:x,Float:y,Float:z,Float:az;
								GetVehiclePos(vehid,x,y,z);
								GetVehicleZAngle(vehid,az);
								for(new i=0;i<MAX_RENTS;i++)
								{
								    if(RentInfo[i][rID] == vehid)
								    {
								        vehidd = i;
								        break;
								    }
								}
								RentInfo[vehidd][rX] = x;
								RentInfo[vehidd][rY] = y;
								RentInfo[vehidd][rZ] = z;
								RentInfo[vehidd][rAZ] = az;
								VoziloZaRent[RentInfo[vehidd][rID]] = false;
								DestroyVehicle(RentInfo[vehidd][rID]);
								RentInfo[vehidd][rID] = CreateVehicle(RentInfo[vehidd][rModel],RentInfo[vehidd][rX],RentInfo[vehidd][rY],RentInfo[vehidd][rZ],RentInfo[vehidd][rAZ],RentInfo[vehidd][rColor1],RentInfo[vehidd][rColor2],RentInfo[vehidd][rRespawn]);
                                VoziloZaRent[RentInfo[vehidd][rID]] = true;
								SetGorivo(RentInfo[vehidd][rID]);
                                Attach3DTextLabelToVehicle(renttxt[vehidd],RentInfo[vehidd][rID],0.0,0.0,0.0);
								SetVehicleNumberPlate(RentInfo[vehid][rID],"RENT");
								INFO(playerid,"Vozilo uspjesno preparkirano!!");
								SacuvajRent(vehidd); 
			    			}
			    			else return ERROR(playerid,"Niste u rent vozilu!");
			            }
			            else return ERROR(playerid,"Niste u rent vozilu!");
			        }
			        case 2:
			        {
			            if(IsPlayerInAnyVehicle(playerid))
			            {
			                new vehid = GetPlayerVehicleID(playerid);
							new vehidd;
			    			if(VoziloZaRent[vehid])
			    			{
			    			    for(new i=0;i<MAX_RENTS;i++)
								{
								    if(RentInfo[i][rID] == vehid)
								    {
								        vehidd = i;
								        break;
								    }
								}
					            EditInfo[playerid][eID] = vehidd;
					            ShowPlayerDialog(playerid,DIALOG_RENT6,DIALOG_STYLE_INPUT,""plava""IME" - Mijenjanje boje:",""bijela"Upisite id 1. boje!","Dalje","Odustani");
	               			}
			    			else return ERROR(playerid,"Niste u rent vozilu!");
			            }
			            else return ERROR(playerid,"Niste u rent vozilu!");
					}
					case 3:
					{
					    if(IsPlayerInAnyVehicle(playerid))
			            {
			                new vehid = GetPlayerVehicleID(playerid);
			                new vehidd;
			    			if(VoziloZaRent[vehid])
			    			{
			    			    for(new i=0;i<MAX_RENTS;i++)
								{
								    if(RentInfo[i][rID] == vehid)
								    {
								        vehidd = i;
								        break;
								    }
								}
					            EditInfo[playerid][eID] = vehidd;
					            ShowPlayerDialog(playerid,DIALOG_RENT8,DIALOG_STYLE_INPUT,""plava""IME" - Mijenjanje respawn timea:",""bijela"Upisite novi respawn time!","Promijeni","Odustani");
	               			}
			    			else return ERROR(playerid,"Niste u rent vozilu!");
			            }
			            else return ERROR(playerid,"Niste u rent vozilu!");
					}
					case 4:
					{
					    if(!IsPlayerInAnyVehicle(playerid)) return ERROR(playerid,"Niste u vozilu!");
					    new i = -1;
					    for(new z=0;z<MAX_RENTS;z++)
						{
		    				if(RentInfo[z][rID] == GetPlayerVehicleID(playerid))
						    {
		        				i = z;
		        				break;
						    }
						}
						if(i == -1) return ERROR(playerid,"Niste u rent vozilu!");
			            if(VoziloRentano[RentInfo[i][rID]])
			            {
			                foreach(Player,k)
			                {
			                	if(RentaVozilo[k])
								{
								    if(IdRentVozila[k] == RentInfo[i][rID])
								    {
										VoziloRentano[IdRentVozila[k]] = false;
										RentaVozilo[k] = false;
										IdRentVozila[k] = -1;
										RentVrijeme[k] = 0;
										KillTimer(RentTimer[k]);
								        break;
								    }
								}
							}
						}
						new str1[20];
			  			format(str1,sizeof(str1),RPATH,i);
						if(fexist(str1))
						{
		    				RentInfo[i][rModel] = 0;
						    RentInfo[i][rColor1] = 0;
						    RentInfo[i][rColor2] = 0;
						    RentInfo[i][rRespawn] = 0;
							RentInfo[i][rX] =
							RentInfo[i][rY] =
							RentInfo[i][rZ] =
							RentInfo[i][rAZ] = 0.0;
							VoziloZaRent[RentInfo[i][rID]] = false;
							VoziloRentano[RentInfo[i][rID]] = false;
							DestroyVehicle(RentInfo[i][rID]);
							Delete3DTextLabel(renttxt[i]);
							fremove(str1);
						}
					}
			    }
			}
			return 1;
		}
		case DIALOG_RENT2:
		{
		    if(!response) return 1;
		    new txt = strval(inputtext);
		    if(txt < 400 || txt > 611) return ShowPlayerDialog(playerid,DIALOG_RENT2,DIALOG_STYLE_INPUT,""plava""IME" - Kreiranje vozila:",""bijela"Upisite id vozila koje zelite kreirati!","Dalje","Odustani");
		    EditInfo[playerid][eModel] = txt;
		    ShowPlayerDialog(playerid,DIALOG_RENT3,DIALOG_STYLE_INPUT,""plava""IME" - Kreiranje vozila:",""bijela"Upisite id 1. boje!","Dalje","Odustani");
		    return 1;
		}
		case DIALOG_RENT3:
		{
            if(!response) return 1;
		    new txt = strval(inputtext);
		    EditInfo[playerid][eColor1] = txt;
		    ShowPlayerDialog(playerid,DIALOG_RENT4,DIALOG_STYLE_INPUT,""plava""IME" - Kreiranje vozila:",""bijela"Upisite id 2. boje!","Dalje","Odustani");
		    return 1;
		}
		case DIALOG_RENT4:
		{
		    if(!response) return 1;
		    new txt = strval(inputtext);
		    EditInfo[playerid][eColor2] = txt;
		    ShowPlayerDialog(playerid,DIALOG_RENT5,DIALOG_STYLE_INPUT,""plava""IME" - Kreiranje vozila:",""bijela"Upisite respawn time vozila!","Zavrsi","Odustani");
		    return 1;
		}
		case DIALOG_RENT5:
		{
		    if(!response) return 1;
		    new txt = strval(inputtext);
		    EditInfo[playerid][eRespawn] = txt;
	    	for(new i=0;i<MAX_RENTS;i++)
			{
				new str1[20];
			  	format(str1,sizeof(str1),RPATH,i);
				if(!fexist(str1))
				{
				    RentInfo[i][rModel] = EditInfo[playerid][eModel];
				    RentInfo[i][rColor1] = EditInfo[playerid][eColor1];
				    RentInfo[i][rColor2] = EditInfo[playerid][eColor2];
				    RentInfo[i][rRespawn] = EditInfo[playerid][eRespawn];
				    new Float:x,Float:y,Float:z,Float:az;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,az);
					RentInfo[i][rX] = x;
					RentInfo[i][rY] = y;
					RentInfo[i][rZ] = z;
					RentInfo[i][rAZ] = az;
					RentInfo[i][rID] = CreateVehicle(RentInfo[i][rModel],RentInfo[i][rX],RentInfo[i][rY],RentInfo[i][rZ],RentInfo[i][rAZ],RentInfo[i][rColor1],RentInfo[i][rColor2],RentInfo[i][rRespawn]);
                    SetGorivo(RentInfo[i][rID]);
			  		VoziloZaRent[RentInfo[i][rID]] = true;
					VoziloRentano[RentInfo[i][rID]] = false;
					SetVehicleNumberPlate(RentInfo[i][rID],"RENT");
					renttxt[i] = Create3DTextLabel( "[ RENT ]", -1, RentInfo[i][rX],RentInfo[i][rY],RentInfo[i][rZ], 50.0, 0, 1 );
					Attach3DTextLabelToVehicle(renttxt[i],RentInfo[i][rID],0.0,0.0,0.0);
	                EditInfo[playerid][eModel] = EditInfo[playerid][eColor1] = EditInfo[playerid][eColor2] = EditInfo[playerid][eRespawn] = EditInfo[playerid][eID] = 0;
					SetPlayerPos(playerid,x,y,z+5);
					SacuvajRent(i);
					break;
				}
			}
		    return 1;
		}
		case DIALOG_RENT6:
		{
		    if(!response) return 1;
		    new txt = strval(inputtext);
		    EditInfo[playerid][eColor1] = txt;
		    ShowPlayerDialog(playerid,DIALOG_RENT7,DIALOG_STYLE_INPUT,""plava""IME" - Mijenjanje boje",""bijela"Upisite id 2. boje!","Promijeni","Odustani");
		    return 1;
		}
		case DIALOG_RENT7:
		{
		    if(!response) return 1;
		    new txt = strval(inputtext);
		    EditInfo[playerid][eColor2] = txt;
		    new vehid = EditInfo[playerid][eID];
		    VoziloZaRent[RentInfo[vehid][rID]] = false;
	     	DestroyVehicle(RentInfo[vehid][rID]);
		    RentInfo[vehid][rColor1] = EditInfo[playerid][eColor1];
		    RentInfo[vehid][rColor2] = EditInfo[playerid][eColor2];
			RentInfo[vehid][rID] = CreateVehicle(RentInfo[vehid][rModel],RentInfo[vehid][rX],RentInfo[vehid][rY],RentInfo[vehid][rZ],RentInfo[vehid][rAZ],RentInfo[vehid][rColor1],RentInfo[vehid][rColor2],RentInfo[vehid][rRespawn]);
            VoziloZaRent[RentInfo[vehid][rID]] = true;
			SetGorivo(RentInfo[vehid][rID]);
            Attach3DTextLabelToVehicle(renttxt[vehid],RentInfo[vehid][rID],0.0,0.0,0.0);
			SetVehicleNumberPlate(RentInfo[vehid][rID],"RENT");
			INFO(playerid,"Vozilo uspjesno prefarbano!");
			SacuvajRent(vehid);
			EditInfo[playerid][eModel] = EditInfo[playerid][eColor1] = EditInfo[playerid][eColor2] = EditInfo[playerid][eRespawn] = EditInfo[playerid][eID] = 0;
		    return 1;
		}
		case DIALOG_RENT8:
		{
			if(!response) return 1;
		    new txt = strval(inputtext);
		    new vehid = EditInfo[playerid][eID];
		    VoziloZaRent[RentInfo[vehid][rID]] = false;
		    DestroyVehicle(RentInfo[vehid][rID]);
		    RentInfo[vehid][rRespawn] = txt;
			RentInfo[vehid][rID] = CreateVehicle(RentInfo[vehid][rModel],RentInfo[vehid][rX],RentInfo[vehid][rY],RentInfo[vehid][rZ],RentInfo[vehid][rAZ],RentInfo[vehid][rColor1],RentInfo[vehid][rColor2],RentInfo[vehid][rRespawn]);
            SetGorivo(RentInfo[vehid][rID]);
            VoziloZaRent[RentInfo[vehid][rID]] = true;
			Attach3DTextLabelToVehicle(renttxt[vehid],RentInfo[vehid][rID],0.0,0.0,0.0);
			SetVehicleNumberPlate(RentInfo[vehid][rID],"RENT");
			INFO(playerid,"Respawn time uspjesno promijenjen!");
			SacuvajRent(vehid);
			EditInfo[playerid][eModel] = EditInfo[playerid][eColor1] = EditInfo[playerid][eColor2] = EditInfo[playerid][eRespawn] = EditInfo[playerid][eID] = 0;
		    return 1;
		}
		case DIALOG_RENTCIJENA:
		{
		    if(!response) return 1;
		    new txt = strval(inputtext);
		    if(txt < 1) return ShowPlayerDialog(playerid,DIALOG_RENTCIJENA,DIALOG_STYLE_INPUT,""plava""IME" - Rent Cijena:!","Upisite novu cijenu renta!","Promijeni","Odustani");
			ServerInfo[sRentCijena] = txt;
			new str[50];
			format(str,sizeof(str),"Promijenili ste cijenu renta na %d$",txt);
			INFO(playerid,str);
			SacuvajServer();
			return 1;
		}
		case DIALOG_SETTINGS:
		{
		    if(!response) return 1;
		    if(response)
		    {
				switch(listitem)
				{
					case 0:
				    {
						ShowPlayerDialog(playerid,DIALOG_UCITAVANJETIME,DIALOG_STYLE_INPUT,""plava""IME" - Vrijeme ucitavanja:!",""bijela"Upisite novo vrijeme ucitavanja u sekundama!\n"crvena"Minimalno 1, maksimalno 10!","Promijeni","Odustani");
					}
					case 1:
					{
					    if(PlayerInfo[playerid][pChatbubble])
						{
		    				PlayerInfo[playerid][pChatbubble] = false;
					    	INFO(playerid,"Iskljucili ste chat bubble.(Samo Admini, GameMasteri i Vipovi!)");
						}
						else if(!PlayerInfo[playerid][pChatbubble])
						{
		    				PlayerInfo[playerid][pChatbubble] = true;
						    INFO(playerid,"Ukljucili ste chat bubble.(Samo Admini, GameMasteri i Vipovi!)");
						}
						SacuvajIgraca(playerid);
					}
					case 2:
					{
					    if(PlayerInfo[playerid][pVipChat])
						{
		    				PlayerInfo[playerid][pVipChat] = false;
					    	INFO(playerid,"Iskljucili ste vip chat.(Samo Admini i Vipovi!)");
						}
						else if(!PlayerInfo[playerid][pVipChat])
						{
		    				PlayerInfo[playerid][pVipChat] = true;
						    INFO(playerid,"Ukljucili ste vip chat.(Samo Admini i Vipovi!)");
						}
						SacuvajIgraca(playerid);
					}
					case 3:
					{
					    if(PlayerInfo[playerid][pGameMasterChat])
						{
		    				PlayerInfo[playerid][pGameMasterChat] = false;
					    	INFO(playerid,"Iskljucili ste gamemaster chat.(Samo Admini i GameMasteri!)");
						}
						else if(!PlayerInfo[playerid][pGameMasterChat])
						{
		    				PlayerInfo[playerid][pGameMasterChat] = true;
						    INFO(playerid,"Ukljucili ste gamemaster chat.(Samo Admini i GameMasteri!)");
						}
						SacuvajIgraca(playerid);
					}
					case 4:
					{
					    if(PlayerInfo[playerid][pAdminChat])
						{
		    				PlayerInfo[playerid][pAdminChat] = false;
					    	INFO(playerid,"Iskljucili ste admin chat.(Samo Admini!)");
						}
						else if(!PlayerInfo[playerid][pAdminChat])
						{
		    				PlayerInfo[playerid][pAdminChat] = true;
						    INFO(playerid,"Ukljucili ste admin chat.(Samo Admini!)");
						}
						SacuvajIgraca(playerid);
					}
					case 5:
					{
					    if(PlayerInfo[playerid][pGotoSlabijih])
						{
		    				PlayerInfo[playerid][pGotoSlabijih] = false;
					    	INFO(playerid,"Iskljucili ste goto slabijih.(Slabiji rankovi se ne mogu portati do vas!)(Samo Admini i GameMasteri!)");
						}
						else if(!PlayerInfo[playerid][pGotoSlabijih])
						{
		    				PlayerInfo[playerid][pGotoSlabijih] = true;
						    INFO(playerid,"Ukljucili ste goto slabijih.(Slabiji rankovi se mogu portati do vas!)(Samo Admini i GameMasteri!)");
						}
						SacuvajIgraca(playerid);
					}
					case 6:
					{
					    if(PlayerInfo[playerid][pGetSlabijih])
						{
		    				PlayerInfo[playerid][pGetSlabijih] = false;
					    	INFO(playerid,"Iskljucili ste get slabijih.(Slabiji rankovi vas ne mogu portati do sebe!)(Samo Admini i GameMasteri!)");
						}
						else if(!PlayerInfo[playerid][pGetSlabijih])
						{
		    				PlayerInfo[playerid][pGetSlabijih] = true;
						    INFO(playerid,"Ukljucili ste get slabijih.(Slabiji rankovi vas mogu portati do sebe!)(Samo Admini i GameMasteri!)");
						}
						SacuvajIgraca(playerid);
					}
					case 7:
					{
					    if(PlayerInfo[playerid][pKomandeSlabijih])
						{
		    				PlayerInfo[playerid][pKomandeSlabijih] = false;
					    	INFO(playerid,"Iskljucili ste komande slabijih.(Slabiji rankovi ne mogu koristiti komande na vama!)(Samo Admini i GameMasteri!)");
						}
						else if(!PlayerInfo[playerid][pKomandeSlabijih])
						{
		    				PlayerInfo[playerid][pKomandeSlabijih] = true;
						    INFO(playerid,"Ukljucili ste komande slabijih.(Slabiji rankovi mogu koristiti komande na vama!)(Samo Admini i GameMasteri!)");
						}
						SacuvajIgraca(playerid);
					}
					case 8:
					{
					    if(PlayerInfo[playerid][pMapTeleport])
						{
		    				PlayerInfo[playerid][pMapTeleport] = false;
					    	INFO(playerid,"Iskljucili ste map teleport.(Samo A6!)");
						}
						else if(!PlayerInfo[playerid][pMapTeleport])
						{
		    				PlayerInfo[playerid][pMapTeleport] = true;
						    INFO(playerid,"Ukljucili ste map teleport.(Samo A6!)");
						}
						SacuvajIgraca(playerid);
					}
				}
		    }
		    return 1;
		}
		case DIALOG_UCITAVANJETIME:
		{
		    if(!response) return 1;
		    new txt = strval(inputtext);
		    if(txt < 1 || txt > 10) return ShowPlayerDialog(playerid,DIALOG_UCITAVANJETIME,DIALOG_STYLE_INPUT,""plava""IME" - Vrijeme ucitavanja:!","Upisite novo vrijeme ucitavanja u sekundama!\n"crvena"Minimalno 1, maksimalno 10!","Promijeni","Odustani");
			PlayerInfo[playerid][pUcitavanje] = txt;
			new str[50];
			format(str,sizeof(str),"Promijenili ste vrijeme ucitavanja na %ds!(Svi!)",txt);
			INFO(playerid,str);
			SacuvajIgraca(playerid);
			return 1;
		}
		case DIALOG_TRENING:
		{
		    if(!response) return 1;
		    if(PlayerInfo[playerid][pWeaponSkill][listitem] >= 999) return ERROR(playerid,"Vec imate taj skill na maximumu!");
		    if(GetPlayerMoney(playerid) < 10000) return ERROR(playerid,"Potrebno vam je 10000$!");
		    GivePlayerMoney(playerid,-10000);
		    PlayerInfo[playerid][pMoney] -= 10000;
			SacuvajIgraca(playerid);
		    SetPlayerPos(playerid,700.8237,145.6841,-2.7789);
		    SetPlayerFacingAngle(playerid,272.3404);
			SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid,(playerid+1));
			Freeze(playerid);
		    for(new i=0; i < 13; i++) { GetPlayerWeaponData(playerid,i,oldWeapons[playerid][i],oldAmmo[playerid][i]); }
      		ResetPlayerWeapons(playerid);
        	switch(listitem)
         	{
          		case 0: GivePlayerWeapon(playerid, 22, 1000);
            	case 1: GivePlayerWeapon(playerid, 23, 1000);
             	case 2: GivePlayerWeapon(playerid, 24, 1000);
             	case 3: GivePlayerWeapon(playerid, 25, 1000);
              	case 4: GivePlayerWeapon(playerid, 26, 1000);
               	case 5: GivePlayerWeapon(playerid, 27, 1000);
                case 6: GivePlayerWeapon(playerid, 28, 1000);
                case 7: GivePlayerWeapon(playerid, 29, 1000);
                case 8: GivePlayerWeapon(playerid, 30, 1000);
                case 9: GivePlayerWeapon(playerid, 31, 1000);
                case 10: GivePlayerWeapon(playerid, 34, 1000);
          	}
          	Trenira[playerid] = 0;
          	TreniraState[playerid] = listitem;
            streljanaobject[playerid] = CreatePlayerObject(playerid,1486, 717.27356, 145.31027, -3.63650,   0.00000, 0.00000, 0.00000);
            INFO(playerid,"Da prekinete trening upisite /prekinitreniranjeskilla");
            INFO(playerid,"Pucajte u flase ispred vas!");
            skill[playerid] = false;
            SetTimerEx("resetskill",600000,false,"d",playerid);
		}
		case DIALOG_STAN:
		{
		    if(!response) return 1;
		    if(response)
		    {
		        if(PlayerInfo[playerid][pStanID] == -1) return ERROR(playerid,"Nemate stan!");
		        switch(listitem)
		        {
		        	case 0:
		        	{
					    new id = PlayerInfo[playerid][pStanID];
						if(StanInfo[id][sLocked])
						{
					    	StanInfo[id][sLocked] = false;
					    	GameTextForPlayer(playerid,"~g~Otkljucano!",1000,3);
					    	SacuvajStan(id);
						}
				 		else if(!StanInfo[id][sLocked])
				 		{
				   			StanInfo[id][sLocked] = true;
				    		GameTextForPlayer(playerid,"~r~Zakljucano!",1000,3);
					    	SacuvajStan(id);
						}
		        	}
		        	case 1:
		        	{
                        new str[250];
					    new novac = StanInfo[PlayerInfo[playerid][pStanID]][sPrice]/2;
					    format(str,sizeof(str),""crvena"NAPOMENA: "bijela"Prije prodaje provjerite jeste li uzeli sve stvari iz vaseg stana!\n"bijela"Jeste li sigurni da zelite prodati stan za "zuta"%d$",novac);
					    ShowPlayerDialog(playerid,DIALOG_STAN7,DIALOG_STYLE_MSGBOX,""zuta""IME" - Stan:",str,"Prodaj","Odustani");
		        	}
					case 2:
					{
					    new id = PlayerInfo[playerid][pStanID];
						new str[500],or[24],or1[24],or2[24],str1[700];
						if(StanInfo[id][sOruzje][0] != -1)
						{ GetWeaponName(StanInfo[id][sOruzje][0],or,sizeof(or)); format(or,sizeof(or),"%s (%d)",or,StanInfo[id][sMunicija][0]); }
						else { or = "Nema"; }
				        if(StanInfo[id][sOruzje][1] != -1) { GetWeaponName(StanInfo[id][sOruzje][1],or1,sizeof(or1)); format(or1,sizeof(or1),"%s (%d)",or1,StanInfo[id][sMunicija][1]); }
						else { or1 = "Nema"; }
				        if(StanInfo[id][sOruzje][2] != -1) { GetWeaponName(StanInfo[id][sOruzje][2],or2,sizeof(or2)); format(or2,sizeof(or2),"%s (%d)",or2,StanInfo[id][sMunicija][2]);}
						else { or2 = "Nema"; }
						format(str,sizeof(str),""zuta"Vlasnik: "bijela"%s\n"zuta"Ime: "bijela"%s\n"zuta"Level: "bijela"%d\n"zuta"Cijena: "bijela"%d$\n"zuta"Novac: "bijela"%d$\n"zuta"Oruzje 1: "bijela"%s\n"zuta"Oruzje 2: "bijela"%s\n"zuta"Oruzje 3: "bijela"%s\n",StanInfo[id][sOwnerName],StanInfo[id][sName],StanInfo[id][sLevel],StanInfo[id][sPrice],StanInfo[id][sMoney],or,or1,or2);
						strcat(str1,str);
						format(str,sizeof(str),""zuta"Droga: "bijela"%dg\n"zuta"Mats: "bijela"%dg\n",StanInfo[id][sDroga],StanInfo[id][sMats]);
						strcat(str1,str);
						ShowPlayerDialog(playerid,DIALOG_STAN2,DIALOG_STYLE_MSGBOX,""zuta""IME" - Stan:",str1,"Ok","");
					}
					case 3:
					{
	    				ShowPlayerDialog(playerid,DIALOG_STAN5,DIALOG_STYLE_INPUT,""zuta""IME"- Stan:",""bijela"Upiste novo ime stana!","Promijeni","Odustani");
					}
					case 4:
					{
					    ShowPlayerDialog(playerid,DIALOG_STAN6,DIALOG_STYLE_LIST,""zuta""IME"- Stan:",""bijela"Uzmi novac\n"zuta"Ostavi novac\n"bijela"Uzmi oruzje\n"zuta"Ostavi oruzje\n"bijela"Uzmi oruzje 2\n"zuta"Ostavi oruzje 2\n"bijela"Uzmi oruzje 3\n"zuta"Ostavi oruzje 3\n"bijela"Uzmi drogu\n"zuta"Ostavi drogu\n"bijela"Uzmi mats\n"zuta"Ostavi mats","Dalje","Odustani");
					}
				}
				return 1;
		    }
		    return 1;
		}
        case DIALOG_STAN6:
		{
		    if(!response) return 1;
		    if(response)
			{
				if(PlayerInfo[playerid][pStanID] == -1) return ERROR(playerid,"Nemate stan!");
				new id = PlayerInfo[playerid][pStanID];
				switch(listitem)
				{
	                case 0:
					{
	        			ShowPlayerDialog(playerid,DIALOG_STAN3,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""bijela"Upisite koliko novca zelite uzeti!","Uzmi","Odustani");
					}
					case 1:
					{
	        			ShowPlayerDialog(playerid,DIALOG_STAN4,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""bijela"Upisite koliko novca zelite ostaviti u stanu!","Ostavi","Odustani");
					}
					case 2:
					{
					    new slot = 0;
					    if(StanInfo[id][sOruzje][slot] == -1) return ERROR(playerid,"Nemate oruzje na tom slotu!");
						GivePlayerWeapon(playerid,StanInfo[id][sOruzje][slot],StanInfo[id][sMunicija][slot]);
						StanInfo[id][sOruzje][slot] = -1;
						StanInfo[id][sMunicija][slot] = 0;
						SacuvajIgraca(playerid);
						SacuvajStan(id);
						INFO(playerid,"Uspjesno ste uzeli oruzje iz stana!");
					}
					case 3:
					{
					    new slot = 0;
					    if(StanInfo[id][sOruzje][slot] != -1) return ERROR(playerid,"Slot za oruzje je popunjen!");
						if(GetPlayerWeapon(playerid) <= 0) return ERROR(playerid,"Nemate oruzje!");
						StanInfo[id][sOruzje][slot] = GetPlayerWeapon(playerid);
						StanInfo[id][sMunicija][slot] = GetPlayerAmmo(playerid);
						SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
						SacuvajIgraca(playerid);
						SacuvajStan(id);
						INFO(playerid,"Uspjesno ste ostavili oruzje u stanu!");
					}
					case 4:
					{
					    new slot = 1;
					    if(StanInfo[id][sOruzje][slot] == -1) return ERROR(playerid,"Nemate oruzje na tom slotu!");
						GivePlayerWeapon(playerid,StanInfo[id][sOruzje][slot],StanInfo[id][sMunicija][slot]);
						StanInfo[id][sOruzje][slot] = -1;
						StanInfo[id][sMunicija][slot] = 0;
						SacuvajIgraca(playerid);
						SacuvajStan(id);
						INFO(playerid,"Uspjesno ste uzeli oruzje iz stana!");
					}
					case 5:
					{
					    new slot = 1;
					    if(StanInfo[id][sOruzje][slot] != -1) return ERROR(playerid,"Slot za oruzje je popunjen!");
						if(GetPlayerWeapon(playerid) <= 0) return ERROR(playerid,"Nemate oruzje!");
						StanInfo[id][sOruzje][slot] = GetPlayerWeapon(playerid);
						StanInfo[id][sMunicija][slot] = GetPlayerAmmo(playerid);
						SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
						SacuvajIgraca(playerid);
						SacuvajStan(id);
						INFO(playerid,"Uspjesno ste ostavili oruzje u stanu!");
					}
					case 6:
					{
					    new slot = 2;
					    if(StanInfo[id][sOruzje][slot] == -1) return ERROR(playerid,"Nemate oruzje na tom slotu!");
						GivePlayerWeapon(playerid,StanInfo[id][sOruzje][slot],StanInfo[id][sMunicija][slot]);
						StanInfo[id][sOruzje][slot] = -1;
						StanInfo[id][sMunicija][slot] = 0;
						SacuvajIgraca(playerid);
						SacuvajStan(id);
						INFO(playerid,"Uspjesno ste uzeli oruzje iz stana!");
					}
					case 7:
					{
					    new slot = 2;
					    if(StanInfo[id][sOruzje][slot] != -1) return ERROR(playerid,"Slot za oruzje je popunjen!");
						if(GetPlayerWeapon(playerid) <= 0) return ERROR(playerid,"Nemate oruzje!");
						StanInfo[id][sOruzje][slot] = GetPlayerWeapon(playerid);
						StanInfo[id][sMunicija][slot] = GetPlayerAmmo(playerid);
						SetPlayerAmmo(playerid, GetPlayerWeapon(playerid), 0);
						SacuvajIgraca(playerid);
						SacuvajStan(id);
						INFO(playerid,"Uspjesno ste ostavili oruzje u stanu!");
					}
					case 8:
					{
                        ShowPlayerDialog(playerid,DIALOG_STAN8,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""bijela"Upisite koliko droge zelite uzeti!","Uzmi","Odustani");
					}
					case 9:
					{
					    ShowPlayerDialog(playerid,DIALOG_STAN9,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""bijela"Upisite koliko droge zelite ostaviti u stanu!","Ostavi","Odustani");
					}
					case 10:
					{
                        ShowPlayerDialog(playerid,DIALOG_STAN10,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""bijela"Upisite koliko matsa zelite uzeti!","Uzmi","Odustani");
					}
					case 11:
					{
					    ShowPlayerDialog(playerid,DIALOG_STAN11,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""bijela"Upisite koliko matsa zelite ostaviti u stanu!","Ostavi","Odustani");
					}
				}
			}
		}
		case DIALOG_STAN3:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pStanID] == -1) return ERROR(playerid,"Nemate stan!");
			    new id = PlayerInfo[playerid][pStanID];
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_STAN3,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""bijela"Upiste koliko novca zelite uzeti!","Uzmi","Odustani");
				if(money > StanInfo[id][sMoney]) return ShowPlayerDialog(playerid,DIALOG_STAN3,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""crvena"Upisali ste previse!\n"bijela"Upisite koliko novca zelite uzeti!","Uzmi","Odustani");
				StanInfo[id][sMoney] -= money;
				GivePlayerMoney(playerid,money);
				PlayerInfo[playerid][pMoney] += money;
				INFO(playerid,"Uspjesno ste uzeli novac!");
				SacuvajStan(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_STAN4:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pStanID] == -1) return ERROR(playerid,"Nemate stan!");
			    new id = PlayerInfo[playerid][pStanID];
			    new money = strval(inputtext);
			    if(money < 1) return ShowPlayerDialog(playerid,DIALOG_STAN4,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""bijela"Upisite koliko novca zelite ostaviti u stanu!","Ostavi","Odustani");
				if(money > PlayerInfo[playerid][pMoney]) return ShowPlayerDialog(playerid,DIALOG_STAN4,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""crvena"Nemate toliko novca!\n"bijela"Upisite koliko novca zelite ostaviti u stanu!","Ostavi","Odustani");
				StanInfo[id][sMoney] += money;
				GivePlayerMoney(playerid,-money);
				PlayerInfo[playerid][pMoney] -= money;
				INFO(playerid,"Uspjesno ste ostavili novac u stanu!");
				SacuvajStan(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_STAN5:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pStanID] == -1) return ERROR(playerid,"Nemate stan!");
			    new id = PlayerInfo[playerid][pStanID];
				new text[24];
			    if(sscanf(inputtext,"s[24]",text)) return ShowPlayerDialog(playerid,DIALOG_STAN5,DIALOG_STYLE_INPUT,""zelena""zuta" - Stan:",""bijela"Upisite novo ime stana!","Promijeni","Odustani");
				strmid(StanInfo[id][sName], text, 0, strlen(text), MAX_PLAYER_NAME);
				StanLP(id);
				SacuvajStan(id);
				SacuvajIgraca(playerid);
				INFO(playerid,"Uspjesno ste promijenili ime stana!");
			}
			return 1;
		}
		case DIALOG_STAN7:
		{
		    if(!response) return 1;
		    if(PlayerInfo[playerid][pStanID] == -1) return ERROR(playerid,"Nemate stan!");
		    new id = PlayerInfo[playerid][pStanID];
			StanInfo[id][sOwned] = false;
			strmid(StanInfo[id][sOwnerName], "Drzava", 0, strlen("Drzava"), MAX_PLAYER_NAME);
			StanLP(id);
			StanInfo[id][sLocked] = true;
			new novac = StanInfo[id][sPrice]-1500;
			GivePlayerMoney(playerid,novac);
			PlayerInfo[playerid][pMoney] += novac;
			PlayerInfo[playerid][pStanID] = -1;
			SacuvajStan(id);
			SacuvajIgraca(playerid);
			INFO(playerid,"Uspjesno ste prodali stan drzavi.");
		}
		case DIALOG_STAN8:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pStanID] == -1) return ERROR(playerid,"Nemate stan!");
			    new id = PlayerInfo[playerid][pStanID];
			    new kol = strval(inputtext);
			    if(kol < 1) return ShowPlayerDialog(playerid,DIALOG_STAN8,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""bijela"Upiste koliko droge zelite uzeti!","Uzmi","Odustani");
				if(kol > StanInfo[id][sDroga]) return ShowPlayerDialog(playerid,DIALOG_STAN8,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""crvena"Upisali ste previse!\n"bijela"Upiste koliko droge zelite uzeti!","Uzmi","Odustani");
				StanInfo[id][sDroga] -= kol;
				PlayerInfo[playerid][pDroga] += kol;
				INFO(playerid,"Uspjesno ste uzeli drogu!");
				SacuvajStan(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_STAN9:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pStanID] == -1) return ERROR(playerid,"Nemate stan!");
			    new id = PlayerInfo[playerid][pStanID];
			    new kol = strval(inputtext);
			    if(kol < 1) return ShowPlayerDialog(playerid,DIALOG_STAN9,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""bijela"Upiste koliko droge zelite ostaviti u stanu!","Ostavi","Odustani");
				if(kol > PlayerInfo[playerid][pDroga]) return ShowPlayerDialog(playerid,DIALOG_STAN9,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""crvena"Nemate toliko droge!\n"bijela"Upiste koliko droge zelite ostaviti u stanu!","Ostavi","Odustani");
				StanInfo[id][sDroga] += kol;
				PlayerInfo[playerid][pDroga] -= kol;
				INFO(playerid,"Uspjesno ste ostavili drogu u kuci!");
				SacuvajStan(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_STAN10:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pStanID] == -1) return ERROR(playerid,"Nemate stan!");
			    new id = PlayerInfo[playerid][pStanID];
			    new kol = strval(inputtext);
			    if(kol < 1) return ShowPlayerDialog(playerid,DIALOG_STAN8,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""bijela"Upiste koliko matsa zelite uzeti!","Uzmi","Odustani");
				if(kol > StanInfo[id][sMats]) return ShowPlayerDialog(playerid,DIALOG_STAN8,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""crvena"Upisali ste previse!\n"bijela"Upiste koliko matsa zelite uzeti!","Uzmi","Odustani");
				StanInfo[id][sMats] -= kol;
				PlayerInfo[playerid][pMats] += kol;
				INFO(playerid,"Uspjesno ste uzeli mats!");
				SacuvajStan(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_STAN11:
		{
			if(!response) return 1;
			if(response)
			{
			    if(PlayerInfo[playerid][pStanID] == -1) return ERROR(playerid,"Nemate kucu!");
			    new id = PlayerInfo[playerid][pStanID];
			    new kol = strval(inputtext);
			    if(kol < 1) return ShowPlayerDialog(playerid,DIALOG_STAN9,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""bijela"Upiste koliko matsa zelite ostaviti u stanu!","Ostavi","Odustani");
				if(kol > PlayerInfo[playerid][pMats]) return ShowPlayerDialog(playerid,DIALOG_STAN9,DIALOG_STYLE_INPUT,""zuta""IME" - Stan:",""crvena"Nemate toliko matsa!\n"bijela"Upisite koliko matsa zelite ostaviti u stanu!","Ostavi","Odustani");
				StanInfo[id][sMats] += kol;
				PlayerInfo[playerid][pMats] -= kol;
				INFO(playerid,"Uspjesno ste ostavili mats u stanu!");
				SacuvajStan(id);
				SacuvajIgraca(playerid);
			}
			return 1;
		}
		case DIALOG_SELLSTANTO:
		{
		    if(!response)
		    {
		        PonudioS[playerid] = INVALID_PLAYER_ID; CijenaS[playerid] = 0;
		    }
		    if(response)
		    {
		        if(!strcmp(inputtext,"PRIHVATI",true))
		        {
					if(PlayerInfo[playerid][pMoney] < CijenaS[playerid])
					{
					    PonudioS[playerid] = INVALID_PLAYER_ID; CijenaS[playerid] = 0;
					    ERROR(playerid,"Nemate dovoljno novca!");
						return 1;
					}
					if(PlayerInfo[playerid][pStanID] != -1)
					{
					    PonudioS[playerid] = INVALID_PLAYER_ID; CijenaS[playerid] = 0;
					    ERROR(playerid,"Nemate dostupan slot!");
						return 1;
					}
					if(PlayerInfo[PonudioS[playerid]][pStanID] == -1)
					{
					    PonudioS[playerid] = INVALID_PLAYER_ID; CijenaS[playerid] = 0;
					    ERROR(playerid,"Igrac je vec prodao stan!");
						return 1;
					}
					if(!IsPlayerConnected(PonudioS[playerid]))
					{
					    PonudioS[playerid] = INVALID_PLAYER_ID; CijenaS[playerid] = 0;
					    ERROR(playerid,"Igrac je izasao sa servera!");
						return 1;
					}
					PlayerInfo[playerid][pStanID] = PlayerInfo[PonudioS[playerid]][pStanID];
					PlayerInfo[PonudioS[playerid]][pStanID] = -1;
					StanInfo[PlayerInfo[playerid][pStanID]][sOwnerName] = RemoveUnderLine(GetName(playerid));
					SacuvajStan(PlayerInfo[playerid][pStanID]);
					StanLP(PlayerInfo[playerid][pStanID]);
					INFO(PonudioS[playerid],"Uspjesno ste prodali stan!");
					ClearChat(playerid);
					INFO(playerid,"Uspjesno ste kupili stan!");
					INFO(playerid,"Za upravljanje stanom koristite "zuta"'/stan'"bijela".");
					GivePlayerMoney(playerid,-CijenaS[playerid]);
					PlayerInfo[playerid][pMoney] -= CijenaS[playerid];
					GivePlayerMoney(PonudioS[playerid],CijenaS[playerid]);
					PlayerInfo[PonudioS[playerid]][pMoney] += CijenaS[playerid];
                    PonudioS[playerid] = INVALID_PLAYER_ID; CijenaS[playerid] = 0;
		        }
		        else
		        {
		            PonudioS[playerid] = INVALID_PLAYER_ID; CijenaS[playerid] = 0;
		            INFO(playerid,"Niste prihvatili ponudu!");
		            return 1;
		        }
		    }
			return 1;
		}
	}
	return 1;
}
//==============================================================================
forward kick(playerid);
public kick(playerid) return Kick(playerid);
//==============================================================================
forward unfreeze(playerid);
public unfreeze(playerid)
{
	TogglePlayerControllable(playerid,1);
	return 1;
}
//==============================================================================
forward place();
public place()
{
    new sat,minu,sec;
	gettime(sat,minu,sec);
	if(bplaca) { bplaca = false; }
	if(!bplaca && minu == 0 && ServerInfo[sBiznisPlace])
	{
	    bplaca = true;
	    new str1[20];
        for(new i=0;i<MAX_BIZZ;i++)
		{
		    format(str1,sizeof(str1),BPATH,i);
		    if(fexist(str1))
		    {
				if(BiznisInfo[i][bOwned])
				{
					new money = BiznisInfo[i][bPrice]/1000;
					BiznisNovac(i,money);
				}
			}
		}
	}
	
	if(zplaca) { zplaca = false; }
	if(!zplaca && minu == 0 && ServerInfo[sZonaPlace])
	{
	    zplaca = true;
        for(new i=0;i<MAX_ZONA;i++)
		{
		    if(ZonaInfo2[i][zOrgID] != -1)
			{
			    new id = ZonaInfo2[i][zOrgID];
			    if(OrgInfo[id][oSef])
			    {
			        OrgInfo2[id][oMoney] += ZonaInfo[i][zPlaca];
			        SacuvajOrganizaciju(id);
			    }
			}
		}
	}
	return 1;
}
//==============================================================================
forward Count();
public Count()
{
	if(!countaktiviran)
	{
		KillTimer(CountTimer);
	}
	else
	{
		new str[32];
		format(str,sizeof(str),"~y~%d",countvrijeme);
		GameTextForAll(str,1000,3);
		countvrijeme--;
		if(countvrijeme <= -1)
		{
			countaktiviran = false, GameTextForAll("~g~Kreni!",1000,3);
		}
	}
	return 1;
}
//==============================================================================
forward zatvor(playerid);
public zatvor(playerid)
{
	if(!PlayerInfo[playerid][pZatvoren]) return KillTimer(ZatvorTimer[playerid]);
    PolicajacKojiGaVuce[playerid] = -1;
	PlayerInfo[playerid][pVrijeme]--;
	new str[100];
	format(str,sizeof(str),"~r~Time left: ~w~%02d seconds",PlayerInfo[playerid][pVrijeme]);
	GameTextForPlayer(playerid,str,1000,3);
	if(PlayerInfo[playerid][pVrijeme] <= 0)
	{
	    PlayerInfo[playerid][pZatvoren] = false;
	    SetPlayerPos(playerid,244.3357,67.8510,1003.6406);
		SetPlayerVirtualWorld(playerid,9);
		SetPlayerInterior(playerid,6);
		PlayerInfo[playerid][pUorg] = POLICIJA;
		Freeze(playerid);
	    KillTimer(ZatvorTimer[playerid]);
		return 1;
	}

	return 1;
}
//==============================================================================
forward respawntimer();
public respawntimer()
{
	new bool:veh[MAX_VEHICLES];
	foreach(Player,i)
	{
		if(IsPlayerInAnyVehicle(i)) { veh[GetPlayerVehicleID(i)] = true; }
	}
	new x = 0, y = 0;
	for(new v=0;v<MAX_VEHICLES;v++)
	{
	    if(x != sizeof(Prikolica))
	    {
	    	for(new i=0;i<sizeof(Prikolica);i++) { if(v == Prikolica[i]) { veh[v] = true; x++; } }
		}
		if(y != sizeof(FarmerPrikolica))
		{
		    for(new i=0;i<sizeof(FarmerPrikolica);i++) { if(v == FarmerPrikolica[i]) { veh[v] = true; y++; } }
		}
		if(!veh[v]) { SetVehicleToRespawn(v); }
	}
	respawn = 0; SCMTA(-1, ""bijela"Sva vozila su respawnonvana!");
	return 1;
}
//==============================================================================
forward kamiondzija1(playerid);
public kamiondzija1(playerid)
{
    utovar = true;
	if(!Radi[playerid]) return 1;
    SetVehiclePos(GetPlayerVehicleID(playerid), 2635.9077,-2107.1877,14.5472);
    SetVehicleZAngle(GetPlayerVehicleID(playerid), 127.9585);
    SetVehiclePos(GetVehicleTrailer(GetPlayerVehicleID(playerid)),2643.3848,-2100.6819,14.4952);
    SetVehicleZAngle(GetVehicleTrailer(GetPlayerVehicleID(playerid)), 131.0008);
    /*AddStaticVehicle(515,2635.9077,-2107.1877,14.5472,127.9585,54,77); // kamion_nakon
	AddStaticVehicle(584,2643.3848,-2100.6819,14.4952,131.0008,1,1); // prikolica_nakon*/
	TogglePlayerControllable(playerid,1);
	KamiondzijaCP[playerid] = 2;
	KamiondzijaPrikolica[playerid] = GetVehicleTrailer(GetPlayerVehicleID(playerid));
	new rand = random(sizeof(RandomKamiondzija));
	SetPlayerCheckpoint(playerid,RandomKamiondzija[rand][0],RandomKamiondzija[rand][1],RandomKamiondzija[rand][2],4.0);
	GameTextForPlayer(playerid,"~p~Idite do mjesta za istovar!",3000,3);
	return 1;
}
//==============================================================================
forward kamiondzija2(playerid);
public kamiondzija2(playerid)
{
    if(!Radi[playerid]) return 1;
    TogglePlayerControllable(playerid,1);
    KamiondzijaCP[playerid] = 3;
    GameTextForPlayer(playerid,"~p~Vratite se do posla!",3000,3);
    SetPlayerCheckpoint(playerid,2436.4338,-2104.4214,13.5469,4.0);
	return 1;
}
//------------------------------------------------------------------------------
forward loginicp(playerid);
public loginicp(playerid)
{
	if(!Ulogovan[playerid])
	{
		InterpolateCameraPos(playerid,101.4395, -2111.5193, 36.7996, 162.6619, -1841.9792, 16.9019, 30000, CAMERA_MOVE);
		InterpolateCameraLookAt(playerid, 101.6731, -2110.5420, 36.6797, 163.2137, -1841.1390, 16.8970, 30000, CAMERA_MOVE);
	}
	return 1;
}
//==============================================================================
forward gradevinar(playerid);
public gradevinar(playerid)
{
	if(!Radi[playerid]) return 1;
	TogglePlayerControllable(playerid,1);
	GradevinarCP[playerid] = 2;
 	SetPlayerCheckpoint(playerid,1274.2433,-1333.3479,14.1403,3.0);
	GameTextForPlayer(playerid,"~p~Idite do mjesta oznacenog na mapi!",3000,3);
	return 1;
}
//==============================================================================
forward gradevinar1(playerid);
public gradevinar1(playerid)
{
    gradevinarutovar[0] = true;
	if(!Radi[playerid]) return 1;
	TogglePlayerControllable(playerid,1);
	gradevinarobjects[playerid][0] = CreatePlayerObject(playerid,19380, 1275.36609, -1327.40283, 12.27528,   0.00000, 90.00000, 0.00000);
	GradevinarCP[playerid] = 3;
	SetPlayerCheckpoint(playerid,1284.1842,-1333.2246,14.1385,3.0);
	GameTextForPlayer(playerid,"~p~Idite do mjesta oznacenog na mapi!",3000,3);
	if(IsValidObject(gradevinarobject[playerid])) { DestroyObject(gradevinarobject[playerid]); }
	return 1;
}
//==============================================================================
forward gradevinar2(playerid);
public gradevinar2(playerid)
{
    gradevinarutovar[1] = true;
	if(!Radi[playerid]) return 1;
	TogglePlayerControllable(playerid,1);
	gradevinarobjects[playerid][1] = CreatePlayerObject(playerid,19380, 1285.89319, -1327.38708, 12.27528,   0.00000, 90.00000, 0.00000);
	GradevinarCP[playerid] = 4;
	SetPlayerCheckpoint(playerid,1293.2577,-1333.2360,14.1349,3.0);
	GameTextForPlayer(playerid,"~p~Idite do mjesta oznacenog na mapi!",3000,3);
	if(IsValidObject(gradevinarobject[playerid])) { DestroyObject(gradevinarobject[playerid]); }
	return 1;
}
//==============================================================================
forward gradevinar3(playerid);
public gradevinar3(playerid)
{
    gradevinarutovar[2] = true;
	if(!Radi[playerid]) return 1;
	TogglePlayerControllable(playerid,1);
	gradevinarobjects[playerid][2] = CreatePlayerObject(playerid,19380, 1293.51038, -1327.49915, 12.27528,   0.00000, 90.00000, 0.00000);
	GradevinarCP[playerid] = 0;
	if(IsValidObject(gradevinarobject[playerid])) { DestroyObject(gradevinarobject[playerid]); }
	if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][0])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][0]); }
    if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][1])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][1]); }
    if(IsValidPlayerObject(playerid,gradevinarobjects[playerid][2])) { DestroyPlayerObject(playerid,gradevinarobjects[playerid][2]); }
    SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	Radi[playerid] = false;
	new placa = JobInfo[PlayerInfo[playerid][pPosao]][jPlaca]+PlayerInfo[playerid][pStaz]*100;
	PlayerInfo[playerid][pPlaca] += placa;
 	DisablePlayerCheckpoint(playerid);
	new str[200];
	format(str,sizeof(str),"Uspjesno ste zavrsili posao i dobili %d$! Vas bonus zbog staza je %d$. Ukupno %d$!",JobInfo[PlayerInfo[playerid][pPosao]][jPlaca],(PlayerInfo[playerid][pStaz]*100),placa);
 	JOB(playerid,str);
  	PlayerInfo[playerid][pStaz]++;
  	SacuvajIgraca(playerid);
	return 1;
}
//==============================================================================
forward kopanje(playerid);
public kopanje(playerid)
{
	if(!Radi[playerid]) return KillTimer(RudarTimer[playerid]);
	ApplyAnimation(playerid, "Flowers", "Flower_attack", 4.1, 0, 0, 1, 1, 999, 1);
	Kopanje[playerid]++;
	switch(Kopanje[playerid])
	{
	    case 1: GameTextForPlayer(playerid,"~p~Kopanje..",999,3);
	    case 2: GameTextForPlayer(playerid,"~p~Kopanje...",999,3);
	    case 3: GameTextForPlayer(playerid,"~p~Kopanje.",999,3);
	    case 4: GameTextForPlayer(playerid,"~p~Kopanje..",999,3);
	    case 5: GameTextForPlayer(playerid,"~p~Kopanje...",999,3);
	    case 6: GameTextForPlayer(playerid,"~p~Kopanje.",999,3);
	    case 7: GameTextForPlayer(playerid,"~p~Kopanje..",999,3);
	    case 8: GameTextForPlayer(playerid,"~p~Kopanje...",999,3);
	    case 9: GameTextForPlayer(playerid,"~p~Kopanje.",999,3);
	    case 10: GameTextForPlayer(playerid,"~p~Kopanje..",999,3);
	    case 11: GameTextForPlayer(playerid,"~p~Kopanje...",999,3);
	    case 12: GameTextForPlayer(playerid,"~p~Kopanje.",999,3);
	    case 13: GameTextForPlayer(playerid,"~p~Kopanje..",999,3);
	    case 14: GameTextForPlayer(playerid,"~p~Kopanje...",999,3);
	    case 15:
		{
		    TogglePlayerControllable(playerid,1);
		    ClearAnimations(playerid);
            if(IsPlayerAttachedObjectSlotUsed(playerid, RUDAR_SLOT)) { RemovePlayerAttachedObject(playerid, RUDAR_SLOT); }
			RudarCP[playerid]++;
			switch(RudarCP[playerid])
			{
			    case 2: SetPlayerCheckpoint(playerid,628.3340,823.1683,-41.2857,5.0), GameTextForPlayer(playerid,"~p~Idite do sljedeceg mjesta!",3000,3);
			    case 3: SetPlayerCheckpoint(playerid,645.0747,827.7745,-41.1858,5.0), GameTextForPlayer(playerid,"~p~Idite do sljedeceg mjesta!",3000,3);
			    case 4: SetPlayerCheckpoint(playerid,663.2035,830.9849,-40.9296,5.0), GameTextForPlayer(playerid,"~p~Idite do sljedeceg mjesta!",3000,3);
			    case 5: SetPlayerCheckpoint(playerid,689.2032,843.4969,-39.0077,3.0), GameTextForPlayer(playerid,"~p~Idite do masine za ciscenje zlata!",3000,3);
			}
			Kopanje[playerid] = 0;
			KillTimer(RudarTimer[playerid]);
		}
	}
	return 1;
}
//==============================================================================
forward ztimer(playerid);
public ztimer(playerid)
{
    if(!Radi[playerid]) return KillTimer(ZavarivacTimer[playerid]);
	Zavarivac[playerid]++;
	new str[200];
	format(str,sizeof(str),"~p~Varenje %d/6",Zavarivac[playerid]);
	GameTextForPlayer(playerid,str,1000,3);
	ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 0, 0, 1, 1, 999, 1);
	if(Zavarivac[playerid] >= 6)
	{
	    ZavarivacCP[playerid]++;
	    Zavarivac[playerid] = 0;
	    TogglePlayerControllable(playerid,1);
        ClearAnimations(playerid);
	    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
	    if(IsPlayerAttachedObjectSlotUsed(playerid, ZAVARIVAC_SLOT)) { RemovePlayerAttachedObject(playerid, ZAVARIVAC_SLOT); }
		if(IsPlayerAttachedObjectSlotUsed(playerid, ZAVARIVAC1_SLOT)) { RemovePlayerAttachedObject(playerid, ZAVARIVAC1_SLOT); }
	    if(ZavarivacCP[playerid] >= 5)
	    {
            ZavarivacCP[playerid] = 0;
            Radi[playerid] = false;
   			new placa = JobInfo[PlayerInfo[playerid][pPosao]][jPlaca]+PlayerInfo[playerid][pStaz]*50;
			PlayerInfo[playerid][pPlaca] += placa;
		 	DisablePlayerCheckpoint(playerid);
			format(str,sizeof(str),"Uspjesno ste zavrsili posao i dobili %d$! Vas bonus zbog staza je %d$. Ukupno %d$!",JobInfo[PlayerInfo[playerid][pPosao]][jPlaca],(PlayerInfo[playerid][pStaz]*50),placa);
		 	JOB(playerid,str);
		  	PlayerInfo[playerid][pStaz]++;
		  	SacuvajIgraca(playerid);
	    }
	    KillTimer(ZavarivacTimer[playerid]);
	}
	return 1;
}
//==============================================================================
forward placat(playerid);
public placat(playerid)
{
	if(!Ulogovan[playerid]) return 1;
	PlayerInfo[playerid][pTime]++;
	if(PlayerInfo[playerid][pTime] >= 3600) { Placa(playerid); }
	return 1;
}
//==============================================================================
forward OnPlayerUpdateEx();
public OnPlayerUpdateEx()
{
    new str[100];
    new sec,minu,hour,day,month,year;
	gettime(hour,minu,sec);
	getdate(year,month,day);
	format(str,sizeof(str),"%02d:%02d:%02d",hour,minu,sec);
	TextDrawSetString(IgTextDraws[3],str);
	format(str,sizeof(str),"%02d/%02d/%04d",day,month,year);
	TextDrawSetString(IgTextDraws[5],str);
	
	new online1 = 0;
	foreach(Player,i)
	{
 		online1++;
 		//anti money hack
 		if(PlayerInfo[i][pMoney] != GetPlayerMoney(i))
   		{
   		    if((GetPlayerMoney(i)-PlayerInfo[i][pMoney]) > 100000)
   		    {
   		        format(str,sizeof(str),""crvena"[ANTI-CHEAT] Sumnja se da igrac %s ima money hack! Razlika u novcu +%d$.",GetName(i),(GetPlayerMoney(i)-PlayerInfo[i][pMoney]));
              	SendAdminMessage(str);
               	SendGameMasterMessage(str);
   		    }
     		ResetPlayerMoney(i);
       		GivePlayerMoney(i,PlayerInfo[i][pMoney]);
       	}
       	//anti armour hack
        new Float:armour;
		GetPlayerArmour(i,armour);
  		if(armour > 99.0 && spawned[i])
    	{
     		SetPlayerArmour(i,99.0);
       		AntiCheat[i][aArmourHack]++;
         	if(AntiCheat[i][aArmourHack] >= 3)
          	{
             	format(str,sizeof(str),""crvena"[ANTI-CHEAT] Igrac %s je kikovan zbog sumnje na armour hack!",GetName(i));
              	SendAdminMessage(str);
               	SendGameMasterMessage(str);
				Kickaj(i,str);
           	}
           	new Float:health;
			GetPlayerHealth(i,health);
	        if(health > 99.0 && spawned[i])
	        {
	            SetPlayerHealth(i,99.0);
	            AntiCheat[i][aHealthHack]++;
	            if(AntiCheat[i][aHealthHack] >= 3)
	            {
	                format(str,sizeof(str),""crvena"[ANTI-CHEAT] Igrac %s je kikovan zbog sumnje na health hack!",GetName(i));
	                SendAdminMessage(str);
	                SendGameMasterMessage(str);
                    Kickaj(i,str);
	            }
	        }
       	}
		//afk system
		new Float:xx,Float:yy,Float:zz,inte,vw;
		xx = ACX[i];
		yy = ACY[i];
		zz = ACZ[i];
		inte = ACINT[i];
		vw = ACVW[i];
		GetPlayerPos(i,ACX[i],ACY[i],ACZ[i]);
		ACINT[i] = GetPlayerInterior(i);
		ACVW[i] = GetPlayerVirtualWorld(i);
		if(ACX[i] == xx && ACY[i] == yy && ACZ[i] == zz && inte == ACINT[i] && vw == ACVW[i] && spawned[i])
		{
		    ACNUMB[i]++;
		    if(ACNUMB[i] >= 300)
		    {
		        AFK[i] = true;
		    }
		}
		else
		{
		    ACNUMB[i] = 0;
		    AFK[i] = false;
		}
		//anti pg
		new surf = GetPlayerSurfingVehicleID(i);
		if(surf != INVALID_VEHICLE_ID && GetPlayerSpeed(i,true) > 15)
		{
		    new Float:x,Float:y,Float:z;
		    GetPlayerPos(i,x,y,z);
		    SetPlayerPos(i,x+1,y+1,z+2);
		    GameTextForPlayer(i,"~r~Anti PG!",5000,3);
		}
		//anti jetpack hack
		if(GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK && PlayerInfo[i][pAdmin] < 4)
		{
  			AntiCheat[i][aJetPackHack]++;
			SetPlayerSpecialAction(i,SPECIAL_ACTION_NONE);
   			if(AntiCheat[i][aJetPackHack] >= 2)
   			{
   				format(str,sizeof(str),""crvena"[ANTI-CHEAT] Igrac %s je kikovan zbog sumnje na jetpack hack!",GetName(i));
    			SendAdminMessage(str);
     			SendGameMasterMessage(str);
				Kickaj(i,str);
			}
		}
		//anti speed hack
		new speed = GetPlayerSpeed(i,true);
		if(!IsPlayerInAnyVehicle(i))
		{
  			if(speed > 150)
	    	{
      			AntiCheat[i][aSpeedHack]++;
       			format(str,sizeof(str),""crvena"[ANTI-CHEAT] Postoji mogucnost da igrac %s(%d) koristi speed hack!",GetName(i),i);
        		SendAdminMessage(str);
         		SendGameMasterMessage(str);
			}
		}
		if(IsPlayerInAnyVehicle(i))
		{
  			new id = GetPlayerVehicleID(i);
	    	if(VoziloJeAvion(GetVehicleModel(id)) && speed > 400)
		    {
                AntiCheat[i][aSpeedHack]++;
       			format(str,sizeof(str),""crvena"[ANTI-CHEAT] Postoji mogucnost da igrac %s(%d) koristi speed hack!",GetName(i),i);
        		SendAdminMessage(str);
         		SendGameMasterMessage(str);
		    }
		    else if(VoziloJeBrod(GetVehicleModel(id)) && speed > 300)
			{
			    AntiCheat[i][aSpeedHack]++;
       			format(str,sizeof(str),""crvena"[ANTI-CHEAT] Postoji mogucnost da igrac %s(%d) koristi speed hack!",GetName(i),i);
        		SendAdminMessage(str);
         		SendGameMasterMessage(str);
   			}
		    else if(VoziloJeMotor(GetVehicleModel(id)) && speed > 250)
		    {
		        AntiCheat[i][aSpeedHack]++;
       			format(str,sizeof(str),""crvena"[ANTI-CHEAT] Postoji mogucnost da igrac %s(%d) koristi speed hack!",GetName(i),i);
        		SendAdminMessage(str);
         		SendGameMasterMessage(str);
		    }
		    else if(VoziloJeKamion(GetVehicleModel(id)) && speed > 250)
		    {
		        AntiCheat[i][aSpeedHack]++;
       			format(str,sizeof(str),""crvena"[ANTI-CHEAT] Postoji mogucnost da igrac %s(%d) koristi speed hack!",GetName(i),i);
        		SendAdminMessage(str);
         		SendGameMasterMessage(str);
		    }
		    else
		    {
				if(speed > 300)
				{
                    AntiCheat[i][aSpeedHack]++;
	       			format(str,sizeof(str),""crvena"[ANTI-CHEAT] Postoji mogucnost da igrac %s(%d) koristi speed hack!",GetName(i),i);
	        		SendAdminMessage(str);
	         		SendGameMasterMessage(str);
				}
    		}
		}
		//boje
		if(!Ulogovan[i]) { SetPlayerColor(i,0x616161FF); }
		else if(AdminDuty[i]) { SetPlayerColor(i,0xFFFF00FF); }
		else if(GameMasterDuty[i]) { SetPlayerColor(i,0x00FF00FF); }
		else if(PlayerInfo[i][pWL] >= 1) { SetPlayerColor(i,0xFD433EFF); }
		else if(PolicijaDuty[i]) { SetPlayerColor(i,0x0000FFFF); }
		else { SetPlayerColor(i,0xFFFFFFFF); }
		
		//chatbubble
		if(PlayerInfo[i][pAdmin] == 6 && PlayerInfo[i][pChatbubble]) { SetPlayerChatBubble(i, "{FFFF00}[ VLASNIK ]", 0xFF0000FF, 100.0, 1000); }
		else if(PlayerInfo[i][pAdmin] == 5 && PlayerInfo[i][pChatbubble]) { SetPlayerChatBubble(i, "{FFFF00}[ DIREKTOR ]", 0xFF0000FF, 100.0, 1000); }
		else if(PlayerInfo[i][pAdmin] == 7 && PlayerInfo[i][pChatbubble]) { SetPlayerChatBubble(i, ""plava"[ SKRIPTER ]", 0xFF0000FF, 100.0, 1000); }
		else if(PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pChatbubble]) { SetPlayerChatBubble(i, "{FFFF00}[ ADMIN ]", 0xFF0000FF, 100.0, 1000); }
		else if(PlayerInfo[i][pGameMaster] == 3 && PlayerInfo[i][pChatbubble]) { SetPlayerChatBubble(i, "{00FF00}[ VODA GAMEMASTERA ]", 0xFF0000FF, 100.0, 5000); }
  		else if(PlayerInfo[i][pGameMaster] >= 1 && PlayerInfo[i][pChatbubble]) { SetPlayerChatBubble(i, "{00FF00}[ GAMEMASTER ]", 0xFF0000FF, 100.0, 5000); }
		else if(PlayerInfo[i][pVip] >= 1 && PlayerInfo[i][pChatbubble]) { SetPlayerChatBubble(i, ""roza"[ VIP ]", 0xFF0000FF, 100.0, 1000); }
		//marama
		if(Marama[i])
		{
			foreach(Player,z)
			{
			    if(AdminDuty[z] || GameMasterDuty[z] || PolicijaDuty[i])
			    {
					ShowPlayerNameTagForPlayer(z, i, true);
				}
				else
			    {
					ShowPlayerNameTagForPlayer(z, i, false);
				}
			}
		}
		//VIP down
		if(PlayerInfo[i][pVip] >= 1 && Ulogovan[i] && spawned[i])
  		{
    		PlayerInfo[i][pVipTime]--;
			if(PlayerInfo[i][pVipTime] <= 0)
			{
				PlayerInfo[i][pVip] = 0;
				PlayerInfo[i][pVipTime] = 0;
				ShowPlayerDialog(i,DIALOG_PROMOTION,DIALOG_STYLE_MSGBOX,""roza"Info:",""crvena"Vas vip je istekao!\n"bijela"Ako mislite da je ovo greska slikajte dialog i javite se administraciji!",""roza"Ok","");
			}
   		}
	}
	
	if(Online != online1)
	{
	    Online = online1;
		if(Online > ServerInfo[sRekord])
		{
		    ServerInfo[sRekord] = Online;
		    foreach(Player,i)
		    {
		        ClearChat(i);
		        PlayerPlaySound(i, 5448, 0.0, 0.0, 0.0);
		    }
		    SCMTA(-1,""plava"["TAG"] "zelena"Zahvaljujuemo se svim igracima upravo smo postigli novi rekord!");
			format(str,sizeof(str),""plava"["TAG"] "zelena"Novi rekord je %d!",ServerInfo[sRekord]);
			SCMTA(-1,str);
			new str12[20];
			format(str12,sizeof(str12),"Rekord: %d",ServerInfo[sRekord]);
			TextDrawSetString(IgTextDraws[16],str12);
			SacuvajServer();
		}
	 	new str1[20];
		format(str1,sizeof(str1),"Online: %d",Online);
		TextDrawSetString(IgTextDraws[15],str1);
	}
	return 1;
}
//==============================================================================
forward MinuteTimer();
public MinuteTimer()
{
    UpdatePoruke();
	return 1;
}
//==============================================================================
forward updategorivo(playerid);
public updategorivo(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new speed = GetPlayerSpeed(playerid,true);
		new str[100];
		new model = GetVehicleModel(GetPlayerVehicleID(playerid));
	    if(model != modelvozila[playerid])
		{
		    PlayerTextDrawHide(playerid,brzinomjerp[1][playerid]);
	     	modelvozila[playerid] = model;
			PlayerTextDrawSetPreviewModel(playerid, brzinomjerp[1][playerid], GetVehicleModel(GetPlayerVehicleID(playerid)));
	 		PlayerTextDrawSetPreviewVehCol(playerid, brzinomjerp[1][playerid], 2, 2);
	  		PlayerTextDrawShow(playerid,brzinomjerp[1][playerid]);
		}
	 	format(str,sizeof(str),"%dkm/h",speed);
		PlayerTextDrawSetString(playerid,brzinomjerp[0][playerid],str);

		format(str,sizeof(str),"%s",GetVehicleName(GetPlayerVehicleID(playerid)));
		PlayerTextDrawSetString(playerid,brzinomjerp[2][playerid],str);

		format(str,sizeof(str),"Gorivo: %dl",Gorivo[GetPlayerVehicleID(playerid)]);
		PlayerTextDrawSetString(playerid,brzinomjerp[3][playerid],str);

		new numb = GetNumb(GetPlayerVehicleID(playerid));
		new str1[24];
		if(BenzinInfo[numb][bType] == BENZIN) { str1 = "Benzin"; }
		else if(BenzinInfo[numb][bType] == DIZEL) { str1 = "Dizel"; }
		else if(BenzinInfo[numb][bType] == EUROSUPER) { str1 = "Eurosuper"; }
		else if(BenzinInfo[numb][bType] == NEMA) { str1 = "Nema"; }
		format(str,sizeof(str),"Vrsta: %s", str1);
		PlayerTextDrawSetString(playerid,brzinomjerp[4][playerid],str);

		format(str,sizeof(str),"Potrosnja:~n~%dl - %dmin",BenzinInfo[numb][bTrosi], BenzinInfo[numb][bMin]);
		PlayerTextDrawSetString(playerid,brzinomjerp[5][playerid],str);

		if(Gorivo[GetPlayerVehicleID(playerid)] <= 0 && BenzinInfo[numb][bType] != NEMA) { GameTextForPlayer(playerid, "~r~Nemate goriva!", 1000, 1); }
	}
	else
	{
	    ShowBrzinomjer(playerid,false);
		KillTimer(updateg[playerid]);
	}
	return 1;
}
//==============================================================================
forward vozila();
public vozila()
{
	for(new i=0;i<MAX_VEHICLES;i++)
	{
	    if(IsMotorOn(i))
		{
		    new numb = GetNumb(i);
		    if(Gorivo[i] <= 0 && BenzinInfo[numb][bType] != NEMA)
   			{
				new vIDD=i,tmp_engine,tmp_lights,tmp_alarm,tmp_doors,tmp_bonnet,tmp_boot,tmp_objective;
				GetVehicleParamsEx(vIDD,tmp_engine,tmp_lights,tmp_alarm,tmp_doors,tmp_bonnet,tmp_boot,tmp_objective);
				tmp_engine = 0;
				SetVehicleParamsEx(vIDD,tmp_engine,tmp_lights,tmp_alarm,tmp_doors,tmp_bonnet,tmp_boot,tmp_objective);
			}
		    gorivotimer[i]++;
			if(gorivotimer[i] >= BenzinInfo[numb][bMin]*60 && BenzinInfo[numb][bType] != NEMA)
			{
		    	gorivotimer[i] = 0;
		    	if(IsMotorOn(i))
		    	{
		    		Gorivo[i] -= BenzinInfo[numb][bTrosi];
		    		if(Gorivo[i] < 0) { Gorivo[i] = 0; }
				}
			}
		}
	}
	return 1;
}
//==============================================================================
forward orgkapija(id);
public orgkapija(id)
{
    MoveDynamicObject(KapijaObject[id],OrgInfo[id][oKapijaX],OrgInfo[id][oKapijaY],OrgInfo[id][oKapijaZ],7);
    KapijaState[id] = 0;
	return 1;
}
//==============================================================================
forward prekinidrogaeffect(playerid);
public prekinidrogaeffect(playerid)
{
	SetPlayerWeather(playerid, 0);
	if(!koristidrogu[playerid]) return 1;
	SetPlayerDrunkLevel(playerid,0);
	koristidrogu[playerid] = false;
	return 1;
}
//==============================================================================
forward pdvratat();
public pdvratat()
{
    MoveDynamicObject(pdvrata,245.42877, 72.52780, 1002.59729,7);
    pdvratastate = false;
	return 1;
}
//==============================================================================
forward rampat();
public rampat()
{
    DestroyDynamicObject(rampa);
    rampa = CreateDynamicObject(968, 1539.96008, -1702.42566, 13.30480,   0.00000, 88.00000, 270.00000);
    rampastate = false;
	return 1;
}
//==============================================================================
forward wltimer(playerid);
public wltimer(playerid)
{
	PlayerInfo[playerid][pWL]--;
	if(PlayerInfo[playerid][pWL] <= 0)
	{
	    OcistiDosije(playerid);
	}
	else { UpdateWlPanel(playerid); }
	return 1;
}
//==============================================================================
forward vuce(playerid);
public vuce(playerid)
{
    new id = PolicajacKojiGaVuce[playerid];
    if(id == -1 || !IsPlayerConnected(id) || PlayerInfo[id][pOrgID] != POLICIJA)
    {
        PolicajacKojiGaVuce[playerid] = -1;
        KillTimer(VuceTimer[playerid]);
    }
    else
    {
		new Float:x,Float:y,Float:z;
		GetPlayerPos(id,x,y,z);
		SetPlayerPos(playerid,x,y,z);
		SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id));
		SetPlayerInterior(playerid,GetPlayerInterior(id));
		PlayerInfo[playerid][pUbizzu] = PlayerInfo[id][pUbizzu];
		PlayerInfo[playerid][pUkuci] = PlayerInfo[id][pUkuci];
		PlayerInfo[playerid][pUorg] = PlayerInfo[id][pUorg];
		PlayerInfo[playerid][pUstanu] = PlayerInfo[id][pUstanu];
	}
	return 1;
}
//==============================================================================
forward untazed(playerid);
public untazed(playerid)
{
	Tazed[playerid] = false;
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid,1);
	return 1;
}
//==============================================================================
forward CijenaRazgovora(playerid);
public CijenaRazgovora(playerid)
{
	if(PlayerInfo[playerid][pMobilniKredit] > 0)
	{
		PlayerInfo[playerid][pMobilniKredit] -= 3;
		SacuvajIgraca(playerid);
	}
	else
	{
		SCM(Razgovara[playerid], -1, ""zelena"Igrac s kojim ste pricali je prekinuo poziv!");
		SetPlayerSpecialAction(Razgovara[playerid], SPECIAL_ACTION_STOPUSECELLPHONE);
		if(IsPlayerAttachedObjectSlotUsed(Razgovara[playerid], MOBITEL_SLOT)) { RemovePlayerAttachedObject(Razgovara[playerid], MOBITEL_SLOT); }
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		if(IsPlayerAttachedObjectSlotUsed(playerid, MOBITEL_SLOT)) { RemovePlayerAttachedObject(playerid, MOBITEL_SLOT); }
		SCM(playerid, -1, ""zelena"Poziv prekinut! Nemate kredita!");
	 	Razgovara[Razgovara[playerid]] = -1;
		Razgovara[playerid] = -1;
		KillTimer(MobitelCijenaRazgovora[playerid]);
		KillTimer(MobitelCijenaRazgovora[Razgovara[playerid]]);
	}
	if(!IsPlayerConnected(Razgovara[playerid]))
	{
	    SCM(Razgovara[playerid], -1, ""zelena"Igrac s kojim ste pricali je prekinuo poziv!");
		SetPlayerSpecialAction(Razgovara[playerid], SPECIAL_ACTION_STOPUSECELLPHONE);
		if(IsPlayerAttachedObjectSlotUsed(Razgovara[playerid], MOBITEL_SLOT)) { RemovePlayerAttachedObject(Razgovara[playerid], MOBITEL_SLOT); }
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		if(IsPlayerAttachedObjectSlotUsed(playerid, MOBITEL_SLOT)) { RemovePlayerAttachedObject(playerid, MOBITEL_SLOT); }
		SCM(playerid, -1, ""zelena"Poziv prekinut! Nemate kredita!");
	 	Razgovara[Razgovara[playerid]] = -1;
		Razgovara[playerid] = -1;
		KillTimer(MobitelCijenaRazgovora[playerid]);
		KillTimer(MobitelCijenaRazgovora[Razgovara[playerid]]);
	}
	return 1;
}
//==============================================================================
forward calltimer(playerid);
public calltimer(playerid)
{
	if(Zove[playerid] != -1 && Razgovara[playerid] == -1)
	{
		Zove[playerid] = -1;
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
		if(IsPlayerAttachedObjectSlotUsed(playerid, MOBITEL_SLOT)) { RemovePlayerAttachedObject(playerid, MOBITEL_SLOT); }
		SCM(playerid, -1, ""zelena"Poziv prekinut! Igrac se nije javio");
		KillTimer(CallTimer[playerid]);
	}
	if(Razgovara[playerid] != -1) { Zove[playerid] = -1; KillTimer(CallTimer[playerid]); }
	return 1;
}
//==============================================================================
forward crnotrzistek();
public crnotrzistek()
{
    MoveDynamicObject(crnotrzistekapija,2731.35522, 2806.04370, 12.47020,7);
    crnotrzistekapijastate = false;
	return 1;
}
//==============================================================================
forward drogatimer(playerid);
public drogatimer(playerid)
{
	DrogaInfo[playerid][dIzrasla]++;
 	new str[200];
 	format(str, sizeof(str),""smeda"[DROGA]\n"zuta"Droga raste.\n"bijela"%d/5",DrogaInfo[playerid][dIzrasla]);
  	Update3DTextLabelText(DrogaText[playerid],-1,str);
	if(DrogaInfo[playerid][dIzrasla] >= 5)
	{
	    format(str, sizeof(str),""smeda"[DROGA]\n"zuta"Da uberete drogu pritisnite\n"bijela"'Y'",DrogaInfo[playerid][dIzrasla]);
  		Update3DTextLabelText(DrogaText[playerid],-1,str);
        DrogaInfo[playerid][dIzrasla] = 5;
        KillTimer(DrogaTimer[playerid]);
	}
	return 1;
}
//==============================================================================
forward RentVrijemeTimer(playerid);
public RentVrijemeTimer(playerid)
{
    RentVrijeme[playerid]--;
    if(RentVrijeme[playerid] <= 0)
	{
		if(VoziloZaRent[IdRentVozila[playerid]])
		{
	 		SetVehicleToRespawn(IdRentVozila[playerid]);
			VoziloRentano[IdRentVozila[playerid]] = false;
			RentaVozilo[playerid] = false;
			IdRentVozila[playerid] = -1;
			RentVrijeme[playerid] = 0;
			KillTimer(RentTimer[playerid]);
			SCM(playerid,-1,""crvena"Isteklo je vrijeme rentanja vase vozilo je automatski vraceno!");
		}
		else
		{
		    VoziloRentano[IdRentVozila[playerid]] = false;
			RentaVozilo[playerid] = false;
			IdRentVozila[playerid] = -1;
			RentVrijeme[playerid] = 0;
			KillTimer(RentTimer[playerid]);
			SCM(playerid,-1,""crvena"Isteklo je vrijeme rentanja vase vozilo je automatski vraceno!");
		}
	}
	if(!RentaVozilo[playerid]) return KillTimer(RentTimer[playerid]);
	return 1;
}
//==============================================================================
forward zattack(attackingorg,zoneid);
public zattack(attackingorg,zoneid)
{
    zonatime[zoneid]++;
    new str[200];
    new attackers = 0;
    foreach(Player,i)
	{
	    if(PlayerInfo[i][pOrgID] == attackingorg && IsPlayerInZone(i,zoneid))
	    {
	        format(str,sizeof(str),"~g~%d/600",zonatime[zoneid]);
	        GameTextForPlayer(i,str,1000,3);
	        attackers++;
	    }
	    else if(PlayerInfo[i][pOrgID] == ZonaInfo2[zoneid][zOrgID] && ZonaInfo2[zoneid][zOrgID] != -1 && IsPlayerInZone(i,zoneid))
	    {
	        format(str,sizeof(str),"~r~%d/600",zonatime[zoneid]);
	        GameTextForPlayer(i,str,1000,3);
	    }
	}
	if(attackers == 0)
	{
	    new d = -1;
		foreach(Player,i)
		{
		    if(PlayerInfo[i][pOrgID] == attackingorg)
			{
				d = i;
				break;
			}
		}
		if(d != -1)
		{
	    	format(str,sizeof(str),"{804000}---------------------------------------------------------------------");
			SendOrgMessage(d,str);
			format(str,sizeof(str),"{804000}Vasa organizacija nije uspijela osvojiti zonu %d!",zoneid);
			SendOrgMessage(d,str);
			format(str,sizeof(str),"{804000}---------------------------------------------------------------------");
			SendOrgMessage(d,str);
		}
		if(ZonaInfo2[zoneid][zOrgID] != -1)
		{
			d = -1;
			foreach(Player,i)
			{
			    if(PlayerInfo[i][pOrgID] == ZonaInfo2[zoneid][zOrgID])
				{
					d = i;
					break;
				}
			}
			if(d != -1)
			{
				format(str,sizeof(str),"{804000}---------------------------------------------------------------------");
				SendOrgMessage(d,str);
				format(str,sizeof(str),"{804000}Vasa organizacija je uspjesno obranila zonu %d!",zoneid);
				SendOrgMessage(d,str);
				format(str,sizeof(str),"{804000}---------------------------------------------------------------------");
				SendOrgMessage(d,str);
			}
		}
		GangZoneStopFlashForAll(zona[zoneid]);
		zonatime[zoneid] = -1;
		KillTimer(zonatimer[zoneid]);
		return 1;
	}
	if(zonatime[zoneid] >= 600)
	{
	    new d = -1;
		foreach(Player,i)
		{
		    if(PlayerInfo[i][pOrgID] == attackingorg)
			{
				d = i;
				break;
			}
		}
		if(d != -1)
		{
	    	format(str,sizeof(str),"{804000}---------------------------------------------------------------------");
			SendOrgMessage(d,str);
			format(str,sizeof(str),"{804000}Vasa organizacija je uspjesno osvojila zonu id %d!",zoneid);
			SendOrgMessage(d,str);
			format(str,sizeof(str),"{804000}---------------------------------------------------------------------");
			SendOrgMessage(d,str);
		}
		if(ZonaInfo2[zoneid][zOrgID] != -1)
		{
			d = -1;
			foreach(Player,i)
			{
			    if(PlayerInfo[i][pOrgID] == ZonaInfo2[zoneid][zOrgID])
				{
					d = i;
					break;
				}
			}
			if(d != -1)
			{
				format(str,sizeof(str),"{804000}---------------------------------------------------------------------");
				SendOrgMessage(d,str);
				format(str,sizeof(str),"{804000}Vasa organizacija nije uspjela osvojiti zonu %d!",zoneid);
				SendOrgMessage(d,str);
				format(str,sizeof(str),"{804000}---------------------------------------------------------------------");
				SendOrgMessage(d,str);
			}
		}
	    ZonaInfo2[zoneid][zOrgID] = attackingorg;
	    SacuvajZonu(zoneid);
	    GangZoneStopFlashForAll(zona[zoneid]);
	    GangZoneHideForAll(zona[zoneid]);
        GangZoneShowForAll(zona[zoneid],OrgInfo[ZonaInfo2[zoneid][zOrgID]][oColor]);
		zonatime[zoneid] = -1;
		KillTimer(zonatimer[zoneid]);
		return 1;
	}
	return 1;
}
//==============================================================================
forward bankaeksplozija(playerid);
public bankaeksplozija(playerid)
{
	if(dinamitobject[playerid] != INVALID_OBJECT_ID)
	{
	    DestroyDynamicObject(dinamitobject[playerid]);
	    dinamitobject[playerid] = INVALID_OBJECT_ID;
	    CreateExplosion(656.7759,413.2963,651.3528, 12, 10.0);
	    DestroyDynamicObject(sef);
	    sef = CreateDynamicObject(19799, 655.75177, 415.21841, 650.63159,   90.00000, 0.00000, 180.00000);
	    sefstate = true;
	    PostaviZlocin(playerid,"Banka","Provala u sef",10);
    	foreach(Player,i)
		{
			if(Ulogovan[i])
			{
  				SCM(i,-1,""bijela"--------------------------------------------------------------------------");
	    		SCM(i,-1,""crvena"U tijeku je pljacka Los Santos banke! Molimo gradane da ne prilaze banci!");
		    	SCM(i,-1,""bijela"--------------------------------------------------------------------------");
			}
		}
		bankaresettimer = SetTimer("bankareset",3600000,false);
	}
	return 1;
}
//==============================================================================
forward bankareset();
public bankareset()
{
    DestroyDynamicObject(sef);
    sef = CreateDynamicObject(19799, 655.800170, 413.851104, 651.811401, 0.000000, 0.000000, -178.700012);
    sefstate = false;
    DestroyDynamicObject(bankavrata);
    bankavrata = CreateDynamicObjectEx(19303, 658.511596, 411.794372, 651.572631, 0.000000, 0.000000, 92.199996, 300.00, 300.00);
    bankavratastate = false;
    if(iskrestate[0]) { DestroyDynamicObject(iskre[0]); }
    iskrestate[0] = false;
    if(iskrestate[1]) { DestroyDynamicObject(iskre[0]); }
	iskrestate[1] = false;
	if(iskrestate[2]) { DestroyDynamicObject(iskre[0]); }
    iskrestate[2] = false;
    if(iskrestate[3]) { DestroyDynamicObject(iskre[0]); }
    iskrestate[3] = false;
    novacpljacka[0] = false;
    novacpljacka[1] = false;
    novacpljacka[2] = false;
    novacpljacka[3] = false;
	return 1;
}
//==============================================================================
forward pljackat(playerid,id);
public pljackat(playerid,id)
{
	if(pljacka[playerid] == -1) return pljacka[playerid] = -1, KillTimer(pljackatimer[playerid]);
	if(!spawned[playerid]) return pljacka[playerid] = -1, KillTimer(pljackatimer[playerid]);
	if(id == 0 && !IsPlayerInRangeOfPoint(playerid,2.0,644.5079,424.8175,651.3528)) return ERROR(playerid,"Niste u banci!");
	else if(id == 1 && !IsPlayerInRangeOfPoint(playerid,2.0,647.5455,421.3625,651.3528)) return ERROR(playerid,"Niste u banci!");
    else if(id == 2 && !IsPlayerInRangeOfPoint(playerid,2.0,652.0234,421.5735,651.3528)) return ERROR(playerid,"Niste u banci!");
    else if(id == 3 && !IsPlayerInRangeOfPoint(playerid,2.0, 665.9907,424.8604,651.3528)) return ERROR(playerid,"Niste u banci!");
    if(novacpljacka[id]) return ERROR(playerid,"Netko je vec uzeo novac ovdje!");
    pljacka[playerid]++;
    TogglePlayerControllable(playerid,0);
    new str[200];
	format(str,sizeof(str),"~p~Kupljenje %d/6",pljacka[playerid]);
	GameTextForPlayer(playerid,str,1000,3);
    ApplyAnimation(playerid, "ROB_BANK", "CAT_Safe_Rob", 4.1, 0, 0, 1, 1, 999, 1);
    if(pljacka[playerid] >= 6)
    {
        novacpljacka[id] = true;
	    new money = (30000+random(100000));
	    GivePlayerMoney(playerid,money);
	    PlayerInfo[playerid][pMoney] += money;
		format(str,sizeof(str),"Uspjesno ste uzeli %d$!",money);
		INFO(playerid,str);
		SacuvajIgraca(playerid);
		pljacka[playerid] = -1;
		TogglePlayerControllable(playerid,1);
		ClearAnimations(playerid);
		KillTimer(pljackatimer[playerid]);
    }
	return 1;
}
//==============================================================================
forward vuce2(playerid);
public vuce2(playerid)
{
    new id = IgracKojiGaVuce[playerid];
    if(id == -1 || !IsPlayerConnected(id) || PlayerInfo[id][pOrgID] == POLICIJA || !Vezan[playerid])
    {
        IgracKojiGaVuce[playerid] = -1;
        KillTimer(IgracVuceTimer[playerid]);
    }
    else
    {
		new Float:x,Float:y,Float:z;
		GetPlayerPos(id,x,y,z);
		SetPlayerPos(playerid,x,y,z);
		SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(id));
		SetPlayerInterior(playerid,GetPlayerInterior(id));
		PlayerInfo[playerid][pUbizzu] = PlayerInfo[id][pUbizzu];
		PlayerInfo[playerid][pUkuci] = PlayerInfo[id][pUkuci];
		PlayerInfo[playerid][pUorg] = PlayerInfo[id][pUorg];
		PlayerInfo[playerid][pUstanu] = PlayerInfo[id][pUstanu];
	}
	return 1;
}
//==============================================================================
forward resetskill(playerid);
public resetskill(playerid) return skill[playerid] = true;
//==============================================================================
forward eventcount(playerid,st);
public eventcount(playerid,st)
{
	EventKaunt[playerid]--;
	new str[30];
	if(EventKaunt[playerid] == 0)
	{
		format(str,sizeof(str),"~g~Kreni",EventKaunt[playerid]);
		GameTextForPlayer(playerid,str,1000,3);
		if(st == 1) { TogglePlayerControllable(playerid,1); }
		if(EventID == 0 && !eksplozijepokrenut)
		{
		    eksplozijepokrenut = true;
		    eksplozijerandom = random(sizeof(eksplozije));
		    eksplozijestate = true;
			SetPlayerRaceCheckpoint(playerid,0,eksplozije[eksplozijerandom][0],eksplozije[eksplozijerandom][1],eksplozije[eksplozijerandom][2],0.0,0.0,0.0,10.0);
			eksplozijetimer = SetTimer("eksplozijetm",3000,true);
		}
		KillTimer(eventcounttimer[playerid]);
	}
	else
	{
		format(str,sizeof(str),"~y~%d",EventKaunt[playerid]);
		GameTextForPlayer(playerid,str,1000,3);
	}
	return 1;
}
//==============================================================================
forward eksplozijetm();
public eksplozijetm()
{
    if(EventID == -1) return KillTimer(eksplozijetimer);
	if(!EventPokrenut) return KillTimer(eksplozijetimer);
    if(eksplozijestate)
    {
		CreateExplosion(eksplozije[eksplozijerandom][0],eksplozije[eksplozijerandom][1],eksplozije[eksplozijerandom][2], 6, 2.0);
		eksplozijestate = false;
		new players = 0, id = -1;
		foreach(Player,i)
		{
	    	if(InEvent[i]) { players++; id=i; }
		}
		if(players == 1)
		{
			EventID = -1;
		    EventPokrenut = false;
			foreach(Player,i)
			{
			    if(InEvent[i])
			    {
			        DisablePlayerCheckpoint(i);
			        DisablePlayerRaceCheckpoint(i);
		        	SpawnPlayer(i);
				}
			}
			for(new i=0;i<sizeof(EventObjekti);i++)
			{
			    if(EventObjekti[i] != INVALID_OBJECT_ID)
			    {
			        DestroyDynamicObject(EventObjekti[i]);
			        EventObjekti[i] = INVALID_OBJECT_ID;
			    }
			}
			new str[100];
			format(str,sizeof(str),""zelena"Igrac %s je pobijedio u eventu Eksplozije u kavezu.(+30000$)",GetName(id));
			SCMTA(-1,str);
			GivePlayerMoney(id,30000);
			PlayerInfo[id][pMoney] += 30000;
			SacuvajIgraca(id);
			
			KillTimer(eksplozijetimer);
		}
		if(players < 1)
		{
		    EventID = -1;
		    EventPokrenut = false;
			foreach(Player,i)
			{
			    if(InEvent[i])
			    {
			        TogglePlayerControllable(i,1);
			        DisablePlayerCheckpoint(i);
			        DisablePlayerRaceCheckpoint(i);
		        	SpawnPlayer(i);
				}
			}
			for(new i=0;i<sizeof(EventObjekti);i++)
			{
			    if(EventObjekti[i] != INVALID_OBJECT_ID)
			    {
			        DestroyDynamicObject(EventObjekti[i]);
			        EventObjekti[i] = INVALID_OBJECT_ID;
			    }
			}
			KillTimer(eksplozijetimer);
		}
	}
	else
	{
		eksplozijerandom = random(sizeof(eksplozije));
  		eksplozijestate = true;
		foreach(Player,i)
		{
		    DisablePlayerCheckpoint(i);
      		DisablePlayerRaceCheckpoint(i);
			SetPlayerRaceCheckpoint(i,0,eksplozije[eksplozijerandom][0],eksplozije[eksplozijerandom][1],eksplozije[eksplozijerandom][2],0.0,0.0,0.0,10.0);
		}
	}
	return 1;
}
//============================================================================//
//						Copyright (c) 2018, Vuk                               //
//============================================================================//

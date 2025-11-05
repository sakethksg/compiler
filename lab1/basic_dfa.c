#include <stdio.h>
#include <stdlib.h>
#include <string.h>
char s[10];
char st[10][10];
char t[10][10][10];
int f[10];
int ns, nc, nf, ss;
int fs(char* n) {
for(int i = 0; i < ns; i++) {
if(strcmp(st[i], n) == 0) {
return i;
}
}
return -1;
}
int fc(char c) {
for(int i = 0; i < nc; i++) {
5
if
(
s[i] == c) {
return i;
}
}
return
-
1
;
}
int cf
(int
i) {
for
(int j
=
0; j
< nf; j++) {
if
(
f[j] == i) {
return
1
;
}
}
return
0
;
}
void pt() {
printf
(
"
\
n
");
for
(int j
=
0; j
< nc; j++) {
printf
(
"%c
",
s[j]);
}
printf
(
"
\
n
");
for
(int i
=
0; i
< ns; i++) {
printf
(
"%s
", st[i]);
for
(int j
=
0; j
< nc; j++) {
printf
(
"%s
",
t[i][j]);
if
(strlen
(
t[i][j]) ==
1) {
printf
(" ");
}
}
printf
(
"
\
n
");
}
}
int sim
(char
* in) {
int cs
= ss;
int l
= strlen(in);
printf
(
"
\
nString: %s
\
n
", in);
for
(int i
=
0; i
< l; i++) {
char cc
= in[i];
int si
= fc(cc);
if(si ==
-
1) {
printf
("Symbol not found
\
n
");
return
0
;
}
6
char* nn = t[cs][si];
if(strcmp(nn, "-") == 0) {
printf("δ[%s,%c] = REJECTED\n", st[cs], cc);
return 0;
}
int ns = fs(nn);
if(ns == -1) {
printf("Invalid state\n");
return 0;
}
printf("δ[%s,%c] = ", st[cs], cc);
cs = ns;
}
printf("%s\n", st[cs]);
if(cf(cs)) {
printf("ACCEPTED\n");
return 1;
} else {
printf("REJECTED\n");
return 0;
}
}
int main() {
printf("Enter number of states: ");
scanf("%d", &ns);
printf("Enter number of symbols: ");
scanf("%d", &nc);
printf("Enter symbols: ");
for(int i = 0; i < nc; i++) {
scanf(" %c", &s[i]);
}
printf("Enter states: ");
for(int i = 0; i < ns; i++) {
scanf("%s", st[i]);
}
printf("Enter start state index: ");
scanf("%d", &ss);
printf("Enter number of final states: ");
scanf("%d", &nf);
printf("Enter final state indices: ");
for(int i = 0; i < nf; i++) {
scanf("%d", &f[i]);
}
for(int i = 0; i < ns; i++) {
7
for(int j = 0; j < nc; j++) {
strcpy(t[i][j], "-");
}
}
printf("\nEnter transition function δ:\n");
for(int i = 0; i < ns; i++) {
for(int j = 0; j < nc; j++) {
printf("δ[%s,%c] = ", st[i], s[j]);
scanf("%s", t[i][j]);
}
}
pt();
char in[100];
printf("\nEnter string: ");
scanf("%s", in);
sim(in);
return 0;
}
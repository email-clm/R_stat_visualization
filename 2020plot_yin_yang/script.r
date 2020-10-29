# Xiaofeng Xu revised it from https://rosettacode.org/wiki/Yin_and_yang
install.packages("plotrix")
reqiure("plotrix")
plot.yin.yang <- function(x=5, y=5, r=3, s=10, add=F){
	suppressMessages(require("plotrix"))
	if(!add) plot(1:10, type="n", xlim=c(0,s), ylim=c(0,s), xlab="", ylab="", xaxt="n", yaxt="n", bty="n", asp=1)
	draw.circle(x, y, r, border="white", col= "black")
	draw.ellipse(x, y, r, r, col="white", angle=0, segment=c(90,270), arc.only=F)
	draw.ellipse(x, y - r * 0.5, r * 0.5, r * 0.5, col="black", border="black", angle=0, segment=c(90,270), arc.only=F)
	draw.circle(x, y - r * 0.5, r * 0.125, border="white", col= "white")
	draw.circle(x, y + r * 0.5, r * 0.5, col="white", border="white")
	draw.circle(x, y + r * 0.5, r * 0.125, border="black", lty=1, col= "black")
	draw.circle(x, y, r, border="black")
}
png("yin_yang.png")
plot.yin.yang()
plot.yin.yang(1,7,1, add=T)
dev.off()



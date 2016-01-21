args<-commandArgs(TRUE)

data = read.table(args[1], sep = '\t')

pdf(args[2])
hist(data[,2], main="", xlab = "Sequence length", col = "grey")
dev.off()
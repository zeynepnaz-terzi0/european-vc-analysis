library(dplyr)
setwd("C:/Users/Windows 10/Desktop")

df <- read.csv("investments_VC.csv", encoding = "latin1")
names(df) <- trimws(names(df))

eu <- c("GBR","DEU","FRA","SWE","NLD","ESP","ITA",
        "FIN","BEL","DNK","IRL","CHE","NOR","PRT","POL")
df_eu <- df %>% filter(country_code %in% eu)
nrow(df_eu) # 7297

df_eu$funding_total_usd <- as.numeric(gsub(",", "", trimws(df_eu$funding_total_usd)))
df_eu$market <- trimws(df_eu$market)
df_eu$status <- trimws(df_eu$status)

df_clean <- df_eu %>% filter(!is.na(funding_total_usd), funding_total_usd > 0)
df_clean$log_funding <- log(df_clean$funding_total_usd)
nrow(df_clean) # 5964


# univariate analysis

summary(df_clean[, c("funding_total_usd", "funding_rounds", "venture", "seed", "angel")])

sd(df_clean$funding_total_usd, na.rm = TRUE)
sd(df_clean$funding_rounds, na.rm = TRUE)
sd(df_clean$venture, na.rm = TRUE)
sd(df_clean$seed, na.rm = TRUE)
sd(df_clean$angel, na.rm = TRUE)

hist(df_clean$log_funding,
     main = "Distribution of Log Total Funding - European Startups",
     xlab = "log(Total Funding in USD)",
     col = "steelblue", border = "white", breaks = 30)

hist(df_clean$funding_rounds,
     main = "Distribution of Funding Rounds - European Startups",
     xlab = "Number of Funding Rounds",
     col = "steelblue", border = "white", breaks = 15)

barplot(sort(table(df_clean$country_code), decreasing = TRUE),
        main = "Number of Startups by Country",
        xlab = "Country", ylab = "Number of Startups",
        col = "steelblue", border = "white", las = 2)

barplot(sort(table(df_clean$market), decreasing = TRUE)[1:10],
        main = "Top 10 Sectors - European Startups",
        xlab = "Sector", ylab = "Number of Startups",
        col = "steelblue", border = "white", las = 2, cex.names = 0.7)

barplot(table(df_clean$status),
        main = "Company Status - European Startups",
        xlab = "Status", ylab = "Number of Startups",
        col = c("steelblue", "coral", "lightgreen"), border = "white")

country_funding <- df_clean %>%
  group_by(country_code) %>%
  summarise(mean_log_funding = mean(log_funding, na.rm = TRUE), n = n()) %>%
  arrange(desc(mean_log_funding))

barplot(country_funding$mean_log_funding,
        names.arg = country_funding$country_code,
        main = "Mean Log-Funding by Country",
        xlab = "Country", ylab = "Mean log(Total Funding in USD)",
        col = ifelse(country_funding$country_code == "SWE", "coral", "steelblue"),
        border = "white", las = 2)

sweden <- df_clean %>% filter(country_code == "SWE")
sweden_by_year <- as.data.frame(table(sweden$founded_year))
names(sweden_by_year) <- c("year", "count")
sweden_by_year$year <- as.numeric(as.character(sweden_by_year$year))
sweden_by_year <- sweden_by_year %>% filter(year >= 2000, year <= 2012)

plot(sweden_by_year$year, sweden_by_year$count,
     type = "l",
     main = "Swedish Startups Founded per Year (2000-2012)",
     xlab = "Year", ylab = "Number of Startups",
     col = "steelblue", lwd = 2, xaxt = "n")
axis(1, at = sweden_by_year$year)
points(sweden_by_year$year, sweden_by_year$count, col = "steelblue", pch = 16, cex = 1.2)


# bivariate analysis

num_vars <- df_clean[, c("log_funding", "funding_rounds", "venture", "seed", "angel")]
cor(num_vars, use = "complete.obs")
cov(num_vars, use = "complete.obs")

model1 <- lm(log_funding ~ funding_rounds, data = df_clean)
summary(model1)

model2 <- lm(log_funding ~ funding_rounds + seed + angel, data = df_clean)
summary(model2)

df_clean %>%
  group_by(country_code) %>%
  summarise(mean_log_funding = mean(log_funding, na.rm = TRUE), n = n()) %>%
  arrange(desc(mean_log_funding))

df_clean$market_grouped <- ifelse(
  df_clean$market %in% c("Biotechnology", "Clean Technology", "E-Commerce", "Mobile", "Software"),
  df_clean$market, "Other")

chisq.test(table(df_clean$market_grouped, df_clean$status))
table(df_clean$market_grouped, df_clean$status)

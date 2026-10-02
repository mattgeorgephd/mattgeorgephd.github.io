---
layout: post
title: Sun. Dec. 18, 2022
subtitle: ANOVA guide
gh-repo: mattgeorgephd/mattgeorgephd.github.io
gh-badge: [star, fork, follow]
tags: tutorials
comments: true
---

Link to [R markdown file](https://github.com/mattgeorgephd/mattgeorgephd.github.io/blob/9f562417b79a3fee5d32aefd11eeb46948cdfc17/guides/2022-12-18-ANOVA/ANOVA-guide.Rmd) <br/>
Link to [dataset](https://raw.githubusercontent.com/mattgeorgephd/mattgeorgephd.github.io/master/guides/2022-12-18-ANOVA/ATPase_dataset.csv)

## STEP 1: Test ANOVA assumptions

#### *ANOVA Assumptions (in order of importance):*
1. **Independence** - Data are independent (not sampled from the same individual, etc.)
2. **Normality** - The response variable (and any numeric factors) has a normal distribution
3. **Homoscedasticity** - The sample variance across factors is similar

```{R}
# Test normality; transform if necessary

# Define dataset
dat_stat <- dat_stat

# Assign factors
dat_stat$treatment  <- factor(dat_stat$treatment, levels = c("control","SS","MS"))
dat_stat$ploidy     <- factor(dat_stat$ploidy)
dat_stat$timepoint  <- factor(dat_stat$timepoint, levels = c("0","11","12","15","20"), ordered = "TRUE")

# Assign response variable
test_me <- dat_stat$ATPase

# Test for normality
qqnorm(test_me, main = "Q-Q Plot: untransformed") # check linearity
qqline(test_me)
norm_test <- shapiro.test(test_me) # p-value > 0.05 = good, don't need transformation
print(paste("shapiro test p-value, untransformed:", norm_test$p.value))

# Normalize response variable if normality test failed
if(norm_test$p.value<0.05)     {
        normalized <- bestNormalize(test_me, main = "Q-Q Plot: transformed")
        test_me <- normalized$x.t # overwrite
        qqnorm(test_me) # check linearity of transformed response
        qqline(test_me)
        norm_test <- shapiro.test(test_me) # p-value > 0.05 = good
        print(paste("shapiro test p-value, transformed:", norm_test$p.value))}
dat_stat$response <- test_me # overwrite
```

| untransformed | transformed |
| :---:  | :---: |
| ![](https://github.com/mattgeorgephd/mattgeorgephd.github.io/blob/master/guides/2022-12-18-ANOVA/QQ_untransformed.png?raw=true)  | ![](https://github.com/mattgeorgephd/mattgeorgephd.github.io/blob/master/guides/2022-12-18-ANOVA/QQ_transformed.png?raw=true) |      

## STEP 2: Run ANOVA
```{r}
# Run ANOVA
my_test <- aov(response ~ ploidy * timepoint * treatment, data = dat_stat)
my_test_summary <- summary(my_test)
summary(my_test)
```
![](https://github.com/mattgeorgephd/mattgeorgephd.github.io/blob/master/guides/2022-12-18-ANOVA/model.png?raw=true)

## STEP 3: compare model AIC scores
```{r}
# Compare model AIC scores (lowest score wins)
other <- aov(response ~ ploidy * timepoint, data = dat_stat)

model.set <- list(my_test, other)
model.names <- c("ploidy:timepoint:treatment", "ploidy:timepoint")

aictab(model.set, modnames = model.names)
```
![](https://github.com/mattgeorgephd/mattgeorgephd.github.io/blob/master/guides/2022-12-18-ANOVA/AIC.png?raw=true)

## STEP 4: Check for Homoscedasticity across factors in model
```{r}
leveneTest(response ~ interaction(ploidy,timepoint,treatment), dat_stat)
```
![](https://github.com/mattgeorgephd/mattgeorgephd.github.io/blob/master/guides/2022-12-18-ANOVA/homogeneity.png?raw=true)

## STEP 5: Run post-hoc test if interaction is significant
```{r}
tx <- with(dat_stat, interaction(timepoint,treatment,ploidy)) # build interaction
amod <- aov(response ~ tx, data = dat_stat) # run model
mult_comp <- HSD.test(amod, "tx", group=TRUE, console=TRUE) # run HSD test
```
![](https://github.com/mattgeorgephd/mattgeorgephd.github.io/blob/master/guides/2022-12-18-ANOVA/HSD.png?raw=true)

Link to [AOV model output](https://raw.githubusercontent.com/mattgeorgephd/mattgeorgephd.github.io/master/guides/2022-12-18-ANOVA/aov.csv) <br/>
Link to [HSD output](https://raw.githubusercontent.com/mattgeorgephd/mattgeorgephd.github.io/master/guides/2022-12-18-ANOVA/HSD.csv)


## STEP 6: Plot w/ group labels
![](https://github.com/mattgeorgephd/mattgeorgephd.github.io/blob/master/guides/2022-12-18-ANOVA/atpase_suppl.png?raw=true)

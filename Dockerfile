
# Use R version 4.5.2
FROM rocker/r-ver:4.5.2

# Install Linux libraries needed by R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libtiff-dev \
    libuv1-dev \
    libsodium-dev \
    pandoc \
    && rm -rf /var/lib/apt/lists/*

# Install rmarkdown and its dependencies
RUN R -e "install.packages('rmarkdown', repos='https://cloud.r-project.org'); stopifnot(requireNamespace('rmarkdown', quietly=TRUE))"

# Install packages needed for the API and model
RUN R -e "install.packages(c('plumber', 'tidymodels', 'ranger'), repos='https://cloud.r-project.org'); stopifnot(all(vapply(c('plumber', 'tidymodels', 'ranger'), requireNamespace, logical(1), quietly=TRUE)))"

# Set the working directory
WORKDIR /app

# Copy the API file and trained Random Forest model
COPY api.R /app/api.R
COPY models/random_forest_model.rds /app/models/random_forest_model.rds

# Expose port 8000
EXPOSE 8000

# Start the Plumber API
CMD ["R", "-e", "plumber::pr('/app/api.R') |> plumber::pr_run(host='0.0.0.0', port=8000)"]

#' @export
define_latent_growth_curve_model = function(df, variable_of_interest_name, model_type, model_strength = "CONFIGURAL", unconstrained_parcel_indices = c(), slope_weights=c()){
  slope_weights_provided = length(slope_weights) > 0
  slope_weights_to_pass = if(slope_weights_provided) {
    slope_weights
  } else {
    base=c(0)
    tail = sapply(2:length(df[,1]), function(e) {NA})
    append(base,tail)
    base
  }

  is_weak <- model_strength == "WEAK"
  is_strong <- model_strength == "STRONG" || model_strength == "PARTIAL_STRONG"
  is_strict <- model_strength == "STRICT"

  include_slope = model_type == "LINEAR" || model_type == "LATENT_BASIS"
  paste0(
    "# Define factors\n\n",
    define_factors(df, is_weak || is_strong || is_strict),
    "\n\n# Intercepts\n",
    define_intercepts(df, is_strong || is_strict, unconstrained_parcel_indices),
    "\n\n# Unique variances and covariances\n",
    define_variances(df, is_strict),
    "\n\n",
    define_covariances(df),
    "\n\n# Latent variable means\n",
    define_latent_variable_means(df),
    "\n\n# Latent variable variances and covariances\n",
    define_latent_variable_variances(df),
    "\n\n# Level factor loadings\n",
    define_level_factor(df, variable_of_interest_name),
    if(include_slope) "\n\n# Slope factor loadings\n" else "",
    if(include_slope) define_slope_factor(df, variable_of_interest_name, slope_weights_to_pass) else "",
    "\n\n# Means\n",
    define_means(variable_of_interest_name, include_slope),
    "\n\n# Variances\n",
    define_level_slope_variances(variable_of_interest_name, include_slope)
  )
}
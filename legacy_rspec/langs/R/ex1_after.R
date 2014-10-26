if (base::getRversion() >= "2.15.1") {
  utils::globalVariables(c("county.fips", "long", "lat", "group", "value", "label", "zipcode", "longitude", "latitude", "value"))
}

bind_df_to_zip_map = function(df)
{
  stopifnot(c("region", "value") %in% colnames(df))
  df = rename(df, replace=c("region" = "zip"))

  data(zipcode, package="zipcode", envir=environment())
  choropleth = merge(zipcode, df, all.x=F, all.y=T);

  choropleth = choropleth[choropleth$longitude < -10, ]
}

print_zip_choropleth = function(choropleth.df, states, scaleName, theme, min, max)
{
  stopifnot(states %in% state.abb)

a = c(1, 3, 4)

  state.df = subset_map("state", states)
  colnames(state.df)[names(state.df) == "long"] = "longitude"
  colnames(state.df)[names(state.df) == "lat"]  = "latitude"
  state.df = arrange(state.df, group, order);

  if (is.numeric(choropleth.df$value))
  {
    ggplot(choropleth.df, aes(x=longitude, y=latitude, color=value)) +
      geom_point() +
      scale_color_continuous(scaleName, labels=comma) +
      geom_polygon(data = state.df, color = "black", fill = NA, size = 0.2, aes(group=group)) +
      theme;
  } else {
    stopifnot(length(unique(na.omit(choropleth.df$value))) <= 9)
    ggplot(choropleth.df, aes(x=longitude, y=latitude, color=value)) +
      geom_point() +
      scale_colour_brewer(scaleName, labels=comma) +
      geom_polygon(data = state.df, color = "black", fill = NA, size = 0.2, aes(group=group)) +
      theme;
  }
}

render_zip_choropleth = function(choropleth.df, title="", scaleName="", states=state.abb, renderAsInsets=TRUE)
{
  choropleth.df = choropleth.df[choropleth.df$state %in% states, ]

  min_val = 0
  max_val = 0
  if (is.numeric(choropleth.df$value))
  {
    min_val = min(choropleth.df$value)
    max_val = max(choropleth.df$value)
  }

  if (length(states) == length(state.abb) &&
        states == state.abb &&
        renderAsInsets)
  {
    alaska.df     = choropleth.df[choropleth.df$state=="AK",]
    alaska.ggplot = print_zip_choropleth(alaska.df, "AK", "", theme_inset(), min_val, max_val)
    alaska.grob   = ggplotGrob(alaska.ggplot)

    hawaii.df     = choropleth.df[choropleth.df$state=="HI",]
    hawaii.ggplot = print_zip_choropleth(hawaii.df, "HI", "", theme_inset(), min_val, max_val)
    hawaii.grob   = ggplotGrob(hawaii.ggplot)

    choropleth.df = choropleth.df[!choropleth.df$state %in% c("AK", "HI"), ]
    choropleth = print_zip_choropleth(choropleth.df, setdiff(state.abb, c("AK", "HI")), scaleName, theme_clean(), min_val, max_val) + ggtitle(title)

    choropleth = choropleth +
      annotation_custom(grobTree(hawaii.grob), xmin=-107.5, xmax=-102.5, ymin=25, ymax=27.5) +
      annotation_custom(grobTree(alaska.grob), xmin=-125, xmax=-110, ymin=22.5, ymax=30)

  } else {
    choropleth = print_zip_choropleth(choropleth.df, states, scaleName, theme_clean(), min_val, max_val) + ggtitle(title)
  }

  choropleth
}

zip_choropleth_auto = function(df, num_buckets = 9, title = "", scaleName = "", states, renderAsInsets)
{
  df = clip_df(df, "zip", states)
  df = discretize_df(df, num_buckets)

  choropleth.df = bind_df_to_zip_map(df)
  render_zip_choropleth(choropleth.df, title, scaleName, states, renderAsInsets)
}

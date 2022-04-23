# importing useful libraries
library(dplyr)
library(arules)
library(visNetwork)
library(arulesViz)
library(plotly)
library(igraph)

# importing the result file developed from running 'a_rules.ipynb' on grocery orders
df1 = read.csv(file.choose())
df2 = df1[,1:2]

# defining the unique nodes and edges for the graph
df_nds = data.frame("BP" = as.character(c(df2[,"Antecedent"], df2[,"Consequent"])))
df_nds = data.frame("BP" = unlist(df2, use.names = F))
nds = unique(df_nds)

nods = data.frame(id = nds$BP, label = nds$BP, title = nds$BP) %>% arrange(id)
edgs = data.frame(from = df2$Antecedent[], to = df2$Consequent[])

# developing the network graph
visNetwork(nods, edgs, height = '1000px', width = '100%', main = 'Products Purchased', size = 5) %>%
  visIgraphLayout(layout = "layout_in_circle") %>%
  visNodes(size = 10) %>%
  visLegend() %>%
  visEdges(smooth = F) %>%
  visOptions(highlightNearest = list(enabled = T, hover = T), nodesIdSelection = T, collapse = T, manipulation =  T) %>%
  visInteraction(tooltipDelay = 0) %>%
  visPhysics(solver = "barnesHut", maxVelocity = 1, forceAtlas2Based = list(gravitationalConstant = -20))

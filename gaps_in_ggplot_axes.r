
gap_y_axis_to_zero <- function(input_grob,y_data,good_breaks,choice_var,gap_break) {
  #input_grob= the input grob to which you want to add the break
  #y_data= the data of the y axis
  #good_breaks: deafaults to the output of pretty with n=3. Otherwise you can put in your desired breaks. You can mess with the first one to move the fake zero up or down
  #choice_var: defaults to 2.5. You can change to move fake zero up or down.
  
  if (missing(good_breaks)){good_breaks=base::pretty(y_data, n = 3)}
  if (missing(choice_var)){choice_var=1.35}
  if (missing(gap_break)){gap_break=10}
  
  #  fake_zero=min(x_data,na.rm=TRUE)-choice_var*sd(x_data,na.rm=TRUE)
  fake_zero=good_breaks[1]-choice_var*(good_breaks[2]-good_breaks[1])
  middler=fake_zero+(good_breaks[1]-fake_zero)/2
  gap_length=(good_breaks[2]-good_breaks[1])/gap_break
  minner=middler-gap_length
  maxex=middler+gap_length
  
  gline = linesGrob(y = c(0, 1),x = c(-.015, .015),  gp = gpar(col = "black", lwd = 1.5)) 
  
  output_grob<-input_grob+scale_y_continuous(limits = c(fake_zero,good_breaks[length(good_breaks)]+(choice_var*(good_breaks[2]-good_breaks[1])/2)), expand = c(0,0),  breaks = c(fake_zero, good_breaks), labels = c("", as.character(good_breaks))) + 
    theme(axis.line.y = element_blank())+
    annotation_custom(gline, ymin=middler, ymax=maxex, xmin=-Inf, xmax=Inf) + 
    annotation_custom(gline, ymin=minner, ymax=middler, xmin=-Inf, xmax=Inf)+
    annotate(geom = "segment", x = -Inf, xend = -Inf, y = maxex-gap_length/2, yend = Inf,size=0.55) +
    annotate(geom = "segment", x = -Inf, xend = -Inf, y = fake_zero, yend = minner+gap_length/2,size=0.55)+
    coord_cartesian(expand=T, clip = "off")
  
  #coord_cartesian(xlim = c(0, xlim_max),ylim=c(fake_zero,max(good_breaks)),expand=F, clip = "off")
  
  return(output_grob)
}

gap_x_axis_to_zero <- function(input_grob,x_data,good_breaks,choice_var,gap_break) {
  #input_grob= the input grob to which you want to add the break
  #x_data= the data of the x axis
  #good_breaks: deafaults to the output of pretty with n=3. Otherwise you can put in your desired breaks. You can mess with the first one to move the fake zero up or down
  #choice_var: defaults to 2.5. You can change to move fake zero up or down.
  
  if (missing(good_breaks)){good_breaks=base::pretty(x_data, n = 3)}
  if (missing(choice_var)){choice_var=1.35}
  if (missing(gap_break)){gap_break=10}
  
  #fake_zero=min(x_data,na.rm=TRUE)-choice_var*sd(x_data,na.rm=TRUE)
  fake_zero=good_breaks[1]-choice_var*(good_breaks[2]-good_breaks[1])
  
  middler=fake_zero+(good_breaks[1]-fake_zero)/2
  gap_length=(good_breaks[2]-good_breaks[1])/gap_break
  minner=middler-gap_length
  maxex=middler+gap_length
  
  gline = linesGrob(x = c(0, 1),y = c(-.015, .015),  gp = gpar(col = "black", lwd = 1.5)) 
  
  output_grob<-input_grob+scale_x_continuous(limits = c(fake_zero,good_breaks[length(good_breaks)]+(choice_var*(good_breaks[2]-good_breaks[1])/2)), expand = c(0,0), 
                                             breaks = c(fake_zero, good_breaks), labels = c("", as.character(good_breaks))) + 
    theme(axis.line.x = element_blank())+
    annotation_custom(gline, xmin=middler, xmax=maxex, ymin=-Inf, ymax=Inf) + 
    annotation_custom(gline, xmin=minner, xmax=middler, ymin=-Inf, ymax=Inf)+
    annotate(geom = "segment", y = -Inf, yend = -Inf, x = maxex-gap_length/2, xend = Inf,size=0.55) +
    annotate(geom = "segment", y = -Inf, yend = -Inf, x = fake_zero, xend = minner+gap_length/2,size=0.55)+
    coord_cartesian(expand=T, clip = "off")
  
  return(output_grob)
}

good_breaks<-pretty(y_data,3)
input_grob<-gap_y_axis_to_zero(input_grob,y_data,breaks_choice)

clear
Controller
Controller_Female
distro = [big_mu', big_mu_f'];
boxchart(distro,'MarkerStyle','o','MarkerColor','r')
set(gca,'XTickLabel',{'Male','Female'})
title('Distribution By Gender')
hold on
plot([mean(big_mu),mean(big_mu_f)],'*m')
hold off

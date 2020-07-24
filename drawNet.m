function drawNet(W)

    for k=1:size(W, 1)
        for l=1:size(W, 2)

            if(k-1 > 0)
                plot([W(k,l,1); W(k-1,l,1)],[W(k,l,2);W(k-1,l,2)], 'red','LineWidth',1);
            end
            if (k+1 < size(W,1))
                plot([W(k,l,1); W(k+1,l,1)],[W(k,l,2);W(k+1,l,2)], 'red', 'LineWidth',1);
            end
            if(l-1 > 0)
                plot([W(k,l,1); W(k,l-1,1)],[W(k,l,2);W(k,l-1,2)], 'red', 'LineWidth',1);
            end
            if(l+1 <size(W,2))
                plot([W(k,l,1); W(k,l+1,1)],[W(k,l,2);W(k,l+1,2)], 'red', 'LineWidth',1);
            end
        end
    end

end


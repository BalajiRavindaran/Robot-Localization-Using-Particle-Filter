function [weight] = FunctionSensorModelBeamBasedModel(robotData, mapData, lazerScans)

    occupied_grid = mapData;

    robotLazerX = robotData(1, 1) + 25*(cos(robotData(1, 3)));
    robotLazerY = robotData(1, 2) + 25*(sin(robotData(1, 3)));
    robotLazerTheta = robotData(1, 3);

    %robotLazerX = lazerScans(1, 1);
    %robotLazerY = lazerScans(1, 2);
    %robotLazerTheta = lazerScans(1, 3);

    slope = tan(robotLazerTheta);

    x = robotLazerX;
    y = robotLazerY;
    
    xOccupied = 0;
    yOccupied = 0;

    lazerHit = false;
    while ~lazerHit
        if slope<1
            x = x + 4;
            y = y + 4*(slope);
        elseif slope>1
            y = y + 4;
            x = x + (4/slope);
        end

        xCell = floor(x/4);
        yCell = floor(y/4);

        if xCell > 0 && xCell <= size(occupied_grid, 2) && yCell > 0 && yCell <= size(occupied_grid, 1)
            if occupied_grid(yCell, xCell) == 1
                lazerHit = true;

                xOccupied = x;
                yOccupied = y;
             
                break;
            end
        else
            % Out of bounds
            lazerHit = true;
        end
    end

    zExp = sqrt(((xOccupied - robotLazerX)^2) + ((yOccupied - robotLazerY)^2));

    probProdcuts = [];

    for i = 1:size(lazerScans, 2)
        pHit = (2/(erf((8000-zExp)/(sqrt(2)*5))-erf((-zExp)/(sqrt(2)*5))))*(1/(sqrt(2*pi*(5^2))))*exp((-1/2)*(((lazerScans(1, i)-zExp)^2)/(5^2)));
        
        if (lazerScans(1, i)>zExp)
            pShort = 0;
        else
            pShort = (0.1*exp(-0.1*(lazerScans(1, i))))/(1-(0.1*exp(-0.1*zExp)));
        end

        if (lazerScans(1, i)~=zExp || lazerScans(1, i)<8000)
            pMax = 0;
        else
            pMax = 8000;
        end

        pRand = 1/8000;

        pProduct =(0.9*pHit) + (0.09*pShort) + (0.01*pMax) + (0.001*pRand);
        probProdcuts = [probProdcuts; pProduct];
    end
    
    currentWeight = 1;

    for i = 1:size(probProdcuts, 1)
        if (probProdcuts(i, 1) ~= 0) || (probProducts(i, 1) > 0.005)
            currentWeight = currentWeight*probProdcuts(i, 1);
        end
    end

    weight = currentWeight;
end
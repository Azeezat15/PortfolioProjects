Select* 
From PortfolioProject.dbo.NashvilleHousing 


-- standardize Data

Select SaleDate, CONVERT(Date, SaleDate)
From PortfolioProject.dbo.NashvilleHousing 

Update NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing 
SET SaleDateConverted = CONVERT(Date, SaleDate)

--TO populate Property Address Data 

Select PropertyAddress
From PortfolioProject.dbo.NashvilleHousing
Where PropertyAddress IS NULL


Select *
From PortfolioProject.dbo.NashvilleHousing
Where PropertyAddress IS NULL
Order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND A.[UniqueID] <> B.[UniqueID]
Where a.PropertyAddress IS NUll 



Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND A.[UniqueID] <> b.[UniqueID]
Where a.PropertyAddress IS NUll 



--- Breaking Address, City , State into individual Columns
Select PropertyAddress
From PortfolioProject.dbo.NashvilleHousing


SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)) as Address
--CHARINDEX(',', PropertyAddress)

From PortfolioProject.dbo.NashvilleHousing



SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)) as Address,
CHARINDEX(',', PropertyAddress)

From PortfolioProject.dbo.NashvilleHousing


SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address


From PortfolioProject.dbo.NashvilleHousing


ALTER TABLE  PortfolioProject.dbo.NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousing 
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousing 
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


Select* 
From PortfolioProject.dbo.NashvilleHousing 



Select OwnerAddress
From PortfolioProject.dbo.NashvilleHousing 



Select 
PARSENAME(REPLACE(OwnerAddress,',', ',') , 3)
,PARSENAME(REPLACE(OwnerAddress,',', ',') , 2)
,PARSENAME(REPLACE(OwnerAddress,',', ',') , 1)
From PortfolioProject.dbo.NashvilleHousing 




ALTER TABLE  PortfolioProject.dbo.NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousing 
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',', ',') , 3) 


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousing 
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',', ',') , 2)


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update PortfolioProject.dbo.NashvilleHousing 
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',', ',') , 1)


Select* 
From PortfolioProject.dbo.NashvilleHousing 


----Changing Yes And No To Y and N in Field, Sold as Vacant------------------

SELECT Distinct (SoldAsVacant), COUNT(SoldAsVacant)
From PortfolioProject.dbo.NashvilleHousing 
Group by SoldAsVacant
order by 2


Select SoldAsVacant, 
CASE When SoldAsVacant = 'Y' THEN 'Yes'
	When SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END
From PortfolioProject.dbo.NashvilleHousing 


Update PortfolioProject.dbo.NashvilleHousing
SET SoldAsVacant= CASE When SoldAsVacant = 'Y' THEN 'Yes'
	When SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
	END



	----Remove Duplicates 
WITH RowNumCTE AS(
	Select *,
	ROW_NUMBER() OVER(

	PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				ORDER BY 
				UniqueID
				) row_num


	From PortfolioProject.dbo.NashvilleHousing 
	--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress


--DELETE 
--From RowNumCTE
--Where row_num > 1
----Order by PropertyAddress

--DELETE Invalid Columns

Select* 
From PortfolioProject.dbo.NashvilleHousing 


ALTER TABLE PortfolioProject.dbo.NashvilleHousing 
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE PortfolioProject.dbo.NashvilleHousing 
DROP COLUMN SaleDate
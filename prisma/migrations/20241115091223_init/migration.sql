-- CreateEnum
CREATE TYPE "Role" AS ENUM ('CUSTOMER', 'CHEF', 'ADMIN');

-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('PLACED', 'IN_PREPARATION', 'DELIVERED');

-- CreateTable
CREATE TABLE "User" (
    "_id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "role" "Role" NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "ChefProfile" (
    "_id" TEXT NOT NULL,
    "bio" TEXT,
    "location" TEXT NOT NULL,
    "contact" TEXT NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ChefProfile_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "Cuisine" (
    "_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "country" TEXT NOT NULL,

    CONSTRAINT "Cuisine_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "ChefCuisine" (
    "_id" TEXT NOT NULL,
    "chefProfileId" TEXT NOT NULL,
    "cuisineId" TEXT NOT NULL,

    CONSTRAINT "ChefCuisine_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "Dish" (
    "_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "cuisineId" TEXT NOT NULL,
    "chefProfileId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Dish_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "Order" (
    "_id" TEXT NOT NULL,
    "status" "OrderStatus" NOT NULL DEFAULT 'PLACED',
    "specialRequest" TEXT,
    "totalAmount" DOUBLE PRECISION NOT NULL,
    "customerId" TEXT NOT NULL,
    "chefProfileId" TEXT NOT NULL,
    "dishId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "Review" (
    "_id" TEXT NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "customerId" TEXT NOT NULL,
    "chefProfileId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "Chat" (
    "_id" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "sentAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "customerId" TEXT NOT NULL,
    "chefProfileId" TEXT NOT NULL,

    CONSTRAINT "Chat_pkey" PRIMARY KEY ("_id")
);

-- CreateTable
CREATE TABLE "Admin" (
    "_id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "ChefProfile_userId_key" ON "ChefProfile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Cuisine_name_country_key" ON "Cuisine"("name", "country");

-- CreateIndex
CREATE UNIQUE INDEX "ChefCuisine_chefProfileId_cuisineId_key" ON "ChefCuisine"("chefProfileId", "cuisineId");

-- CreateIndex
CREATE UNIQUE INDEX "Admin_userId_key" ON "Admin"("userId");

-- AddForeignKey
ALTER TABLE "ChefProfile" ADD CONSTRAINT "ChefProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ChefCuisine" ADD CONSTRAINT "ChefCuisine_chefProfileId_fkey" FOREIGN KEY ("chefProfileId") REFERENCES "ChefProfile"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ChefCuisine" ADD CONSTRAINT "ChefCuisine_cuisineId_fkey" FOREIGN KEY ("cuisineId") REFERENCES "Cuisine"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dish" ADD CONSTRAINT "Dish_cuisineId_fkey" FOREIGN KEY ("cuisineId") REFERENCES "Cuisine"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dish" ADD CONSTRAINT "Dish_chefProfileId_fkey" FOREIGN KEY ("chefProfileId") REFERENCES "ChefProfile"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "User"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_chefProfileId_fkey" FOREIGN KEY ("chefProfileId") REFERENCES "ChefProfile"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_dishId_fkey" FOREIGN KEY ("dishId") REFERENCES "Dish"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "User"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Review" ADD CONSTRAINT "Review_chefProfileId_fkey" FOREIGN KEY ("chefProfileId") REFERENCES "ChefProfile"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Chat" ADD CONSTRAINT "Chat_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "User"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Chat" ADD CONSTRAINT "Chat_chefProfileId_fkey" FOREIGN KEY ("chefProfileId") REFERENCES "ChefProfile"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Admin" ADD CONSTRAINT "Admin_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("_id") ON DELETE RESTRICT ON UPDATE CASCADE;
